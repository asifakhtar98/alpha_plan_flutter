import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:powerbank/Constants/Colors.dart';
import 'package:powerbank/Constants/firestore_strings.dart';
import 'package:powerbank/HelperClasses/Widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class ServerPermitStreamController extends GetxService {
  bool appRegEnabled = true;
  RxString accessDisableNotice = "".obs;
  bool blockFullAccess = false;
  String appVersionCode = "";
  bool isForceAppUpdate = false;
  String appLink = "";
  RxBool isUpdateAvailable = false.obs;
  RxBool isReferCodeCompulsory = true.obs;
  RxBool shouldVerifyIdByOtp = true.obs;
  late StreamSubscription subscription1;
  late PackageInfo packageInfo;
  @override
  void onInit() async {
    super.onInit();
    packageInfo = await PackageInfo.fromPlatform();
    try {
      print("Listening to server permit");
      subscription1 = FirebaseFirestore.instance
          .collection(FireString.globalSystem)
          .doc(FireString.globalPermit)
          .snapshots()
          .listen((documentSnapshot) {
        appRegEnabled = documentSnapshot[FireString.appRegEnabled];

        blockFullAccess = documentSnapshot[FireString.blockFullAccess];
        accessDisableNotice.value =
            documentSnapshot[FireString.accessDisableNotice];
        appVersionCode = documentSnapshot[FireString.appVersionCode];
        isForceAppUpdate = documentSnapshot[FireString.isForceAppUpdate];
        appLink = documentSnapshot[FireString.appLink];
        isReferCodeCompulsory.value =
            documentSnapshot[FireString.isReferCodeCompulsory];
        shouldVerifyIdByOtp.value =
            documentSnapshot[FireString.shouldVerifyIdByOtp];

        if (packageInfo.buildNumber == appVersionCode) {
          isUpdateAvailable.value = false;
          if (blockFullAccess) {
            showBlockFullAccessDialog();
          }
        } else {
          isUpdateAvailable.value = true;
          showAppUpdateNoticeDialog();
        }
      });
    } catch (e) {
      print("Err Listening to server permit");
    }
  }

  void showBlockFullAccessDialog() async {
    SmartDialog.show(
      alignmentTemp: Alignment.center,
      backDismiss: false,
      widget: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const DialogAppNameTag(),
          Container(
            width: Get.width - 70,
            height: 250,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [color4, color3.withBlue(150)]),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                const Text(
                  "Access Blocked For Some Time",
                  textAlign: TextAlign.end,
                  style: TextStyle(color: colorWhite),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    accessDisableNotice.value,
                    style: const TextStyle(color: colorWhite),
                  ),
                ),
                const Spacer(),
                const Divider(
                  color: colorWhite,
                ),
                TextButton(
                  onPressed: () {
                    CustomerSupport.openTelegramChannel();
                  },
                  child: const Text(
                    "Join Telegram Channel",
                    style: TextStyle(color: Colors.green),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
    await Future.delayed(const Duration(seconds: 20), () {
      // SystemNavigator.pop();
    });
  }

  showAppUpdateNoticeDialog() async {
    if (isForceAppUpdate) await Future.delayed(const Duration(seconds: 5));
    SmartDialog.show(
      tag: "AppUpdateDialog",
      alignmentTemp: Alignment.center,
      backDismiss: false,
      widget: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const DialogAppNameTag(),
          Container(
            width: Get.width - 70,
            height: 250,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [color4, color3.withBlue(150)]),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                const Text(
                  "New App Update Available",
                  textAlign: TextAlign.end,
                  style: TextStyle(color: colorWhite),
                ),
                const Spacer(),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "This new app update improve app experience and solved some issues related to app",
                    style: TextStyle(color: colorWhite),
                  ),
                ),
                const Spacer(),
                const Divider(
                  color: colorWhite,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    if (!isForceAppUpdate)
                      TextButton(
                        onPressed: () {
                          SmartDialog.dismiss(tag: "AppUpdateDialog");
                        },
                        child: const Text(
                          "Not Now",
                          style: TextStyle(color: Colors.green, fontSize: 12),
                        ),
                      ),
                    TextButton(
                      onPressed: () async {
                        await canLaunch(appLink)
                            ? await launch(appLink)
                            : throw 'Could not launch $appLink';
                      },
                      child: const Text(
                        "Update App",
                        style: TextStyle(color: colorWhite),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
