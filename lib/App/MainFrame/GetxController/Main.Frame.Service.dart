import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:powerbank/App/UserPersonalInfo/User.Personal.Info.Screen.dart';
import 'package:powerbank/Constants/Colors.dart';
import 'package:powerbank/Constants/Fake.Data.dart';
import 'package:powerbank/Constants/firestore_strings.dart';
import 'package:powerbank/Constants/strings.dart';
import 'package:powerbank/GetxStreams/Server.Permit.Stream.dart';
import 'package:powerbank/HelperClasses/SpamZone.dart';
import 'package:powerbank/HelperClasses/Widgets.dart';
import 'package:powerbank/HelperClasses/date_time_formatter.dart';
import 'package:powerbank/HelperClasses/small_services.dart';

import '../../../generated/assets.dart';

var _serverPermitStreamController = Get.find<ServerPermitStreamController>();

class MainFrameGService extends GetxService {
  DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  Rx<int> currentNavIndex = 0.obs;
  final _hiveBox = Hive.box(hiveBoxName);
  late String loggedMobile;
  @override
  void onInit() async {
    super.onInit();
    readDeviceInfo();
    loggedMobile = await _hiveBox.get(FireString.mobileNo) ?? "";
    print(loggedMobile);
    initSomeValue();
    getReqDataAndLocalIt();
    checkIdVerification();
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
    var currentDateTime = await DateTimeHelper.getCurrentDateTime();
    SmallServices.updateUserActivityByDate(
        userIdMob: loggedMobile,
        newItemsAsList: [
          "Logged in to $appName at ${timeAsTxt(currentDateTime.toString())}",
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
                          Get.to(const UserPersonalInfoScreen());
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
                  '\nXXXXXX$randFourDigit deposit Rs.${(Random().nextInt(37) + 3) * 100} to wallet by ${rechargeType[Random().nextInt(rechargeType.length)]}',
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
                  '\nXXXXXX$randFourDigit registered to the $appNameShort app ${(randFourDigit % 2 == 0 ? " referred by ${fakeNames[Random().nextInt(fakeNames.length)]}" : "")}',
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

  ///////////////////////////
  void getReqDataAndLocalIt() async {
    await Future.delayed(const Duration(milliseconds: 4000));
    try {
      String mNo = await _hiveBox.get(FireString.mobileNo);
      await FirebaseFirestore.instance
          .collection(FireString.accounts)
          .doc(mNo)
          .collection(FireString.personalInfo)
          .doc(FireString.document1)
          .get()
          .then((personalData) {
        if (personalData.exists) {
          _hiveBox.put(
              FireString.fullName, personalData[FireString.fullName] ?? "");
          if (personalData[FireString.fullName] == "" ||
              personalData[FireString.fullName] == null) {
            Get.to(() => const UserPersonalInfoScreen());
            SmartDialog.showToast("Please fill this info");
          }
          print("Full name: ${personalData[FireString.fullName]}");
        }
      });
    } catch (e) {
      print(e);
    }
  }

  ///////////////////////////////////////////////////
  checkIdVerification() async {
    await Future.delayed(const Duration(milliseconds: 4000));
    if (_serverPermitStreamController.shouldVerifyIdByOtp.isFalse) {
      return;
    }
    bool isOtpVerified = await _hiveBox.get(FireString.isOtpVerified);
    if (isOtpVerified == true) {
      return;
    }
    String mNo = await _hiveBox.get(FireString.mobileNo);
    try {
      await FirebaseFirestore.instance
          .collection(FireString.accounts)
          .doc(mNo)
          .get()
          .then((accData) {
        if (accData.exists) {
          if (accData[FireString.isOtpVerified] == false) {
            showIdVerificationDialog(mNo);
          }
        }
      });
    } catch (e) {
      print(e);
      showIdVerificationDialog(mNo);
    }
  }

  showIdVerificationDialog(String mobNo) {
    try {
      String userEnteredOTP = "";
      String currentOTP = "${Random().nextInt(8888) + 1111}";
      Dio().get('https://www.fast2sms.com/dev/bulkV2', queryParameters: {
        "authorization":
            "MJA0BoDCzSjgaTHIQROdpY98rcEy6P7q34GUn5LsbeFhiwZumvn5BxY6grRyPdpSDeuJ7qHOC12Fozsa",
        "route": " v3",
        " sender_id": "Cghpet",
        " message": "$currentOTP is your $appName App OTP.",
        " language": "english",
        "  numbers": mobNo,
        "flash": "0"
      });
      SmartDialog.show(
          alignmentTemp: Alignment.topCenter,
          widget: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 60,
              ),
              const DialogAppNameTag(),
              Container(
                width: Get.width - 70,
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
                    Column(
                      children: [
                        Lottie.asset(Assets.assetsStopWarning,
                            height: 70, width: 70),
                        const SizedBox(
                          height: 8,
                        ),
                        const Text("Is this your phone number?\nThen verify it",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: colorWhite,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "4 Digit OTP is sent to your\nMobile number $mobNo",
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: colorWhite),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextField(
                      style: const TextStyle(color: colorWhite),
                      onChanged: (v) {
                        userEnteredOTP = v;
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          prefixIcon: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                FontAwesomeIcons.sms,
                                color: colorWhite,
                              ),
                              Text(
                                "   ",
                                style:
                                    TextStyle(color: colorWhite, fontSize: 1),
                              ),
                            ],
                          ),
                          hintText: "Enter Sms OTP"),
                    ),
                    const SizedBox(height: 8),
                    const Divider(
                      color: colorWhite,
                    ),
                    TextButton(
                      onPressed: () async {
                        if (userEnteredOTP == currentOTP) {
                          await FirebaseFirestore.instance
                              .collection(FireString.accounts)
                              .doc(mobNo)
                              .set({
                            FireString.isOtpVerified: true,
                          }, SetOptions(merge: true));

                          SmartDialog.showToast("OTP verification success");
                          SmartDialog.dismiss();
                          _hiveBox.put(FireString.isOtpVerified, true);
                        } else {
                          SmartDialog.showToast("Wrong OTP");
                        }
                      },
                      child: const Text(
                        "Proceed",
                        style: TextStyle(color: colorWhite),
                      ),
                    ),
                    const Divider(
                      color: colorWhite,
                    ),
                    TextButton(
                      onPressed: () {
                        CustomerSupport.openFirestoreExternalLinks(
                            fbFieldName: FireString.premiumCustomerSupportLink);
                      },
                      child: const Text(
                        "Verify Via Admin",
                        style: TextStyle(color: colorWhite),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ));
    } catch (e) {
      print(e);
      SmartDialog.showToast("Otp Id Verification Failed $e");
    }
  }
}
