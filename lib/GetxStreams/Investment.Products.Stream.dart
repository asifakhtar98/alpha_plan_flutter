import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:powerbank/Constants/firestore_strings.dart';

class InvestmentProductsStreamController extends GetxService {
  RxList investmentPlansPriceList = [].obs;
  RxList investmentPlansIdList = [].obs;
  RxList noOfInvestmentsList = [].obs;
  late StreamSubscription subscription1;
  @override
  void onInit() async {
    super.onInit();
    await Future.delayed(const Duration(milliseconds: 2500));
    try {
      subscription1 = FirebaseFirestore.instance
          .collection(FireString.investmentPlans)
          .snapshots()
          .listen((documentSnapshot) {
        investmentPlansIdList.clear();
        investmentPlansPriceList.clear();
        noOfInvestmentsList.clear();
        for (var document in documentSnapshot.docs) {
          investmentPlansPriceList.add(document.get(FireString.checkoutPrice));
          noOfInvestmentsList.add(document.get(FireString.noOfInvestment));
          investmentPlansIdList.add(document.id);
          // print(document.get(FireString.checkoutPrice));
        }
      });
      print("Subscribing to investment plans");
    } catch (e) {
      SmartDialog.showToast("Investment plans subs Error");
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    subscription1.cancel();
  }
}
