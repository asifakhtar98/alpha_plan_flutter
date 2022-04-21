import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:ntp/ntp.dart';
import 'package:powerbank/Constants/strings.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import 'Recharge.Screen.Controller.dart';

class RazorpayController extends GetxService {
  final _hiveBox = Hive.box(hiveBoxName);
  final _rechargeScreenController = Get.find<RechargeScreenController>();
  late Razorpay _razorpay;
  String razorPayProdApiKey = "";
  @override
  void onInit() async {
    super.onInit();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  int _amountToAdd = 0;
  void createRazorpayRechargeRequest(String paymentMethod) async {
    if (await InternetConnectionChecker().hasConnection != true) {
      SmartDialog.showToast("No Internet Connection");
      throw "noInternetConnection";
    }
    int rndInt =
        Random().nextInt(_rechargeScreenController.razorPayKeys.length);
    razorPayProdApiKey = _rechargeScreenController.razorPayKeys[rndInt];
    print(kDebugMode
        ? "Rzp acs ${_rechargeScreenController.razorPayKeys} : $razorPayProdApiKey"
        : rndInt);
    _amountToAdd = _rechargeScreenController.selectedDCoin.value;
    String fullName = await _hiveBox.get(FireString.fullName);
    String email = await _hiveBox.get(FireString.primaryEmail);
    String mobileNo = await _hiveBox.get(FireString.mobileNo);
    String uniqueOrderId = getRandomNo();

    var options = {
      'key': razorPayProdApiKey, //razorPayStagingApiKey//razorPayProdApiKey
      'amount': _amountToAdd * 100,
      'name': fullName,
      'orderId': uniqueOrderId,
      'description': 'Adding Rs $_amountToAdd In $fullName Account',
      'timeout': 600,
      'allow_rotation': true,
      "theme.hide_topbar": true,
      "prefill.method":
          paymentMethod, //Pre-selection of the payment method for the customer. It can be card/netbanking/wallet/emi/upi. However, it will only work if contact and email are also pre-filled.
      'theme.color': '#022B5B',
      'theme.backdrop_color': '#022B5B',
      'prefill': {'contact': mobileNo, 'email': email},
      // 'external': {
      //   'wallets': ['paytm']
      // }
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  String getRandomNo() {
    return 'order_${Random().nextInt(88888888) + 11111111}';
  }

  _handlePaymentSuccess(PaymentSuccessResponse response) async {
    _rechargeScreenController.lastRechargeRefNo.value =
        "S+RP+${await NTP.now()}";
    _rechargeScreenController.updateDCoinAfterRecharge(
        amountToAdd: _amountToAdd);
  }

  _handlePaymentError(PaymentFailureResponse response) async {
    _rechargeScreenController.lastRechargeRefNo.value =
        "F+CF+${await NTP.now()}";
  }

  _handleExternalWallet(ExternalWalletResponse response) async {
    _rechargeScreenController.lastRechargeRefNo.value =
        "EXT+RP+${await NTP.now()}";
  }
}
