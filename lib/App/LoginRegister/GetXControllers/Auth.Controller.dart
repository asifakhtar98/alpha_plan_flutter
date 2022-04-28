import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:lottie/lottie.dart';
import 'package:ntp/ntp.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:powerbank/App/MainFrame/Ui/Main.Frame.Ui.dart';
import 'package:powerbank/Constants/Colors.dart';
import 'package:powerbank/Constants/strings.dart';
import 'package:powerbank/GetxStreams/Server.Permit.Stream.dart';
import 'package:powerbank/HelperClasses/Server.Stats.Service.dart';
import 'package:powerbank/HelperClasses/SpamZone.dart';
import 'package:powerbank/HelperClasses/Widgets.dart';
import 'package:powerbank/HelperClasses/date_time_formatter.dart';
import 'package:powerbank/HelperClasses/small_services.dart';
import 'package:powerbank/generated/assets.dart';

var _serverPermitStreamController = Get.find<ServerPermitStreamController>();
var _serverStatsController = Get.find<ServerStatsController>();

class AuthGController extends GetxController {
  final FirebaseFirestore _firestoreIns = FirebaseFirestore.instance;
  late final CollectionReference accounts;
  RxInt currentStackViewIndex = 0.obs;
  final phoneNoToVerify = ''.obs;
  var countryCode = "+91".obs;
  var currentCaptha = "".obs;
  final _hiveBox = Hive.box(hiveBoxName);
  //////////////////////////////////
  var showRegMobileTick = false.obs;
  var showRegPassTick = false.obs;
  var showRegConfPassTick = false.obs;
  var showLoginMobileTick = false.obs;
  var showReferrerBoxTick = false.obs;
  ////////////////////////////////

  void reload() async {
    setNewCapthaCode(5);
    accounts = _firestoreIns.collection(FireString.accounts);
    //Check For Local Saved Data To Login
    var _mNo = await _hiveBox.get(FireString.mobileNo) ?? "";
    print("The No: $_mNo");
    if (_mNo != "" && _mNo != null) {
      SmartDialog.showLoading(background: colorLoadingAnim, backDismiss: false);
      var _pass = await _hiveBox.get(FireString.password) ?? "";
      await Future.delayed(const Duration(seconds: 1));
      loginUser(mNo: _mNo, pass: _pass, captha: currentCaptha.value);
    }
    _serverStatsController.loadGlobalStats();
  }

