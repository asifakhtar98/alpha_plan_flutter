import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:ntp/ntp.dart';
import 'package:powerbank/App/ReferIncome/Ui/Refer.Income.Screen.dart';
import 'package:powerbank/App/UserPersonalInfo/User.Personal.Info.Screen.dart';
import 'package:powerbank/Constants/Colors.dart';
import 'package:powerbank/Constants/strings.dart';

class CommissionController extends GetxService {
  List<int> commissionPercentList = [12, 6, 3];
  //////////////////////global refer data
  RxInt level1CommissionPercent = 12.obs;
  RxInt level2CommissionPercent = 6.obs;
  RxInt level3CommissionPercent = 3.obs;
  @override
  void onInit() async {
    // TODO: implement onInit
    print("On Init Commission Controller");
    super.onInit();
  }

  getGlobalReferCommissionData() async {
    thisCommissionHistory.clear();
    await Future.delayed(const Duration(seconds: 2));
    await FirebaseFirestore.instance
        .collection(FireString.globalSystem)
        .doc(FireString.globalReferData)
        .get()
        .then((doc) {
      print("----------Inside get Refer Commissions-------------");
      level1CommissionPercent.value = doc[FireString.level1CommissionPercent];
      level2CommissionPercent.value = doc[FireString.level2CommissionPercent];
      level3CommissionPercent.value = doc[FireString.level3CommissionPercent];
      // Get.find<CommissionController>()
      //     .grabUserReferrerNo(findReferrerOf: "3333333333", rcrgedAmnt: 100);

      commissionPercentList = [
        level1CommissionPercent.value,
        level2CommissionPercent.value,
        level3CommissionPercent.value
      ];
    });
    investorNum = await _hiveBox.get(FireString.mobileNo) ?? "";
    investorName = await _hiveBox.get(FireString.fullName) ?? "";
    if (investorName.isEmpty) {
      SmartDialog.dismiss();
      Get.off(() => UserPersonalInfoScreen());
      SmartDialog.showToast("Please fill this info");
    }
    print("Investor Name: $investorName");
    print("Investor Number: $investorNum");
  }

  /////////////////////////////////////////////////////////////////////////////

  int currentLevel = 1;
  final int _maxLevel = 3;
  late String investorName;
  late String investorNum;
  List thisCommissionHistory = [];

