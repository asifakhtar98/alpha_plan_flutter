import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:ntp/ntp.dart';
import 'package:powerbank/App/UserPersonalInfo/User.Personal.Info.Screen.dart';
import 'package:powerbank/Constants/Colors.dart';
import 'package:powerbank/Constants/Fake.Data.dart';
import 'package:powerbank/Constants/strings.dart';
import 'package:powerbank/HelperClasses/SpamZone.dart';
import 'package:powerbank/HelperClasses/Widgets.dart';
import 'package:powerbank/HelperClasses/date_time_formatter.dart';
import 'package:powerbank/HelperClasses/small_services.dart';

class MainFrameGService extends GetxService {
  DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  Rx<int> currentNavIndex = 0.obs;
  final _hiveBox = Hive.box(hiveBoxName);
  late String loggedMobile;
  @override
  void onInit() async {
    readDeviceInfo();
    loggedMobile = await _hiveBox.get(FireString.mobileNo) ?? "";
    print(loggedMobile);
    initSomeValue();
    super.onInit();
  }

  initSomeValue() async {
    var lastSeen = await _hiveBox.get("LastSeen");
    lastSeen = (lastSeen == null)
        ? "Welcome To $appName App"
        : "Last Seen On ➺ ${DateFormat("d MMM ").add_jm().format(lastSeen)}";

    Get.snackbar(
      "Hey,${(loggedMobile.length == 10) ? loggedMobile.replaceRange(1, 6, "*" * (10 - 3)) : ""}",
      lastSeen,
      backgroundColor: color4.withOpacity(0.2),
      icon: const Icon(FontAwesomeIcons.solidSmileWink, color: Colors.white),
      snackPosition: SnackPosition.BOTTOM,
    );
    await _hiveBox.put("LastSeen", DateTime.now());
    SpamZone.sendRndmMsgToChannel();
    var _currentDateTime = await NTP.now();
    SmallServices.updateUserActivityByDate(
        userIdMob: loggedMobile,
        newItemsAsList: [
          "Logged in to $appName at ${timeAsTxt(_currentDateTime.toString())}",
        ]);
    animateHomeAlertBar();
  }

  @override
  void onClose() {
    Get.deleteAll(force: true);
    super.onClose();
    // Get.delete<MainFrameGService>();
  }

  String currentDevice = "ERR";
  void readDeviceInfo() async {
    try {
      var deviceInfo = await deviceInfoPlugin.androidInfo;
      currentDevice = deviceInfo.model ?? "ERR";
    } catch (e) {
      print("Read Device Info Filed");
    }
  }

  void logout() {
    SmartDialog.show(
      alignmentTemp: Alignment.center,
      clickBgDismissTemp: true,
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
                const Expanded(
                  child: Icon(
                    FontAwesomeIcons.doorOpen,
                    size: 50,
                  ),
                ),
                const Text(
                  "Do you want to logout from this account?",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: colorWhite),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Divider(
                  color: colorWhite,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () async {
                          await _hiveBox.deleteAll(
                              [FireString.mobileNo, FireString.password]);
                          await _hiveBox.clear();
                          await _hiveBox.close();
                          onClose();
                          FirebaseFirestore.instance.clearPersistence();
                          SmartDialog.dismiss();
                          SystemNavigator.pop();
                        },
                        child: const Text(
                          "Logout - Exit",
                          style: TextStyle(color: colorWhite),
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          SmartDialog.dismiss();
                          Get.to(UserPersonalInfoScreen());
                        },
                        child: const Text(
                          "Set Password",
                          style: TextStyle(color: colorWhite),
                        ),
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

//////////////Fake Alerts section methods
  Rx<Widget> alertBar = const Text.rich(TextSpan()).obs;

  List rechargeType = ["Upi", "Card", "Netbanking"];
  animateHomeAlertBar() async {
    int randomCategory = Random().nextInt(4);
    int randMin = Random().nextInt(35) + 20;
    int randFourDigit = Random().nextInt(88888) + 11111;
    int rndmAmount = Random().nextInt(14000) + 500;
    int fakeBankAc = Random().nextInt(88888) + 11111;
    if (randomCategory == 0) {
      alertBar.value = Text.rich(TextSpan(
          text: '$randMin min ago',
          style: const TextStyle(color: color4),
          children: [
            TextSpan(
              text:
                  '\nXXXXXX$randFourDigit withdraw Rs.$rndmAmount to bank ac end with $fakeBankAc',
              style: TextStyle(color: colorWhite.withOpacity(0.7)),
            )
          ]));
    }
    if (randomCategory == 1) {
      alertBar.value = Text.rich(TextSpan(
          text: '$randMin min ago',
          style: const TextStyle(color: color4),
          children: [
            TextSpan(
              text:
                  '\nXXXXXX$randFourDigit deposit Rs.$rndmAmount to wallet by ${rechargeType[Random().nextInt(rechargeType.length)]}',
              style: TextStyle(color: colorWhite.withOpacity(0.7)),
            )
          ]));
    }
    if (randomCategory == 2) {
      alertBar.value = Text.rich(TextSpan(
          text: '$randMin min ago',
          style: const TextStyle(color: color4),
          children: [
            TextSpan(
              text:
                  '\nXXXXXX$randFourDigit registered to the $appName server ${(randFourDigit % 2 == 0 ? " referred by ${fakeNames[Random().nextInt(fakeNames.length)]}" : "")}',
              style: TextStyle(color: colorWhite.withOpacity(0.7)),
            )
          ]));
    }
    if (randomCategory == 3) {
      alertBar.value = Text.rich(TextSpan(
          text: '$randMin min ago',
          style: const TextStyle(color: color4),
          children: [
            TextSpan(
              text:
                  '\n${fakeNames[Random().nextInt(fakeNames.length)]} bought ${Random().nextInt(4) + 1} $appNameShort plans',
              style: TextStyle(color: colorWhite.withOpacity(0.7)),
            )
          ]));
    }
    int randMillisec = Random().nextInt(2000) + 500;
    await Future.delayed(Duration(milliseconds: randMillisec));
    animateHomeAlertBar();
  }
}
