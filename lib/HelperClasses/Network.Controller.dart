import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:lottie/lottie.dart';
import 'package:powerbank/generated/assets.dart';

import '../Constants/Colors.dart';

class NetworkController extends GetxService {
  late StreamSubscription<InternetConnectionStatus> isDataConnectedStream;

  @override
  void onInit() {
    // TODO: implement onInit
    isDataConnectedStream =
        InternetConnectionChecker().onStatusChange.listen((status) {
      switch (status) {
        case InternetConnectionStatus.connected:
          {
            SmartDialog.dismiss(tag: "NoConnectionDialog");

            // print('Data connection is available.');
          }
          break;
        case InternetConnectionStatus.disconnected:
          {
            SmartDialog.show(
                maskColorTemp: color1.withOpacity(0.9),
                tag: "NoConnectionDialog",
                alignmentTemp: Alignment.center,
                widget: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(Assets.assetsWifiLoading,
                        width: Get.width * 0.3),
                    Text(
                      "Wait, Reconnecting to servers\nApp is trying to fetch data from servers\nOR",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: color4.withOpacity(0.8)),
                    ),
                    TextButton(
                      onPressed: () {
                        SystemNavigator.pop();
                      },
                      child: const Text(
                        "Restart App",
                        style: TextStyle(color: Colors.green, fontSize: 12),
                      ),
                    )
                  ],
                ));
            // print('You are disconnected from the internet.');
          }
          break;
      }
    });

    super.onInit();
  }
}
