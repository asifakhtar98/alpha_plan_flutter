import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:lottie/lottie.dart';
import 'package:powerbank/Constants/Colors.dart';
import 'package:powerbank/Constants/Investment.Products.dart';
import 'package:powerbank/Constants/strings.dart';
import 'package:powerbank/GetxStreams/Investment.Products.Stream.dart';
import 'package:powerbank/HelperClasses/Server.Stats.Service.dart';
import 'package:powerbank/HelperClasses/SpamZone.dart';
import 'package:powerbank/HelperClasses/Widgets.dart';
import 'package:powerbank/HelperClasses/date_time_formatter.dart';
import 'package:powerbank/HelperClasses/small_services.dart';

import 'Commission.Controller.dart';

class BuyProductController extends GetxService {
  final _investmentProductsStreamController =
      Get.find<InvestmentProductsStreamController>();
  RxBool isDepositWalletSelected = true.obs;
  final _hiveBox = Hive.box(hiveBoxName);
  void toggleWallet() {
    isDepositWalletSelected.value =
        (isDepositWalletSelected.value) ? false : true;
  }

  RxBool isNotHibernated = false.obs;
  RxInt planServerPrice = 0.obs;

  void togglePlan({required String planID, required int localPlanPrice}) async {
    if (await InternetConnectionChecker().hasConnection) {
      await Future.delayed(const Duration(milliseconds: 300));
      int onlinePlanIndex = _investmentProductsStreamController
          .investmentPlansIdList
          .indexWhere((element) => element == planID);
      planServerPrice.value = _investmentProductsStreamController
          .investmentPlansPriceList[onlinePlanIndex];

      isNotHibernated.value =
          (planServerPrice.value >= localPlanPrice / 2) ? true : false;
    } else {
      Get.back();
      SmartDialog.showToast("No Internet Connection");
    }
  }

