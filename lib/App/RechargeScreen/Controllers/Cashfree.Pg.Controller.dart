import 'dart:convert';
import 'dart:math';

import 'package:cashfree_pg/cashfree_pg.dart';
import 'package:dio/dio.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:powerbank/Constants/strings.dart';
import 'package:powerbank/HelperClasses/date_time_formatter.dart';

import 'Recharge.Screen.Controller.dart';

final _hiveBox = Hive.box(hiveBoxName);
String cashfreeProdAppId = "1578868d6f763d4f70646f307a688751";
int _currentAmount = 99999999;

class CashfreePgController extends GetxService {
  Random rnd = Random();
  final _rechargeScreenController = Get.find<RechargeScreenController>();
  String cashfreeProdKeys = "2f5d0771c6cad223d5462508b026daa5aee4c79a";

  createCashfreeRechargeRequest(String method) async {
    _currentAmount = _rechargeScreenController.selectedDCoin.value;
    int randomNo = rnd.nextInt(_rechargeScreenController.cashfreeKeys.length);
    print("Cashfree ac index $randomNo");
    cashfreeProdKeys =
        _rechargeScreenController.cashfreeKeys[randomNo][FireString.secretKey];
    cashfreeProdAppId =
        _rechargeScreenController.cashfreeKeys[randomNo][FireString.appId];
    // print(cashfreeProdKeys);
    // print(cashfreeProdAppId);

    var order =
        Order(orderAmount: _currentAmount.toString(), paymentModes: method);
    var dio = Dio();
    final response = await dio.post(
        (order.stage == "TEST")
            ? 'https://test.cashfree.com/api/v2/cftoken/order'
            : 'https://api.cashfree.com/api/v2/cftoken/order',
        options: Options(headers: {
          'x-client-id': order.appId,
          'x-client-secret': (order.stage == "TEST")
              ? 'ff3940bb90b7185fddbb4c66319a9b67eef77bc2'
              : cashfreeProdKeys,
          'Content-Type': 'application/json'
        }),
        data: jsonEncode({
          'orderId': order.orderId,
          'orderAmount': _currentAmount.toString(),
          'orderCurrency': order.orderCurrency,
        }));

    if (response.statusCode == 200) {
      order.tokenData = response.data['cftoken'];
      order.customerEmail = await _hiveBox.get(FireString.primaryEmail);
      order.customerName = appName;
      order.customerPhone = await _hiveBox.get(FireString.mobileNo);
      // If server returns an OK response, parse the JSON.
      var inputs = order.toMap();
      inputs.addAll(UIMeta().toMap());
      inputs.putIfAbsent('tokenData', () {
        return response.data['cftoken'];
      });
      try {
        // print("CashFree Try ");
        if (await InternetConnectionChecker().hasConnection != true) {
          SmartDialog.showToast("No Internet Connection");
        }
        CashfreePGSDK.doPayment(inputs).then((value) async {
          if (value!["txStatus"] == "SUCCESS") {
            _rechargeScreenController.lastRechargeRefNo.value =
                "S+CF+${value["orderId"]}";
            _rechargeScreenController.updateDCoinAfterRecharge(
                amountToAdd: _currentAmount);
          } else {
            _rechargeScreenController.lastRechargeRefNo.value =
                "F+CF+${await DateTimeHelper.getCurrentDateTime()}";
            // print("Cash free Payment Failed");
          }
        });
      } catch (e) {
        print(e);
      }
    } else {
      // If that response was not OK, throw an error.
      print(e);
    }
  }
}

class Token {
  final String cfToken;
  Token({required this.cfToken});
  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(cfToken: json['cftoken']);
  }
}

class Order {
  Order({required this.orderAmount, required this.paymentModes}) {
    appId = (stage == "TEST")
        ? "108051d8938f7134072d6155ca150801"
        : cashfreeProdAppId;
  }

  //Change Stage Only Here
  String stage = "PROD"; //TEST or PROD
  String orderId = getRandomNo();
  String orderAmount;
  String tokenData = "";
  String customerName = appName;
  String orderNote = "$appName Add Money";
  String orderCurrency = "INR";
  String appId = cashfreeProdAppId;
  String customerPhone = "";
  String customerEmail = "sample@gmail.com";
  String notifyUrl = "https://test.gocashfree.com/notify";
  String paymentModes =
      "upi"; // Available values: cc, dc, nb, paypal, upi, wallet.
  static String getRandomNo() {
    var rng = Random();
    return 'order${rng.nextInt(88888888) + 11111111}';
  }

  Map<String, dynamic> toMap() {
    return {
      "orderId": orderId,
      "orderAmount": _currentAmount.toString(),
      "customerName": customerName,
      "orderNote": orderNote,
      "orderCurrency": orderCurrency,
      "appId": appId,
      "customerPhone": customerPhone,
      "customerEmail": customerEmail,
      "stage": stage,
      "tokenData": tokenData,
      "notifyUrl": notifyUrl,
      "paymentModes": paymentModes
    };
  }
}

class UIMeta {
  String color1 = "#022B5B";
  String color2 = "#DEE5E7";
  String hideOrderId = "false";

  static String getRandomNo() {
    var rnd = Random();
    return 'order_${rnd.nextInt(88888888) + 1111111}';
  }

  Map<String, dynamic> toMap() {
    return {"color1": color1, "color2": color2};
  }
}
