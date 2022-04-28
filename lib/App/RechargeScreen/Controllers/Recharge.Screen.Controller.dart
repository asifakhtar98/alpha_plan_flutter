import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';
import 'package:ntp/ntp.dart';
import 'package:powerbank/App/UserPersonalInfo/User.Personal.Info.Screen.dart';
import 'package:powerbank/Constants/Colors.dart';
import 'package:powerbank/Constants/strings.dart';
import 'package:powerbank/GetxStreams/Wallet.Value.Stream.dart';
import 'package:powerbank/HelperClasses/Server.Stats.Service.dart';
import 'package:powerbank/HelperClasses/SpamZone.dart';
import 'package:powerbank/HelperClasses/date_time_formatter.dart';
import 'package:powerbank/HelperClasses/small_services.dart';

import '../Recharge.Screen.dart';

class RechargeScreenController extends GetxService {
  Rx<int> selectedStackIndex = 0.obs;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Rx<int> selectedDCoin = 1000.obs;

  RxString lastRechargeRefNo = "---- Waiting for a transaction ----".obs;
  RxString fullName = ''.obs;
  RxString primaryEmail = ''.obs;
  final _hiveBox = Hive.box(hiveBoxName);
  ///////////////////////////
  bool directUpiEnabled = true;
  bool razorpayEnabled = true;
  bool cashfreeEnabled = true;

  RxInt maxCustomAmount = 15000.obs;
  List adminUpi = [];
  List cashfreeKeys = [];
  List razorPayKeys = [];
  ////////////////////////////
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  getAllLiveRechargingData() async {
    DocumentSnapshot permissions = await _firestore
        .collection(FireString.globalSystem)
        .doc(FireString.appRechargePermissions)
        .get();
    directUpiEnabled = permissions[FireString.directUpiEnabled];
    razorpayEnabled = permissions[FireString.razorpayEnabled];
    cashfreeEnabled = permissions[FireString.cashfreeEnabled];
    maxCustomAmount.value = permissions[FireString.maxCustomAmount];
    adminUpi.assignAll(permissions[FireString.adminUpi]);
    razorPayKeys.assignAll(permissions[FireString.razorPayKeys]);
    cashfreeKeys.assignAll(permissions[FireString.cashfreeKeys]);
    print(
        'directUpiEnabled: $directUpiEnabled, razorpayEnabled: $razorpayEnabled, cashfreeEnabled: $cashfreeEnabled, maxCustomAmount: $maxCustomAmount, adminUpi: $adminUpi, cashfreeKeys: $cashfreeKeys, razorPayKeys: $razorPayKeys');
    assignAllDepositMethods();
  }

