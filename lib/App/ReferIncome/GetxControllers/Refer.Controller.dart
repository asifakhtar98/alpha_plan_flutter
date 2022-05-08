import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:powerbank/Constants/Colors.dart';
import 'package:powerbank/Constants/firestore_strings.dart';
import 'package:powerbank/Constants/strings.dart';
import 'package:powerbank/GetxStreams/Wallet.Permission.Stream.dart';
import 'package:powerbank/HelperClasses/date_time_formatter.dart';
import 'package:powerbank/HelperClasses/small_services.dart';

class ReferIncomeController extends GetxService {
  final _hiveBox = Hive.box(hiveBoxName);
  final _walletPermissionStreamController =
      Get.find<WalletPermissionStreamController>();
  Rx<int> selectedStackIndex = 0.obs;
  RxList myReferCodes = [].obs;
  RxInt lifetimeReferIncome = 0.obs;
  @override
  void onInit() {
    getLevelsCommissionOverall();
    setReferCodesList();
    super.onInit();
  }

  setReferCodesList() async {
    String _mNo = await _hiveBox.get(FireString.mobileNo);
    await FirebaseFirestore.instance
        .collection(FireString.accounts)
        .doc(_mNo)
        .collection(FireString.myReferData)
        .doc(FireString.document1)
        .collection(FireString.userReferCodes)
        .get()
        .then((doc) {
      myReferCodes.assignAll(doc.docs);
    });
  }

  fetchAllFieldsValue() {}

  convertReferIncomeToWithdrawalBalance(int referCoinToConvert) async {
    String mNo = await _hiveBox.get(FireString.mobileNo);
    //To get current withdrawal coin value
    try {
      if (referCoinToConvert >=
          _walletPermissionStreamController.minReferIncomeToConvert.value) {
        FirebaseFirestore.instance
            .collection(FireString.accounts)
            .doc(mNo)
            .collection(FireString.walletBalance)
            .doc(FireString.document1)
            .set({
          FireString.referralIncome: FieldValue.increment(-referCoinToConvert)
        }, SetOptions(merge: true));
        await FirebaseFirestore.instance
            .collection(FireString.accounts)
            .doc(mNo)
            .collection(FireString.walletBalance)
            .doc(FireString.document1)
            .set({
          FireString.withdrawableCoin: FieldValue.increment(referCoinToConvert)
        }, SetOptions(merge: true));
        var currentDateTime = await DateTimeHelper.getCurrentDateTime();
        SmallServices.updateUserActivityByDate(userIdMob: mNo, newItemsAsList: [
          "Grabbed Rs.$referCoinToConvert for withdrawal from refer income wallet at ${timeAsTxt(currentDateTime.toString())}"
        ]);
      } else {
        SmartDialog.dismiss(status: SmartStatus.dialog);
        Get.snackbar(
          "Need More Referrals",
          "Minimum conversion is ₹ ${_walletPermissionStreamController.minReferIncomeToConvert.value}",
          backgroundColor: color4.withOpacity(0.2),
          icon: const Icon(FontAwesomeIcons.solidDizzy, color: Colors.white),
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      print(e.toString());
    }
  }

  //////////////////////////////
  RxList allLevelsOverall = [].obs;
  getLevelsCommissionOverall() async {
    String mNo = await _hiveBox.get(FireString.mobileNo);
    //Get Names of commissions some may exist or not exist anymore
    await FirebaseFirestore.instance
        .collection(FireString.accounts)
        .doc(mNo)
        .collection(FireString.myReferData)
        .get()
        .then((allDocs) {
      allLevelsOverall.assignAll([]);
      lifetimeReferIncome.value = 0;
      for (var doc in allDocs.docs) {
        if (doc.id.contains(FireString.commissionLevel)) {
          allLevelsOverall.add({
            FireString.commissionLevel: doc.id.toString(),
            "MapData": {
              FireString.levelTotalRecharge: doc[FireString.levelTotalRecharge],
              FireString.levelTotalCommission:
                  doc[FireString.levelTotalCommission],
              FireString.lastCommissionOn: doc[FireString.lastCommissionOn]
            }
          });
        }
      }
      for (var item in allLevelsOverall) {
        lifetimeReferIncome.value = lifetimeReferIncome.value +
            int.parse(
                item["MapData"][FireString.levelTotalCommission].toString());
        print(item["MapData"][FireString.levelTotalCommission]);
      }
      // print(allLevelsOverall.toString());
    });
  }

  RxList allMembersOfALevel = [].obs;
  getALevelCommissionMembers(String levelDocName) async {
    String mNo = await _hiveBox.get(FireString.mobileNo);
    await FirebaseFirestore.instance
        .collection(FireString.accounts)
        .doc(mNo)
        .collection(FireString.myReferData)
        .doc(levelDocName)
        .collection(FireString.recordHistory)
        .get()
        .then((allDocs) {
      allMembersOfALevel.assignAll([]);
      for (var doc in allDocs.docs) {
        allMembersOfALevel.add({
          FireString.mobileNo: doc[FireString.mobileNo],
          FireString.fullName: doc[FireString.fullName],
          FireString.depositAmount: doc[FireString.depositAmount],
          FireString.commissionAmount: doc[FireString.commissionAmount],
          FireString.depositDateTime: doc[FireString.depositDateTime],
        });
      }
      print(allMembersOfALevel.toString());
    });
  }
}
