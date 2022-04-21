import 'dart:math';

import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:ntp/ntp.dart';
import 'package:powerbank/Constants/strings.dart';
import 'package:upi_pay/upi_pay.dart';

import 'Recharge.Screen.Controller.dart';

class UpiPayController extends GetxService {
  /////////////////////////////////////////////////////
  final _hiveBox = Hive.box(hiveBoxName);
  final _rechargeScreenController = Get.find<RechargeScreenController>();
  String adminUpiId = "";
  int _amountToAdd = 0;
  Random rnd = Random();
  ////////////////////////////////////////////
  void createUpiRechargeRequest({required UpiApplication upiApp}) async {
    if (await InternetConnectionChecker().hasConnection != true) {
      SmartDialog.showToast("No Internet Connection");
      throw "noInternetConnection";
    }
    adminUpiId = _rechargeScreenController
        .adminUpi[rnd.nextInt(_rechargeScreenController.adminUpi.length)];

    String receiverName = await _hiveBox.get(FireString.fullName);
    String mobileNo = await _hiveBox.get(FireString.mobileNo);
    String uniqueRefId = getRandomNo();
    _amountToAdd = _rechargeScreenController.selectedDCoin.value;
    final UpiTransactionResponse response = await UpiPay.initiateTransaction(
      amount: "$_amountToAdd",
      receiverName: receiverName,
      receiverUpiAddress: adminUpiId,
      transactionRef: uniqueRefId,
      transactionNote: '$appNameShort($mobileNo)$companyName',
      app: upiApp,
    );
    // print(response.status);
    // print(response.txnRef);
    // print(response.txnId);
    if (response.status == UpiTransactionStatus.success) {
      _rechargeScreenController.lastRechargeRefNo.value = "S+UPI+$uniqueRefId";
      _rechargeScreenController.updateDCoinAfterRecharge(
          amountToAdd: _amountToAdd);
    } else {
      _rechargeScreenController.lastRechargeRefNo.value =
          "F+UPI+${await NTP.now()}";
    }
  }

  String getRandomNo() {
    var rnd = Random();
    return 'order_${rnd.nextInt(88888888) + 11111111}';
  }
}