  //////////////////////////
  Future<bool> checkEmailAndFullName() async {
    String mNo = await _hiveBox.get(FireString.mobileNo);
    var pEmail = await _hiveBox.get(FireString.primaryEmail);
    var fName = await _hiveBox.get(FireString.fullName);
    // print("$mNo $pEmail $fName");
    if (pEmail == null || fName == null || !pEmail.toString().contains("@")) {
      var userData = await _firestore
          .collection(FireString.accounts)
          .doc(mNo)
          .collection(FireString.personalInfo)
          .doc(FireString.document1)
          .get();
      try {
        fullName.value = userData.get(FireString.fullName) ?? "NoName_$mNo";
        primaryEmail.value =
            userData.get(FireString.primaryEmail) ?? "NoEmail$mNo@gmail.com";
        _hiveBox.put(FireString.fullName, fullName.value);
        _hiveBox.put(FireString.primaryEmail, primaryEmail.value);
        return true;
      } catch (e) {
        SmartDialog.show(
            alignmentTemp: Alignment.center,
            widget: Container(
              padding: const EdgeInsets.all(8),
              width: Get.width - 100,
              height: 100,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [color4, color3.withBlue(150)]),
                borderRadius: BorderRadius.circular(20),
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Full Name & Email Is Required',
                      style: TextStyle(color: Colors.white)),
                  TextButton(
                      onPressed: () {
                        SmartDialog.dismiss(status: SmartStatus.dialog);
                        Get.to(UserPersonalInfoScreen());
                      },
                      child: const Text("Continue"))
                ],
              ),
            ),
            isLoadingTemp: false);
        return false;
      }
    } else {
      try {
        primaryEmail.value = pEmail;
        fullName.value = fName;
        return true;
      } catch (e) {
        SmartDialog.showToast('Fill all information here');
        Get.to(UserPersonalInfoScreen());
        return false;
      }
    }
  }

  ////////////////////////
  void updateDCoinAfterRecharge({required int amountToAdd}) async {
    DateTime currentDateTime = await NTP.now();

    String mNo = await _hiveBox.get(FireString.mobileNo);
    //TODO: Complicating The Payment Order Id By Attaching 4 Digit Random Number
    lastRechargeRefNo.value =
        "${lastRechargeRefNo.value}${Random().nextInt(8888) + 1111}";
    try {
      String docId = "DP+$mNo+[$currentDateTime]";

      //Adding old balance and new amount
      await _firestore
          .collection(FireString.accounts)
          .doc(mNo)
          .collection(FireString.walletBalance)
          .doc(FireString.document1)
          .set({
        FireString.depositCoin: FieldValue.increment(amountToAdd),
        FireString.lifetimeDeposit: FieldValue.increment(amountToAdd)
      }, SetOptions(merge: true));

      SmartDialog.showToast('Recharge Successful');
      //Adding record to deposit list
      Map depositInfo = {
        FireString.depositAmount: amountToAdd,
        FireString.depositDateTime: currentDateTime,
        FireString.lastRechargeRefNo: lastRechargeRefNo.value,
        FireString.depositCoinBefore:
            Get.find<WalletBalanceStreamController>().depositCoin.value +
                amountToAdd,
      };
      //

      await _firestore
          .collection(FireString.accounts)
          .doc(mNo)
          .collection(FireString.myDeposits)
          .doc(docId)
          .set({
        FireString.depositInfo: depositInfo,
      }, SetOptions(merge: true));

      //Adding to global deposit records
      Map gDepositInfo = {
        FireString.depositAmount: amountToAdd,
        FireString.lastRechargeRefNo: lastRechargeRefNo.value,
        FireString.payeeName: fullName.value,
        FireString.payeeEmail: primaryEmail.value,
      };
      await _firestore.collection(FireString.allDeposits).doc(docId).set({
        FireString.depositInfo: gDepositInfo,
      }, SetOptions(merge: true));

      //
      if (selectedStackIndex.value == 1) loadMyDepositHistoryList();
      if (true) {
        SpamZone.sendMsgToTelegram(
            "New Recharge in $appNameShort App done ",
            "Amount ₹$amountToAdd ",
            "By - ${_hiveBox.get(FireString.fullName) ?? await _hiveBox.get(FireString.mobileNo).replaceRange(1, 6, "X" * (10 - 3))} 😎",
            toAdmin: false,
            toTgUsers: true);
      }
      getAllLiveRechargingData();
      Get.find<ServerStatsController>().pushServerGlobalStats(
          fireString: FireString.totalGlobalRecharge, valueToAdd: amountToAdd);

      //Adding record to all my activity
      SmallServices.updateUserActivityByDate(userIdMob: mNo, newItemsAsList: [
        "Recharge of Rs.$amountToAdd at ${timeAsTxt(currentDateTime.toString())}",
      ]);
    } catch (e) {
      Logger().d("Recharge Successful But Update Failed");
    }
  }

  showSecLoading(int secToShow) async {
    SmartDialog.dismiss(status: SmartStatus.dialog);
    SmartDialog.showLoading(
        msg: "Knocking Bank Api", background: color1, backDismiss: false);
    await Future.delayed(Duration(seconds: secToShow));
    SmartDialog.dismiss(status: SmartStatus.loading);
  }

  ////////////////////////////
  RxList myDepositListOfMaps = [].obs;
  void loadMyDepositHistoryList() async {
    String mobileNo = await _hiveBox.get(FireString.mobileNo);

    try {
      var allDocs = await _firestore
          .collection(FireString.accounts)
          .doc(mobileNo)
          .collection(FireString.myDeposits)
          .get();

      myDepositListOfMaps.assignAll(allDocs.docs.reversed);
      if (myDepositListOfMaps.isEmpty) {
        selectedStackIndex.value = 0;
        SmartDialog.showToast("No recharge history available");
      }

      //     [FireString.depositMethod]);
    } catch (e) {
      print(e.toString());
    }
  }
}
