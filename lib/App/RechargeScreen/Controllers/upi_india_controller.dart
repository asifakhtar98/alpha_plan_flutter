import 'dart:math';

import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:powerbank/Constants/firestore_strings.dart';
import 'package:powerbank/Constants/strings.dart';
import 'package:powerbank/HelperClasses/date_time_formatter.dart';
import 'package:upi_india/upi_india.dart';

import 'Recharge.Screen.Controller.dart';

class UpiIndiaController extends GetxController {
  final _upiIndia = UpiIndia();
  final _hiveBox = Hive.box(hiveBoxName);
  final _rechargeScreenController = Get.find<RechargeScreenController>();
  String adminUpiId = "";
  int _amountToAdd = 0;
  Random rnd = Random();
  startUpiIndia({required UpiApp upiIndApp}) async {
    if (await InternetConnectionChecker().hasConnection != true) {
      SmartDialog.showToast("No Internet Connection");
      return;
    }
    adminUpiId = _rechargeScreenController
        .adminUpi[rnd.nextInt(_rechargeScreenController.adminUpi.length)];
    String receiverName = await _hiveBox.get(FireString.fullName);
    String mobileNo = await _hiveBox.get(FireString.mobileNo);
    String uniqueRefId = getRandomNo();
    _amountToAdd = _rechargeScreenController.selectedDCoin.value;
    UpiResponse upiIndRes = await _upiIndia.startTransaction(
      app: upiIndApp,
      receiverUpiId: adminUpiId,
      receiverName: receiverName,
      transactionRefId: uniqueRefId,
      transactionNote: '$appNameShort($mobileNo)$companyName',
      amount: double.parse(_amountToAdd.toString()),
    );

    // print(upiIndRes.status);
    // print(upiIndRes.responseCode);

    if (upiIndRes.status == UpiPaymentStatus.SUCCESS) {
      try {
        _rechargeScreenController.lastRechargeRefNo.value =
            "S+UPI+$uniqueRefId";
        _rechargeScreenController.updateDCoinAfterRecharge(
            amountToAdd: _amountToAdd);
      } catch (e) {
        SmartDialog.showToast(upiIndRes.status.toString());
        print(e);
      }
    } else {
      _rechargeScreenController.lastRechargeRefNo.value =
          "F+UPI+${await DateTimeHelper.getCurrentDateTime()}";
      SmartDialog.showToast("UF:${upiIndRes.status}");
    }
  }

  String getRandomNo() {
    var rnd = Random();
    return 'order_${rnd.nextInt(88888888) + 11111111}';
  }
}
