import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:powerbank/Constants/Colors.dart';
import 'package:powerbank/HelperClasses/Widgets.dart';
import 'package:powerbank/Constants/strings.dart';

class ServerStatsController extends GetxService {
  RxInt totalGlobalInvestments = 0.obs;
  RxInt totalGlobalRecharge = 0.obs;
  RxInt totalGlobalTriedWithdrawal = 0.obs;
  RxInt totalGlobalUsers = 0.obs;

  loadGlobalStats() async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection(FireString.globalSystem)
        .doc(FireString.stats)
        .get();
    totalGlobalInvestments.value = doc[FireString.totalGlobalInvestments];
    totalGlobalRecharge.value = doc[FireString.totalGlobalRecharge];
    totalGlobalTriedWithdrawal.value =
        doc[FireString.totalGlobalTriedWithdrawal];
    totalGlobalUsers.value = doc[FireString.totalGlobalUsers];
    print(totalGlobalInvestments.value);
    print(totalGlobalRecharge.value);
    print(totalGlobalTriedWithdrawal.value);
    print(totalGlobalUsers.value);
  }

  showServerStatsDialog() {
    loadGlobalStats();

    SmartDialog.show(
      clickBgDismissTemp: true,
      alignmentTemp: Alignment.center,
      widget: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const DialogAppNameTag(),
          Container(
            width: Get.width - 70,
            height: 500,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [color4, color3.withBlue(150)]),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Obx(() {
              return Column(
                children: [
                  const Text(
                    "App global statistics",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: colorWhite),
                  ),
                  const Spacer(),
                  //////////////////
                  Text(
                    (totalGlobalUsers.value + 11675).toString(),
                    style: const TextStyle(
                        color: colorWhite,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "Total Users",
                    style: TextStyle(
                      color: colorWhite,
                    ),
                  ),
                  const Spacer(),
                  //////////////////
                  Text(
                    (totalGlobalRecharge.value + 768533).toString(),
                    style: const TextStyle(
                        color: colorWhite,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "Total Recharges",
                    style: TextStyle(
                      color: colorWhite,
                    ),
                  ),
                  const Spacer(), //////////////////
                  Text(
                    (totalGlobalInvestments.value + 508800).toString(),
                    style: const TextStyle(
                        color: colorWhite,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "Total Plan Investments",
                    style: TextStyle(
                      color: colorWhite,
                    ),
                  ),
                  const Spacer(), //////////////////
                  Text(
                    (totalGlobalTriedWithdrawal.value + 987600).toString(),
                    style: const TextStyle(
                        color: colorWhite,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "Users Total Withdrawal",
                    style: TextStyle(
                      color: colorWhite,
                    ),
                  ),
                  const Spacer(),

                  const Divider(
                    color: colorWhite,
                  ),
                  TextButton(
                    onPressed: () {
                      SmartDialog.dismiss();
                    },
                    child: const Text(
                      "            Go Back            ",
                      style: TextStyle(color: colorWhite),
                    ),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }

  pushServerGlobalStats(
      {required String fireString, required valueToAdd}) async {
    await Future.delayed(const Duration(seconds: 3));
    FirebaseFirestore.instance
        .collection(FireString.globalSystem)
        .doc(FireString.stats)
        .set({fireString: FieldValue.increment(valueToAdd)},
            SetOptions(merge: true));
  }
}