  final _hiveBox = Hive.box(hiveBoxName);
  grabUserReferrerNo(
      {required String findReferrerOf, required int invAmount}) async {
    if (currentLevel > _maxLevel) {
      tmpInvAmount = invAmount;

      currentLevel = 1;
      return;
    }

    var currentDateTime = await NTP.now();
    //proceed if 1,2,3 level
    await FirebaseFirestore.instance
        .collection(FireString.accounts)
        .doc(findReferrerOf)
        .collection(FireString.myReferData)
        .doc(FireString.document1)
        .get()
        .then((doc) {
      if (doc[FireString.canGetCommission]) {
        try {
          //Verify referrer number existence and valid or not
          if (doc[FireString.userReferredBy].length == 10) {
            print("Commission system ${doc[FireString.canGetCommission]}");
            //set level1 Referer number
            String referrerNo = doc[FireString.userReferredBy];
            //give level 1 commission to level 1 referrer
            FirebaseFirestore.instance
                .collection(FireString.accounts)
                .doc(referrerNo)
                .collection(FireString.walletBalance)
                .doc(FireString.document1)
                .get()
                .then((walletDoc1) async {
              //check if referer exist in account collections
              if (walletDoc1.exists) {
                int referBonus = ((invAmount *
                        commissionPercentList[currentLevel - 1] /
                        100))
                    .floor();
                //Adding commission to referral coin and
                await FirebaseFirestore.instance
                    .collection(FireString.accounts)
                    .doc(referrerNo)
                    .collection(FireString.walletBalance)
                    .doc(FireString.document1)
                    .set({
                  FireString.referralIncome:
                      walletDoc1[FireString.referralIncome] + referBonus
                }, SetOptions(merge: true)).then((_) async {
                  //Level wise record to current level upline
                  DocumentSnapshot? levelCommissionDoc;
                  try {
                    levelCommissionDoc = await FirebaseFirestore.instance
                        .collection(FireString.accounts)
                        .doc(referrerNo)
                        .collection(FireString.myReferData)
                        .doc("${FireString.commissionLevel}$currentLevel")
                        .get();
                  } catch (e) {
                    print("No Level History Available");
                  }
                  await FirebaseFirestore.instance
                      .collection(FireString.accounts)
                      .doc(referrerNo)
                      .collection(FireString.myReferData)
                      .doc("${FireString.commissionLevel}$currentLevel")
                      .set({
                    FireString.levelTotalRecharge: (levelCommissionDoc!.exists)
                        ? levelCommissionDoc[FireString.levelTotalRecharge] +
                            invAmount
                        : invAmount,
                    FireString.levelTotalCommission: (levelCommissionDoc.exists)
                        ? levelCommissionDoc[FireString.levelTotalCommission] +
                            referBonus
                        : referBonus,
                    FireString.lastCommissionOn: currentDateTime
                  }, SetOptions(merge: true)).then(
                          (value) => print("LevelHistory Added"));
                  //To Record Granularity history
                  await FirebaseFirestore.instance
                      .collection(FireString.accounts)
                      .doc(referrerNo)
                      .collection(FireString.myReferData)
                      .doc("${FireString.commissionLevel}$currentLevel")
                      .collection(FireString.recordHistory)
                      .doc(currentDateTime.toString())
                      .set({
                    FireString.mobileNo: investorNum,
                    FireString.fullName: investorName,
                    FireString.depositAmount: invAmount,
                    FireString.commissionAmount: referBonus,
                    FireString.depositDateTime: currentDateTime
                  }, SetOptions(merge: true)).then(
                          (value) => print("RecordHistory Added"));
                  currentLevel++;
                  thisCommissionHistory.add({
                    FireString.mobileNo: referrerNo,
                    FireString.commissionAmount: referBonus
                  });
                  grabUserReferrerNo(
                      findReferrerOf: referrerNo, invAmount: invAmount);
                });
              }
            });
            print("Referer $currentLevel Exist $referrerNo");
          }
        } catch (e) {
          print("Referer $currentLevel Dont Exist");
          tmpInvAmount = invAmount;
          currentLevel = 1;
          return;
        }
      }
    });
  }

  int tmpInvAmount = 0;
  void showUplineIncomeDialog() {
    print(thisCommissionHistory.length.toString());
    if (thisCommissionHistory.isNotEmpty) {
      SmartDialog.show(
          maskColorTemp: color1.withOpacity(0.9),
          alignmentTemp: Alignment.center,
          onDismiss: () {
            thisCommissionHistory = [];
          },
          widget: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Referral commission by $appNameShort App\n-Upline1 (One who refer you to the app)-",
                textAlign: TextAlign.center,
                style: TextStyle(color: color4),
              ),
              const SizedBox(height: 12),
              for (var itemMap in thisCommissionHistory.reversed)
                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          gradient: const LinearGradient(
                              colors: [color2, color4, color4, color2])),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "${(itemMap[FireString.mobileNo]?.length == 10) ? itemMap[FireString.mobileNo]?.replaceRange(1, 7, "*" * 8) : ""} get commission of",
                            style: const TextStyle(
                                color: color3,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "₹${itemMap[FireString.commissionAmount]}",
                            style: const TextStyle(
                                color: colorWhite,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          const Divider(color: color1),
                          Text(
                            "Your Upline${thisCommissionHistory.indexWhere((element) => element == itemMap) + 1}",
                            style: const TextStyle(
                                color: colorWhite, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    const Icon(FontAwesomeIcons.arrowUp)
                  ],
                ),
              Container(
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    gradient: const LinearGradient(
                        colors: [color2, color4, color4, color2])),
                child: Column(
                  children: [
                    Text(
                      "₹$tmpInvAmount",
                      style: const TextStyle(
                          color: colorWhite,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    const Divider(color: color1),
                    const Text(
                      "Your recharged",
                      style: TextStyle(color: colorWhite, fontSize: 16),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                      onPressed: () {
                        SmartDialog.dismiss(status: SmartStatus.dialog);
                        Get.toNamed(UserReferIncomeScreen.screenName);
                      },
                      child: const Text("My refer incomes")),
                  TextButton(
                      onPressed: () {
                        SmartDialog.dismiss(status: SmartStatus.dialog);
                      },
                      child: const Text("Go back")),
                ],
              )
            ],
          ));
    }
  }
}
