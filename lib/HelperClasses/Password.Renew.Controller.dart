import 'dart:math';

import 'package:async_button_builder/async_button_builder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';
import 'package:powerbank/App/LoginRegister/GetXControllers/Auth.Controller.dart';
import 'package:powerbank/Constants/firestore_strings.dart';
import 'package:powerbank/Constants/strings.dart';
import 'package:powerbank/generated/assets.dart';

import '../Constants/Colors.dart';
import 'Widgets.dart';

class PasswordRenewController extends GetxController {
  String fast2SmsAdminAuthKey =
      "MJA0BoDCzSjgaTHIQROdpY98rcEy6P7q34GUn5LsbeFhiwZumvn5BxY6grRyPdpSDeuJ7qHOC12Fozsa";
  String fast2SmsSenderId = "Cghpet";

  getFast2SmsData() async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection(FireString.globalSystem)
        .doc(FireString.fast2SmsData)
        .get();
    fast2SmsAdminAuthKey = doc[FireString.authKey];
    fast2SmsSenderId = doc[FireString.senderId];
    print(doc[FireString.senderId]);
  }

  final _hiveBox = Hive.box(hiveBoxName);
  final mobileNoController = TextEditingController();
  final passwordController = TextEditingController();
  String mobileNo = "";
  String newPassword = "";
  String currentOTP = "mk8dgr53357gdc4gtdr5";
  String userEnteredOTP = "";

  showRenewPasswordDialog() async {
    SmartDialog.show(
      alignmentTemp: Alignment.center,
      backDismiss: false,
      widget: Stack(
        clipBehavior: Clip.none,
        alignment: AlignmentDirectional.center,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const DialogAppNameTag(),
              Container(
                width: Get.width - 70,
                height: 320,
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
                      "Set a new password",
                      textAlign: TextAlign.end,
                      style: TextStyle(color: colorWhite),
                    ),
                    const Spacer(),
                    TextField(
                      style: const TextStyle(color: colorWhite),
                      controller: mobileNoController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          prefixIcon: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                FontAwesomeIcons.mobile,
                                color: colorWhite,
                              ),
                              Text(
                                "   ",
                                style:
                                    TextStyle(color: colorWhite, fontSize: 1),
                              ),
                            ],
                          ),
                          hintText: "Enter Mobile Number"),
                    ),
                    TextField(
                      style: const TextStyle(color: colorWhite),
                      controller: passwordController,
                      decoration: InputDecoration(
                          prefixIcon: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                FontAwesomeIcons.key,
                                color: colorWhite,
                              ),
                              Text(
                                "   ",
                                style:
                                    TextStyle(color: colorWhite, fontSize: 1),
                              ),
                            ],
                          ),
                          hintText: "Enter New Password"),
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
                    Row(
                      children: [
                        const Spacer(),
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            height: 35,
                            alignment: Alignment.center,
                            decoration:
                                BoxDecoration(color: color3.withOpacity(0.7)),
                            child: AsyncButtonBuilder(
                              loadingWidget: const Text('Resend-20S'),
                              successWidget: const Text('Try Later'),
                              errorWidget: const Text("Check Again"),
                              onPressed: () async {
                                passwordController.text = passwordController
                                    .text.removeAllWhitespace
                                    .replaceAll("/", "");
                                newPassword = passwordController.text;
                                mobileNoController.text = mobileNoController
                                    .text.removeAllWhitespace
                                    .replaceAll("-", "")
                                    .replaceAll(",", "")
                                    .replaceAll(".", "");
                                if (mobileNoController.text.length == 10) {
                                  if (passwordController.text.length >=
                                      minPasswordSize) {
                                    generateAndSendOtp(mobileNoController.text);
                                  } else {
                                    SmartDialog.showToast(
                                        "Minimum password length is $minPasswordSize");
                                    throw "wrongPassword";
                                  }
                                } else {
                                  SmartDialog.showToast(
                                      "Enter registered mobile number");
                                  throw "wrongMobileNo";
                                }

                                await Future.delayed(
                                    const Duration(seconds: 20));
                              },
                              builder: (context, child, callback, _) {
                                return TextButton(
                                  onPressed: callback,
                                  child: child,
                                );
                              },
                              child: const Text('Get OTP'),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    const Divider(
                      color: colorWhite,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 8,
                        ),
                        TextButton(
                          onPressed: () {
                            SmartDialog.dismiss(status: SmartStatus.dialog);
                          },
                          child: const Text(
                            "Cancel",
                            style: TextStyle(color: colorWhite),
                          ),
                        ),
                        Expanded(
                          child: AsyncButtonBuilder(
                            loadingWidget: const Text('Verifying'),
                            successWidget: const Text('Change Now'),
                            errorWidget: const Text("Change Now"),
                            onPressed: () async {
                              userEnteredOTP =
                                  userEnteredOTP.removeAllWhitespace;
                              if (mobileNoController.text.length == 10 &&
                                  mobileNoController.text == mobileNo) {
                                if (passwordController.text.length >=
                                    minPasswordSize) {
                                  if (userEnteredOTP == currentOTP) {
                                    changeUserPasswordAndLogin();
                                  } else {
                                    SmartDialog.showToast(
                                        "You entered wrong OTP");
                                  }
                                } else {
                                  SmartDialog.showToast(
                                      "Minimum password length is $minPasswordSize");
                                }
                              } else {
                                SmartDialog.showToast(
                                    "Try again with registered mobile number");
                              }

                              await Future.delayed(const Duration(seconds: 5));
                            },
                            builder: (context, child, callback, _) {
                              return TextButton(
                                onPressed: callback,
                                child: child,
                              );
                            },
                            child: const Text(
                              'Change Now',
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
          Positioned(
            left: 0,
            child: Column(
              children: [
                Lottie.asset(Assets.assetsSmsBubble, height: 120),
                const SizedBox(
                  height: 290,
                ),
              ],
            ),
          )
        ],
      ),
    );
    mobileNoController.text = await _hiveBox.get(FireString.mobileNo) ?? "";
    getFast2SmsData();
  }

  Dio dio = Dio();
  generateAndSendOtp(String mobileNo) async {
    currentOTP = "${Random().nextInt(8888) + 1111}";
    print(currentOTP);
    await Future.delayed(const Duration(seconds: 2));
    try {
      var userData = await FirebaseFirestore.instance
          .collection(FireString.accounts)
          .doc(mobileNo)
          .get();
//check for user data existence
      if (userData.exists) {
        if (userData.get(FireString.canLogin)) {
          print("Sending Forgrt Pass Otp");
          dio.get('https://www.fast2sms.com/dev/bulkV2', queryParameters: {
            "authorization": fast2SmsAdminAuthKey,
            "route": " v3",
            " sender_id": fast2SmsSenderId,
            " message": "$currentOTP is your $appName App OTP.",
            " language": "english",
            "  numbers": mobileNo,
            "flash": "0"
          });
          this.mobileNo = mobileNo;
        } else {
          SmartDialog.showToast(
              "This number is not allowed/banned, Create new account");
        }
      } else {
        SmartDialog.showToast("This number is not registered/wrong number");
      }
    } catch (e) {
      throw "generateAndSendOtpError";
    }
  }

  final _authGController = Get.find<AuthGController>();
  changeUserPasswordAndLogin() async {
    SmartDialog.dismiss(status: SmartStatus.dialog);
    SmartDialog.showToast("Reset Success - Wait Logging In Now");
    await FirebaseFirestore.instance
        .collection(FireString.accounts)
        .doc(mobileNo)
        .set({
      FireString.canLogin: false,
    }, SetOptions(merge: true));
    await FirebaseFirestore.instance
        .collection(FireString.accounts)
        .doc(mobileNo)
        .set({
      FireString.password: newPassword,
    }, SetOptions(merge: true)).then((value) async {
      await Future.delayed(const Duration(seconds: 2));
      await FirebaseFirestore.instance
          .collection(FireString.accounts)
          .doc(mobileNo)
          .set({
        FireString.canLogin: true,
      }, SetOptions(merge: true)).then((value) {
        _authGController.loginUser(
            mNo: mobileNo,
            pass: newPassword,
            captha: _authGController.currentCaptha.value);
      });
    });
  }
}