  Future<void> registerUser(
      {required String mNo,
      required String pass,
      required String cPass,
      required String captha,
      String referredByCode = ""}) async {
    phoneNoToVerify.value = mNo;
    //Register Form validation
    if (!_serverPermitStreamController.appRegEnabled) {
      Get.snackbar(
        "In maintenance",
        "For a couple of time new registration will not success",
        duration: const Duration(seconds: 6),
        backgroundColor: color4.withOpacity(0.2),
        icon: const Icon(FontAwesomeIcons.solidDizzy, color: Colors.white),
        snackPosition: SnackPosition.BOTTOM,
      );
    } else if (currentCaptha.value != captha) {
      Get.snackbar(
        "Hey,$appName User",
        "Wrong Security Code",
        backgroundColor: color4.withOpacity(0.2),
        icon: const Icon(FontAwesomeIcons.solidDizzy, color: Colors.white),
        snackPosition: SnackPosition.BOTTOM,
      );
    } else if (pass.length < minPasswordSize &&
        cPass.length < minPasswordSize) {
      Get.snackbar(
        "Hey,$appName User",
        "Password is to short, Minimum digit = $minPasswordSize",
        backgroundColor: color4.withOpacity(0.2),
        icon: const Icon(FontAwesomeIcons.solidDizzy, color: Colors.white),
        snackPosition: SnackPosition.BOTTOM,
      );
    } else if (cPass != pass) {
      Get.snackbar(
        "Hey,$appName User",
        "Password Are Not Matching",
        backgroundColor: color4.withOpacity(0.2),
        icon: const Icon(FontAwesomeIcons.solidDizzy, color: Colors.white),
        snackPosition: SnackPosition.BOTTOM,
      );
    } else if (mNo.length != 10) {
      Get.snackbar(
        "Hey,$appName User",
        "Enter a valid 10 digit no.",
        backgroundColor: color4.withOpacity(0.2),
        icon: const Icon(FontAwesomeIcons.solidDizzy, color: Colors.white),
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      //Wait for self verify number
      bool warnedUser = await warnUserToCheckNumber();

      if (warnedUser) {
        SmartDialog.showLoading(
            background: colorLoadingAnim,
            backDismiss: false,
            msg: "Registering Wait");

        try {
          if (await InternetConnectionChecker().hasConnection != true) {
            SmartDialog.showToast("No Internet Connection");
            throw "noInternetConnection";
          }

          //Check if this no is account firestore collection
          var _tempCollection = await accounts.doc(mNo).get();
          // print(_tempCollection.exists);
          if (_tempCollection.exists) {
            //When user already registered
            SmartDialog.dismiss();
            Get.snackbar(
              "Hey,Login",
              "You are already registered",
              backgroundColor: color4.withOpacity(0.2),
              icon:
                  const Icon(FontAwesomeIcons.solidDizzy, color: Colors.white),
              snackPosition: SnackPosition.BOTTOM,
            );
          } else {
            //Check if refer code is compulsory
            if (_serverPermitStreamController.isReferCodeCompulsory.value &&
                showReferrerBoxTick.isFalse) {
              Get.snackbar(
                "Refer code is compulsory",
                "Enter a valid refer code to create account",
                backgroundColor: color4.withOpacity(0.2),
                icon: const Icon(FontAwesomeIcons.solidDizzy,
                    color: Colors.white),
                snackPosition: SnackPosition.BOTTOM,
              );
              if (showReferrerBoxTick.isFalse) throw "noReferrerCode";
            }
            //Proceed to firestore registration
            SmartDialog.showLoading(
                background: colorLoadingAnim,
                backDismiss: false,
                msg: "Registering Wait");
            await accounts.doc(mNo).set({
              FireString.mobileNo: phoneNoToVerify.value,
              FireString.password: pass,
              FireString.countryCode: countryCode.value,
              FireString.canLogin: true,
            }, SetOptions(merge: true)).then((_) async {
              //Get signup bonus
              var specialEventsValue = await _firestoreIns
                  .collection(FireString.globalSystem)
                  .doc(FireString.atSpecialEvents)
                  .get();
              int signupBonus =
                  specialEventsValue.get(FireString.signUpBonus) ?? 0;
              if (signupBonus != 0) {
                SmartDialog.showToast("Got Signup Bonus of Rs. $signupBonus");
              }
              //After firestore account creation
              await _firestoreIns
                  .collection(FireString.accounts)
                  .doc(mNo)
                  .collection(FireString.walletBalance)
                  .doc(FireString.document1)
                  .set({
                FireString.depositCoin: signupBonus,
                FireString.withdrawableCoin: 0,
                FireString.investReturn: 0,
                FireString.referralIncome: 0,
                FireString.lifetimeDeposit: 0,
                FireString.totalWithdrawal: 0,
                FireString.upcomingIncome: 0,
                FireString.totalRefers: 0,
              }, SetOptions(merge: true));
              await _firestoreIns
                  .collection(FireString.accounts)
                  .doc(mNo)
                  .collection(FireString.walletBalance)
                  .doc(FireString.document2)
                  .set({
                FireString.canWithdraw: true,
                FireString.noOfInvestment: 0,
                FireString.noOfWithdraw: 0,
                FireString.lastWithdrawStatus: "",
              }, SetOptions(merge: true));
              var currentDateTime = await NTP.now();
              SmallServices.updateUserActivityByDate(
                  userIdMob: mNo,
                  newItemsAsList: [
                    "Registered successfully to $appName at ${ddMMMyyyyTime(currentDateTime.toString())}",
                    "Received signup bonus of Rs. $signupBonus",
                    if (referredByCode.isNotEmpty)
                      "Used the refer code $referredByCode",
                    if (referredByCode.isEmpty)
                      "Haven't used any refer-code while registration"
                  ]);
              await _firestoreIns
                  .collection(FireString.accounts)
                  .doc(mNo)
                  .collection(FireString.personalInfo)
                  .doc(FireString.document1)
                  .set({
                FireString.fullName: "",
                FireString.registeredOn: currentDateTime
              }, SetOptions(merge: true));

              Get.find<ServerStatsController>().pushServerGlobalStats(
                  fireString: FireString.totalGlobalUsers, valueToAdd: 1);
            });
            setUserReferData(referredByCode: referredByCode, mobileNo: mNo);
            await Future.delayed(const Duration(seconds: 3));
            loginUser(mNo: mNo, pass: pass, captha: currentCaptha.value);
          }
        } catch (e) {
          print(e.toString());

          SmartDialog.dismiss();
        }
      }
    }
  }

  ////////////////////////

  void loginUser(
      {required String mNo,
      required String pass,
      required String captha}) async {
    mNo = mNo.removeAllWhitespace
        .replaceAll(",", "")
        .replaceAll("-", "")
        .replaceAll(".", "")
        .replaceAll("+91", "");
    phoneNoToVerify.value = mNo;
    await _hiveBox.clear();
    if (currentCaptha.value != captha) {
      Get.snackbar(
        "Hey,$appName User",
        "Wrong Security Code",
        backgroundColor: color4.withOpacity(0.2),
        icon: const Icon(FontAwesomeIcons.solidDizzy, color: Colors.white),
        snackPosition: SnackPosition.BOTTOM,
      );
    } else if (pass.length < minPasswordSize) {
      Get.snackbar(
        "Hey,$appName User",
        "Password is to short, Minimum digit = $minPasswordSize",
        backgroundColor: color4.withOpacity(0.2),
        icon: const Icon(FontAwesomeIcons.solidDizzy, color: Colors.white),
        snackPosition: SnackPosition.BOTTOM,
      );
    } else if (mNo.length != 10) {
      Get.snackbar(
        "Hey,$appName User",
        "Enter a valid 10 digit no.",
        backgroundColor: color4.withOpacity(0.2),
        icon: const Icon(FontAwesomeIcons.solidDizzy, color: Colors.white),
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      SmartDialog.showLoading(
          background: colorLoadingAnim, backDismiss: false, msg: "Logging In");
      try {
        if (await InternetConnectionChecker().hasConnection != true) {
          SmartDialog.showToast("No Internet Connection");
          throw "noInternetConnection";
        }
        //Fetching password to verify user form

        var userData = await accounts.doc(phoneNoToVerify.value).get();
//check for user data existence
        if (userData.exists) {
          String onlinePass = await userData.get(FireString.password);
          bool canLogin = await userData.get(FireString.canLogin);
          if (canLogin) {
            if (pass != onlinePass) {
              //if password dont match
              Get.snackbar(
                "Hey,Wrong Password",
                "Try to remember or reset the password",
                backgroundColor: color4.withOpacity(0.2),
                icon: const Icon(FontAwesomeIcons.solidDizzy,
                    color: Colors.white),
                snackPosition: SnackPosition.BOTTOM,
              );
              SmartDialog.dismiss();
            } else {
              await Future.delayed(const Duration(seconds: 3));

              //if no and password correct save no in hive and push home Screen
              if (_serverPermitStreamController.blockFullAccess) {
              } else {
                _hiveBox
                    .put(FireString.mobileNo, mNo)
                    .then((value) => print("No Saved To Hive"));
                _hiveBox.put(FireString.password, pass);
                SmartDialog.dismiss(status: SmartStatus.loading);
                Get.offAllNamed(MainFrame.screenName);
                OneSignal.shared.setExternalUserId(mNo);
              }
            }
          } else {
            SmartDialog.dismiss(status: SmartStatus.loading);
            showBannedDialog();
          }
        } else {
          //If no user is registered with than trying login number
          SmartDialog.dismiss();
          Get.snackbar(
            "Hey,Register",
            "This number is not registered",
            backgroundColor: color4.withOpacity(0.2),
            icon: const Icon(FontAwesomeIcons.solidDizzy, color: Colors.white),
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      } catch (e) {
        print(e);
        SmartDialog.dismiss(status: SmartStatus.loading);
      }
    }
  }

  ///////////////////////////

  void setNewCapthaCode(int length) {
    String _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    currentCaptha.value = String.fromCharCodes(
      Iterable.generate(
        length,
        (_) => _chars.codeUnitAt(
          Random().nextInt(_chars.length),
        ),
      ),
    );
  }

  Future<bool> warnUserToCheckNumber() async {
    bool canRegister = false;

    await SmartDialog.show(
      alignmentTemp: Alignment.center,
      clickBgDismissTemp: true,
      widget: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const DialogAppNameTag(),
          Container(
            width: Get.width - 70,
            height: 370,
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
                    Lottie.asset(Assets.assetsDialerBounce,
                        height: 70, width: 70),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                        phoneNoToVerify.value
                            .replaceRange(1, 6, "*" * (10 - 3)),
                        style: const TextStyle(
                            color: colorWhite, fontWeight: FontWeight.bold)),
                  ],
                ),
                const Spacer(),
                const Text(
                  "Is this a valid and working mobile number?",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: colorWhite),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  "(Account with invalid number are restricted to recharge wallet or fund withdrawal by banking system)",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: colorWhite, fontSize: 10),
                ),
                const Spacer(),
                const Divider(
                  color: colorWhite,
                ),
                TextButton(
                  onPressed: () {
                    canRegister = true;
                    SmartDialog.dismiss();
                  },
                  child: const Text(
                    "Yes, Valid - Continue",
                    style: TextStyle(color: colorWhite),
                  ),
                ),
                const Divider(
                  color: colorWhite,
                ),
                TextButton(
                  onPressed: () {
                    canRegister = false;
                    SmartDialog.dismiss();
                  },
                  child: const Text(
                    "Re-check Number",
                    style: TextStyle(color: colorWhite),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
    return canRegister;
  }

  void showBannedDialog() {
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
            height: 370,
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
                    Text(
                        phoneNoToVerify.value
                            .replaceRange(1, 6, "*" * (10 - 3)),
                        style: const TextStyle(
                            color: colorWhite, fontWeight: FontWeight.bold)),
                  ],
                ),
                const Spacer(),
                const Text(
                  "This account is currently restricted from accessing :(",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: colorWhite),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  "(You may have violated our policies or terms, due to which you are not able to log in, you can appeal to us from re-grunting login permission via appealing us)",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: colorWhite, fontSize: 10),
                ),
                const Spacer(),
                const Divider(
                  color: colorWhite,
                ),
                TextButton(
                  onPressed: () {
                    CustomerSupport.whatsappSupportAdmin1();
                  },
                  child: const Text(
                    "Appeal Now",
                    style: TextStyle(color: colorWhite),
                  ),
                ),
                const Divider(
                  color: colorWhite,
                ),
                TextButton(
                  onPressed: () async {
                    SmartDialog.dismiss();
                    await _hiveBox.clear();
                  },
                  child: const Text(
                    "Create new account",
                    style: TextStyle(color: colorWhite),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  validateReferrerCode(String referrer) {
    FirebaseFirestore.instance
        .collection(FireString.refMobMapping)
        .doc(referrer)
        .get()
        .then((value) {
      if (value.exists) {
        showReferrerBoxTick.value = true;
      } else {
        showReferrerBoxTick.value = false;
      }
    });
  }

  setUserReferData({required String mobileNo, required referredByCode}) async {
    var currentDateTime = await NTP.now();
    //generate new refer code of 16 Digit
    String newReferCode =
        "$referCodePrefix${Random().nextInt(444444) + Random().nextInt(444444) + 111111}${mobileNo.replaceRange(1, 6, "" * (10 - 3))}";
    try {
      //save it to code mapping
      await FirebaseFirestore.instance
          .collection(FireString.refMobMapping)
          .doc(newReferCode)
          .set({FireString.mobileNo: mobileNo}, SetOptions(merge: true));
      //save my refer code to user level refer data
      await FirebaseFirestore.instance
          .collection(FireString.accounts)
          .doc(mobileNo)
          .collection(FireString.myReferData)
          .doc(FireString.document1)
          .collection(FireString.userReferCodes)
          .doc(newReferCode)
          .set({FireString.registeredOn: currentDateTime},
              SetOptions(merge: true));
      //enable get commission permission
      await FirebaseFirestore.instance
          .collection(FireString.accounts)
          .doc(mobileNo)
          .collection(FireString.myReferData)
          .doc(FireString.document1)
          .set({FireString.canGetCommission: true}, SetOptions(merge: true));
      //find referrer code in ref code mapping
      if (showReferrerBoxTick.value) {
        await FirebaseFirestore.instance
            .collection(FireString.refMobMapping)
            .doc(referredByCode)
            .get()
            .then((documentSnap) async {
          print("Inside Referrer check");
          if (documentSnap.exists) {
            print("Referrer Exist");
            //save referrer(upline) mob no to user level refer data
            await FirebaseFirestore.instance
                .collection(FireString.accounts)
                .doc(mobileNo)
                .collection(FireString.myReferData)
                .doc(FireString.document1)
                .set({
              FireString.userReferredBy: documentSnap[FireString.mobileNo]
            }, SetOptions(merge: true));
//Add to referrer activity
            SmallServices.updateUserActivityByDate(
                userIdMob: documentSnap[FireString.mobileNo],
                newItemsAsList: [
                  "Your refer code was used by ${mobileNo.replaceRange(1, 6, "*" * (10 - 3))}"
                ]);
            //Increse Upline Total Refers
            await FirebaseFirestore.instance
                .collection(FireString.accounts)
                .doc(documentSnap[FireString.mobileNo])
                .collection(FireString.walletBalance)
                .doc(FireString.document1)
                .set({FireString.totalRefers: FieldValue.increment(1)},
                    SetOptions(merge: true));

            ///Build Refers Tree of upline
            await FirebaseFirestore.instance
                .collection(FireString.usersDirectRefers)
                .doc(documentSnap[FireString.mobileNo])
                .collection(FireString.mobileNo)
                .doc(mobileNo)
                .set({FireString.registeredOn: currentDateTime},
                    SetOptions(merge: true));
            SpamZone.sendMsgToTelegram("New $appNameShort User:", mobileNo,
                "Referred By: ${documentSnap[FireString.mobileNo]}",
                toAdmin: true, toTgUsers: false);
          } else {
            print("Referrer Don't Exist");
          }
        });
      } else {
        SpamZone.sendMsgToTelegram("New $appNameShort User:", mobileNo, "",
            toAdmin: true, toTgUsers: false);
      }
    } catch (e) {
      print(e);
    }
  }
}
