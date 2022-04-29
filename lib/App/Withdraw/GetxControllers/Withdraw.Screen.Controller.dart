import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:lottie/lottie.dart';
import 'package:powerbank/App/MainFrame/GetxController/Main.Frame.Service.dart';
import 'package:powerbank/App/UserBankInfo/Ui/Bank.Info.Screen.dart';
import 'package:powerbank/Constants/Colors.dart';
import 'package:powerbank/Constants/strings.dart';
import 'package:powerbank/GetxStreams/Wallet.Permission.Stream.dart';
import 'package:powerbank/GetxStreams/Wallet.Value.Stream.dart';
import 'package:powerbank/HelperClasses/Server.Stats.Service.dart';
import 'package:powerbank/HelperClasses/SpamZone.dart';
import 'package:powerbank/HelperClasses/Widgets.dart';
import 'package:powerbank/HelperClasses/date_time_formatter.dart';
import 'package:powerbank/HelperClasses/small_services.dart';

var _mainFrameGService = Get.find<MainFrameGService>();
var _walletBalanceStreamController = Get.find<WalletBalanceStreamController>();
var _walletPermissionController = Get.find<WalletPermissionStreamController>();

class WithDrawScreenController extends GetxService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RxString payeeName = ''.obs;
  RxString bankName = ''.obs;
  RxString bankAcNumber = ''.obs;
  RxString ifscCode = ''.obs;
  RxString payeeEmail = ''.obs;

  final _hiveBox = Hive.box(hiveBoxName);
  Rx<int> selectedStackIndex = 0.obs;
  ////////////////////

  RxList<String> withdrawNoticeList = [
    "24 x 7 ⇋ Day and Night all time withdrawal",
    "Instant - 5 Min ⇋ Withdrawal Processing Time",
    "6% ⇋ Withdraw Service Tax",
    "₹15000 ⇋ Maximum amount per transaction",
    "₹300 ⇋ Minimum amount per transaction",
  ].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    updateWithdrawNoticeList();
  }

  void updateWithdrawNoticeList() {
    withdrawNoticeList.assignAll([
      _walletPermissionController.withdrawPeriod.value,
      _walletPermissionController.withdrawProcessingTime.value,
      "${_walletPermissionController.withdrawServiceTax.value}% ⇋ Withdraw Service Tax",
      "₹${_walletPermissionController.maximumWithdrawAmount.value} ⇋ Maximum amount per transaction",
      "₹${_walletPermissionController.minimumWithdrawAmount.value} ⇋ Minimum amount per transaction",
      if (_walletPermissionController
          .globalWalletPermissions[FireString.allowWithdrawOnPrevProcessing])
        "Allowing withdrawal even previous one is processing",
    ]);
  }

  ////////////////////
  Future<bool> checkBankInfo() async {
    // print(_mainFrameGService.currentDevice);
    SmartDialog.showLoading(background: colorLoadingAnim, backDismiss: false);
    String mNo = await _hiveBox.get(FireString.mobileNo);
    var payeeName = await _hiveBox.get(FireString.payeeName) ?? "";
    var bankName = await _hiveBox.get(FireString.bankName) ?? "";
    var bankAcNumber = await _hiveBox.get(FireString.bankAcNumber) ?? "";
    var ifscCode = await _hiveBox.get(FireString.bankIfsc) ?? "";
    var payeeEmail = await _hiveBox.get(FireString.payeeEmail) ?? "";

    // print("$mNo $pEmail $payeeName");
    if (payeeName == "" ||
        payeeEmail == "" ||
        bankAcNumber == "" ||
        ifscCode == "") {
      var bankInfo = await _firestore
          .collection(FireString.accounts)
          .doc(mNo)
          .collection(FireString.bankInfo)
          .doc(FireString.document1)
          .get();
      if (bankInfo.exists) {
        this.payeeName.value = bankInfo.get(FireString.payeeName) ?? "";
        this.bankAcNumber.value = bankInfo.get(FireString.bankAcNumber) ?? "";
        this.bankName.value = bankInfo.get(FireString.bankName) ?? "";
        this.ifscCode.value = bankInfo.get(FireString.bankIfsc) ?? "";
        this.payeeEmail.value = bankInfo.get(FireString.payeeEmail) ?? "";
        await _hiveBox.put(FireString.payeeName, this.payeeName.value);
        await _hiveBox.put(FireString.bankAcNumber, this.bankAcNumber.value);
        await _hiveBox.put(FireString.bankName, this.bankName.value);
        await _hiveBox.put(FireString.bankIfsc, this.ifscCode.value);
        await _hiveBox.put(FireString.payeeEmail, this.payeeEmail.value);
        return true;
      } else {
        SmartDialog.dismiss(status: SmartStatus.loading);
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
                  const Text('Bank Info Is Required',
                      style: TextStyle(color: Colors.white)),
                  TextButton(
                      onPressed: () {
                        SmartDialog.dismiss();
                        Get.to(BankInfoScreen());
                      },
                      child: const Text(
                        "Continue",
                        style: TextStyle(color: color4),
                      ))
                ],
              ),
            ),
            isLoadingTemp: false);
        return false;
      }
    } else {
      try {
        this.payeeName.value = payeeName;
        this.bankAcNumber.value = bankAcNumber;
        this.bankName.value = bankName;
        this.ifscCode.value = ifscCode;
        this.payeeEmail.value = payeeEmail;
        return true;
      } catch (e) {
        SmartDialog.showToast('Fill all information here');
        Get.to(BankInfoScreen());
        return false;
      }
    }
  }

  void checkOtherParameter({required int enteredAmount}) async {
    String mNo = await _hiveBox.get(FireString.mobileNo);
    try {
      if (_walletPermissionController.withdrawEnabled.value) {
        var walletBalances = await _firestore
            .collection(FireString.accounts)
            .doc(mNo)
            .collection(FireString.walletBalance)
            .doc(FireString.document1)
            .get();

        int currentWithdrawableBalance =
            walletBalances.get(FireString.withdrawableCoin);
        if (enteredAmount <= currentWithdrawableBalance &&
            enteredAmount >=
                _walletPermissionController.minimumWithdrawAmount.value &&
            enteredAmount <=
                _walletPermissionController.maximumWithdrawAmount.value) {
          var moreWalletInfo = await _firestore
              .collection(FireString.accounts)
              .doc(mNo)
              .collection(FireString.walletBalance)
              .doc(FireString.document2)
              .get();
          if (moreWalletInfo.exists) {
            String lastWithdrawStatus =
                moreWalletInfo.get(FireString.lastWithdrawStatus);
            bool canWithdraw = moreWalletInfo.get(FireString.canWithdraw);
            bool allowWithdrawOnPrevProcessing =
                _walletPermissionController.globalWalletPermissions[
                    FireString.allowWithdrawOnPrevProcessing];
            int noOfInvestment = moreWalletInfo.get(FireString.noOfInvestment);
            int noOfWithdraw = moreWalletInfo.get(FireString.noOfWithdraw);
            int noOfFreeWithdrawalWithoutInvestment =
                _walletPermissionController.globalWalletPermissions[
                    FireString.noOfFreeWithdrawalWithoutInvestment];
            int unlimitedWithdrawAfterInvestmentOf =
                _walletPermissionController.globalWalletPermissions[
                    FireString.unlimitedWithdrawAfterInvestmentOf];
            if (canWithdraw) {
              if (lastWithdrawStatus != FireString.processing ||
                  allowWithdrawOnPrevProcessing) {
                //don't allow more free withdrawal, some certain investment required for unlimited withdrawal
                if (noOfInvestment >= unlimitedWithdrawAfterInvestmentOf ||
                    noOfWithdraw < noOfFreeWithdrawalWithoutInvestment) {
                  showWithdrawConfirmDialog(enteredAmount: enteredAmount);
                } else {
                  SmartDialog.dismiss();
                  Get.snackbar(
                    "Withdraw temporarily blocked",
                    "${noOfFreeWithdrawalWithoutInvestment - noOfInvestment} investment required for more/unlimited withdrawals",
                    backgroundColor: color4.withOpacity(0.2),
                    icon: const Icon(FontAwesomeIcons.solidDizzy,
                        color: Colors.white),
                    duration: const Duration(seconds: 5),
                    snackPosition: SnackPosition.BOTTOM,
                  );
                }
              } else {
                SmartDialog.dismiss();
                SmartDialog.showToast("Last Withdraw Processing");
              }
            } else {
              SmartDialog.dismiss();
              SmartDialog.showToast("Withdraw Banned");
            }
          }
        } else {
          SmartDialog.dismiss();
          Get.snackbar(
            "Enter valid amount",
            "Minimum withdraw is ₹ ${_walletPermissionController.minimumWithdrawAmount.value}, Max up-to ₹${_walletPermissionController.maximumWithdrawAmount.value}",
            backgroundColor: color4.withOpacity(0.2),
            icon: const Icon(FontAwesomeIcons.solidDizzy, color: Colors.white),
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      } else {
        SmartDialog.dismiss();
        Get.snackbar(
          "This isn't withdraw time",
          "Our banks are not taking withdraw request currently",
          duration: const Duration(seconds: 5),
          backgroundColor: color4.withOpacity(0.2),
          icon: const Icon(FontAwesomeIcons.solidDizzy, color: Colors.white),
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } on FirebaseException catch (e) {
      SmartDialog.dismiss(status: SmartStatus.loading);
      print(e.toString());
    }
  }

  void showWithdrawConfirmDialog({required int enteredAmount}) async {
    print(
        "${payeeName.value} - ${bankAcNumber.value} - ${payeeEmail.value} - ${ifscCode.value}");
    await Future.delayed(const Duration(seconds: 1));
    SmartDialog.dismiss();
    SmartDialog.show(
      alignmentTemp: Alignment.center,
      widget: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const DialogAppNameTag(),
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: Get.width - 70,
                height: 320,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [color3, color2.withBlue(150)]),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Column(
                      children: const [
                        SizedBox(
                          height: 80,
                        ),
                        Text("Withdrawing To",
                            style: TextStyle(
                                color: colorWhite,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const Spacer(),
                    ListTile(
                      leading: const Icon(
                        FontAwesomeIcons.university,
                        color: color4,
                        size: 22,
                      ),
                      title: Text(
                        bankAcNumber.value,
                        style: const TextStyle(
                          fontSize: 13,
                          color: color4,
                        ),
                      ),
                      subtitle: Text(
                        payeeName.value,
                        style: const TextStyle(
                          fontSize: 11,
                          color: color4,
                        ),
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          SmartDialog.dismiss(status: SmartStatus.dialog);
                          Get.to(BankInfoScreen());
                        },
                        icon: const Icon(
                          FontAwesomeIcons.pen,
                          color: color4,
                          size: 18,
                        ),
                      ),
                    ),
                    const Spacer(),
                    const Divider(
                      color: colorWhite,
                    ),
                    TextButton(
                      onPressed: () async {
                        SmartDialog.showLoading(
                            background: colorLoadingAnim, backDismiss: false);

                        String mNo = await _hiveBox.get(FireString.mobileNo);
                        DateTime currentDateTime =
                            await DateTimeHelper.getCurrentDateTime();
                        String docId = "WD+$mNo+[$currentDateTime]";
                        try {
                          if (await InternetConnectionChecker().hasConnection !=
                              true) {
                            SmartDialog.showToast("No Internet Connection");
                            throw "noInternetConnection";
                          }

                          await _firestore
                              .collection(FireString.accounts)
                              .doc(mNo)
                              .collection(FireString.walletBalance)
                              .doc(FireString.document1)
                              .set({
                            FireString.withdrawableCoin:
                                FieldValue.increment(-enteredAmount)
                          }, SetOptions(merge: true)).then((value) async {
                            Map _userBankInfo = {
                              FireString.bankName: bankName.value,
                              FireString.payeeName: payeeName.value,
                              FireString.bankAcNumber: bankAcNumber.value,
                              FireString.bankIfsc: ifscCode.value,
                              FireString.payeeEmail: payeeEmail.value,
                            };
                            //Adding data to global withdrawals doc list firestore
                            await _firestore
                                .collection(FireString.allWithdrawals)
                                .doc(docId)
                                .set({
                              FireString.withdrawalAmount: enteredAmount,
                              FireString.withdrawStatus: FireString.processing,
                              FireString.withdrawBankInfo: _userBankInfo,
                            }, SetOptions(merge: true)).then((value) async {
                              //Adding To User Withdrawals Doc List
                              await _firestore
                                  .collection(FireString.accounts)
                                  .doc(mNo)
                                  .collection(FireString.myWithdrawals)
                                  .doc(docId)
                                  .set({
                                FireString.withdrawalAmount: enteredAmount,
                                FireString.withdrawDateTime: currentDateTime,
                                FireString.withdrawStatus:
                                    FireString.processing,
                                FireString.userDeviceName:
                                    _mainFrameGService.currentDevice.toString(),
                              }, SetOptions(merge: true)).then((value) async {
                                await _firestore
                                    .collection(FireString.accounts)
                                    .doc(mNo)
                                    .collection(FireString.walletBalance)
                                    .doc(FireString.document2)
                                    .set({
                                  FireString.lastWithdrawStatus:
                                      FireString.processing,
                                }, SetOptions(merge: true));
                                await _firestore
                                    .collection(FireString.accounts)
                                    .doc(mNo)
                                    .collection(FireString.walletBalance)
                                    .doc(FireString.document1)
                                    .set({
                                  FireString.totalWithdrawal:
                                      _walletBalanceStreamController
                                              .totalWithdrawal.value +
                                          enteredAmount,
                                }, SetOptions(merge: true));
                                Future.delayed(const Duration(seconds: 3),
                                    () async {
                                  SmartDialog.dismiss(
                                      status: SmartStatus.loading);
                                  SmartDialog.showToast(
                                      "Sent to withdraw queue");
                                  SpamZone.sendSpecialWithdrawAlert(
                                    "₹$enteredAmount",
                                    " withdraw by $mNo",
                                    "Info: $_userBankInfo.  LD: ${_walletBalanceStreamController.lifetimeDeposit.value}, DBalL: ${_walletBalanceStreamController.depositCoin.value}, UROI: ${_walletBalanceStreamController.upcomingIncome.value}, TRef: ${_walletBalanceStreamController.totalRefers.value}",
                                  );
                                  SpamZone.sendMsgToTelegram(
                                      "New $appName Withdraw ",
                                      "of ₹$enteredAmount ",
                                      "By ${await _hiveBox.get(FireString.mobileNo)} - ${_hiveBox.get(FireString.fullName) ?? _hiveBox.get(FireString.payeeName)}",
                                      toAdmin: true,
                                      toTgUsers: false);
//Adding record to all my activity
                                  SmallServices.updateUserActivityByDate(
                                      userIdMob: mNo,
                                      newItemsAsList: [
                                        "Withdraw Rs.$enteredAmount from device: ${_mainFrameGService.currentDevice} at ${timeAsTxt(currentDateTime.toString())}",
                                      ]);
                                });
                                Get.find<ServerStatsController>()
                                    .pushServerGlobalStats(
                                        fireString: FireString
                                            .totalGlobalTriedWithdrawal,
                                        valueToAdd: enteredAmount);
                              });
                            });
                          });
                        } catch (e) {
                          SmartDialog.dismiss(status: SmartStatus.loading);
                          SmartDialog.showToast('Try Again Later');
                        }
                      },
                      child: const Text(
                        "Yes, Confirm Withdraw",
                        style: TextStyle(color: colorWhite),
                      ),
                    ),
                    const Divider(
                      color: colorWhite,
                    ),
                    TextButton(
                      onPressed: () {
                        SmartDialog.dismiss(status: SmartStatus.dialog);
                      },
                      child: const Text(
                        "Cancel",
                        style: TextStyle(color: color4),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: -60,
                left: 0,
                right: 0,
                child: Lottie.asset("assets/piggy_money_blue.json",
                    height: 160, width: 160),
              ),
            ],
          ),
        ],
      ),
    );
    await Future.delayed(const Duration(seconds: 4), () {
      SmartDialog.dismiss(status: SmartStatus.dialog);
    });
  }

  ///////////////////////////////
  RxList myWithdrawalsMaps = [].obs;
  void loadMyWithdrawalsHistoryList() async {
    String mobileNo = await _hiveBox.get(FireString.mobileNo);

    try {
      _firestore
          .collection(FireString.accounts)
          .doc(mobileNo)
          .collection(FireString.myWithdrawals)
          .snapshots()
          .listen((querySnapshots) {
        // print((documentSnapshot.docs[0][FireString.withdrawDateTime]).toDate());
        myWithdrawalsMaps.assignAll(querySnapshots.docs);
        if (myWithdrawalsMaps.isEmpty) {
          selectedStackIndex.value = 0;
          SmartDialog.showToast("No withdraw history available");
        }
      });
    } on FirebaseException catch (e) {
      print(e);
    }
  }
}
