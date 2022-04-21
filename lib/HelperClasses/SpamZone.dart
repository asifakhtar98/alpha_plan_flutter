import 'dart:math';
import 'package:dio/dio.dart';
import 'package:powerbank/Constants/Fake.Data.dart';
import 'package:powerbank/Constants/strings.dart';

class SpamZone {
  static Dio dio = Dio();
  static sendMsgToTelegram(String v1, String v2, String v3,
      {required toAdmin, required toTgUsers}) async {
    try {
      if (toTgUsers) {
        await Future.delayed(const Duration(seconds: 3));
        dio.post(
            'https://maker.ifttt.com/trigger/AlertToUsers/with/key/$kIfttApiKey1',
            queryParameters: {"value1": v1, "value2": v2, "value3": v3});
      }
      if (toAdmin) {
        await Future.delayed(const Duration(seconds: 3));
        dio.post(
            'https://maker.ifttt.com/trigger/AlertToAdmins/with/key/$kIfttApiKey1',
            queryParameters: {"value1": v1, "value2": v2, "value3": v3});
      }
    } catch (e) {
      print("sendMsgToTelegram Error");
    }
  }

  static sendSpecialWithdrawAlert(String v1, String v2, String v3) async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      dio.post(
          'https://maker.ifttt.com/trigger/FullWithdrawInfo/with/key/$kIfttApiKey1',
          queryParameters: {"value1": v1, "value2": v2, "value3": v3});
    } catch (e) {
      print("sendMsgToTelegram Error");
    }
  }

  static sendRndmMsgToChannel() async {
    await Future.delayed(const Duration(seconds: 2));
    int rndomInt = Random().nextInt(10);
    if (rndomInt == 1) {
      sendMsgToTelegram(
          "New Recharge in $appName done 🤑",
          "Amount ₹${Random().nextInt(7000) + 500} 💰",
          "By - ${fakeNames[Random().nextInt(fakeNames.length)]} 😎",
          toAdmin: false,
          toTgUsers: true);
    }
    if (rndomInt == 2) {
      sendMsgToTelegram(
          "New Withdrawal in $appName App done 🤑",
          "Amount ₹${Random().nextInt(22000) + 1000} 💰",
          "By - ${fakeNames[Random().nextInt(fakeNames.length)]} 😎",
          toAdmin: false,
          toTgUsers: true);
    }
    if (rndomInt == 3) {
      sendMsgToTelegram("$appName Paid", "Rs ${Random().nextInt(22000) + 1000}",
          "To ${fakeNames[Random().nextInt(fakeNames.length)]} 📳",
          toAdmin: false, toTgUsers: true);
    }
  }
}
