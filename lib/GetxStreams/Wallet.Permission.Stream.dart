import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:powerbank/Constants/firestore_strings.dart';

class WalletPermissionStreamController extends GetxService {
  RxBool withdrawEnabled = false.obs;
  RxInt minimumWithdrawAmount = 100000.obs;
  RxInt maximumWithdrawAmount = 110000.obs;
  RxInt withdrawServiceTax = 6.obs;
  RxString withdrawProcessingTime = "".obs;
  RxString withdrawPeriod = "".obs;
  RxInt minReferIncomeToConvert = 1000.obs;
  //To reduce above var in future
  RxMap globalWalletPermissions = <String, dynamic>{}.obs;
  late StreamSubscription subscription1;
  @override
  void onInit() {
    super.onInit();

    try {
      subscription1 = FirebaseFirestore.instance
          .collection(FireString.globalSystem)
          .doc(FireString.walletPermissions)
          .snapshots()
          .listen((documentSnapshot) {
        withdrawEnabled.value = documentSnapshot[FireString.withdrawEnabled];
        minimumWithdrawAmount.value =
            documentSnapshot[FireString.minimumWithdrawAmount];
        maximumWithdrawAmount.value =
            documentSnapshot[FireString.maximumWithdrawAmount];
        withdrawServiceTax.value =
            documentSnapshot[FireString.withdrawServiceTax];
        withdrawProcessingTime.value =
            documentSnapshot[FireString.withdrawProcessingTime];
        withdrawPeriod.value = documentSnapshot[FireString.withdrawPeriod];
        minReferIncomeToConvert.value =
            documentSnapshot[FireString.minReferIncomeToConvert];
        //Above variable can be deleted if below map is used
        globalWalletPermissions.value = documentSnapshot.data()!;
      });
      print("Subscribing to wallet permissions");
    } catch (e) {
      SmartDialog.showToast("Wallet Permissions Subs Error");
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    subscription1.cancel();
  }
}