  Future<bool> proceedToPlanBuy(
      {required bool isDepositWalletSet, required String planUid}) async {
    print(planUid);
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    String mNo = await _hiveBox.get(FireString.mobileNo);
    int tmpPlanPrice;
    try {
      if (await InternetConnectionChecker().hasConnection != true) {
        SmartDialog.showToast("No Internet Connection");
        throw "noInternetConnection";
      }
      if (!isNotHibernated.value) {
        SmartDialog.showToast("This plan server is in hibernation");
        throw "inHibernation";
      }
      //Get current plan price
      var planDocument = await _firestore
          .collection(FireString.investmentPlans)
          .doc(planUid)
          .get();
      tmpPlanPrice = planDocument.get(FireString.checkoutPrice);
      //Balance Deduction
      await _firestore
          .collection(FireString.accounts)
          .doc(mNo)
          .collection(FireString.walletBalance)
          .doc(FireString.document1)
          .set({
        (isDepositWalletSet)
            ? FireString.depositCoin
            : FireString.withdrawableCoin: FieldValue.increment(-tmpPlanPrice),
        //Upcoming income for view
        FireString.upcomingIncome: FieldValue.increment(
            mainInvestmentProductsList[mainInvestmentProductsList
                    .indexWhere((element) => element.uidProduct == planUid)]
                .totalIncome)
      }, SetOptions(merge: true));
      //Create unique investment docId

      DateTime currentTimestamp = await getCurrentDateTime();

      String docId = "INV+$mNo+[$currentTimestamp]";
      //For User : Add this investment to user personal records
      await _firestore
          .collection(FireString.accounts)
          .doc(mNo)
          .collection(FireString.myInvestments)
          .doc(docId)
          .set({
        FireString.planUid: planUid,
        FireString.planCapturedDate: currentTimestamp,
        FireString.planCapturedAt: tmpPlanPrice,
        FireString.servedDays: 0,
        FireString.returnedAmount: 0,
        FireString.isCompleted: false
      }, SetOptions(merge: true));
      //For Admin: Add investment to global investment records
      await _firestore.collection(FireString.allAppInvestments).doc(docId).set({
        FireString.isCompleted: false,
        FireString.planUid: planUid,
        FireString.planCapturedDate: currentTimestamp,
        FireString.planCapturedAt: tmpPlanPrice,
        FireString.servedDays: 0,
        FireString.returnedAmount: 0,
      }, SetOptions(merge: true));
      //Update user no of investment by 1 (no of investment restrict non investor to get only 1 free withdrawal)

      await _firestore
          .collection(FireString.accounts)
          .doc(mNo)
          .collection(FireString.walletBalance)
          .doc(FireString.document2)
          .set({FireString.noOfInvestment: FieldValue.increment(1)},
              SetOptions(merge: true));
      //It increase the global plans bought number by in
      FirebaseFirestore.instance
          .collection(FireString.investmentPlans)
          .doc(planUid)
          .set({FireString.noOfInvestment: FieldValue.increment(1)},
              SetOptions(merge: true));
      //Update global value for admin check and
      Get.find<ServerStatsController>().pushServerGlobalStats(
          fireString: FireString.totalGlobalInvestments,
          valueToAdd: tmpPlanPrice);
      SpamZone.sendMsgToTelegram(
          "New RS.${mainInvestmentProductsList[mainInvestmentProductsList.indexWhere((element) => element.uidProduct == planUid)].productPrice} Investment in $appName App ${mainInvestmentProductsList[mainInvestmentProductsList.indexWhere((element) => element.uidProduct == planUid)].productName} Servers 😍",
          "Profit of RS.${mainInvestmentProductsList[mainInvestmentProductsList.indexWhere((element) => element.uidProduct == planUid)].totalIncome} ",
          "Investor : ${_hiveBox.get(FireString.fullName) ?? await _hiveBox.get(FireString.mobileNo).replaceRange(1, 6, "X" * (10 - 3))}",
          toAdmin: true,
          toTgUsers: true);
      //Adding record to all my activity
      SmallServices.updateUserActivityByDate(userIdMob: mNo, newItemsAsList: [
        "Invested Rs.$tmpPlanPrice on .${mainInvestmentProductsList[mainInvestmentProductsList.indexWhere((element) => element.uidProduct == planUid)].productName} ($docId) at ${timeAsTxt(currentTimestamp.toString())}",
      ]);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  void showAfterPurchaseDialog(int localIndex) async {
    String mNo = await _hiveBox.get(FireString.mobileNo);
    //Process commissions system
    Get.find<CommissionController>().grabUserReferrerNo(
        findReferrerOf: mNo, invAmount: planServerPrice.value);
    await Future.delayed(const Duration(seconds: 1));
    SmartDialog.dismiss(status: SmartStatus.dialog);
    await Future.delayed(const Duration(seconds: 1));
    SmartDialog.show(
      alignmentTemp: Alignment.center,
      backDismiss: false,
      onDismiss: () {
        Get.find<CommissionController>().showUplineIncomeDialog();
      },
      widget: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const DialogAppNameTag(),
          Stack(
            alignment: AlignmentDirectional.topCenter,
            clipBehavior: Clip.none,
            children: [
              Container(
                width: Get.width - 70,
                height: 370,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [color4, color3.withBlue(150)]),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Column(
                      children: [
                        const SizedBox(
                          height: 80,
                        ),
                        Text(
                          mainInvestmentProductsList[localIndex].productName,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: colorWhite,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const Text("Investment Done Successfully",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: colorWhite,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const Spacer(),
                    Text(
                      "Serving rate is Rs ${mainInvestmentProductsList[localIndex].dailyIncome}/Day",
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: colorWhite),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text(
                      "(Return of investment will begin from tomorrow 12:00 am)",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: colorWhite, fontSize: 10),
                    ),
                    const Spacer(),
                    const Divider(
                      color: colorWhite,
                    ),
                    TextButton(
                      onPressed: () {
                        SmartDialog.dismiss(status: SmartStatus.dialog);
                      },
                      child: const Text(
                        "         Continue          ",
                        style: TextStyle(color: colorWhite),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: -110,
                child: Lottie.asset(
                  "assets/astronaut-rocket.json",
                  width: 220,
                  height: 220,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
