import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:powerbank/App/LoginRegister/Ui/Auth.Screen.dart';
import 'package:powerbank/Constants/strings.dart';

class WalletBalanceStreamController extends GetxService {
  final _hiveBox = Hive.box(hiveBoxName);
  RxInt withdrawalCoin = RxInt(0);
  RxInt depositCoin = RxInt(0);
  RxInt investReturn = RxInt(0);
  RxInt referralIncome = RxInt(0);
  RxInt totalWithdrawal = RxInt(0);
  RxInt upcomingIncome = RxInt(0);
  RxInt lifetimeDeposit = RxInt(0);
  RxInt totalRefers = RxInt(0);
  late StreamSubscription subscription1;
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    String mobileNo = await _hiveBox.get(FireString.mobileNo);
    print("From Wallet Stream: Mob: $mobileNo");
    print(mobileNo);
    try {
      subscription1 = FirebaseFirestore.instance
          .collection(FireString.accounts)
          .doc(mobileNo)
          .collection(FireString.walletBalance)
          .doc(FireString.document1)
          .snapshots()
          .listen((documentSnapshot) {
        withdrawalCoin.value = documentSnapshot[FireString.withdrawableCoin];
        depositCoin.value = documentSnapshot[FireString.depositCoin];
        investReturn.value = documentSnapshot[FireString.investReturn];
        referralIncome.value = documentSnapshot[FireString.referralIncome];
        totalWithdrawal.value = documentSnapshot[FireString.totalWithdrawal];
        upcomingIncome.value = documentSnapshot[FireString.upcomingIncome];
        lifetimeDeposit.value = documentSnapshot[FireString.lifetimeDeposit];
        totalRefers.value = documentSnapshot[FireString.totalRefers];
      });
      print("Subscribing to wallet balances");
      //Also subscribing to can login value
      FirebaseFirestore.instance
          .collection(FireString.accounts)
          .doc(mobileNo)
          .snapshots()
          .listen((documentSnapshot) async {
        if (!documentSnapshot[FireString.canLogin]) {
          Get.snackbar(
            "Account Banned",
            "Access Blocked By System, Login Again",
            backgroundColor: Colors.redAccent.withOpacity(0.4),
            icon: const Icon(FontAwesomeIcons.solidDizzy, color: Colors.white),
            snackPosition: SnackPosition.BOTTOM,
          );
          await Future.delayed(const Duration(seconds: 2), () {
            Get.offAllNamed(AuthScreen.screenName);
          });
        }
      });
    } on FirebaseException catch (e) {
      print("Wallet Stream Error: $e");
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    subscription1.cancel();
  }
}
