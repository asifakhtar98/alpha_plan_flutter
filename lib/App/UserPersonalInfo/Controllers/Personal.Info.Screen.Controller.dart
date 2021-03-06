import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:powerbank/Constants/Colors.dart';
import 'package:powerbank/Constants/firestore_strings.dart';
import 'package:powerbank/Constants/strings.dart';
import 'package:powerbank/HelperClasses/Widgets.dart';
import 'package:powerbank/HelperClasses/date_time_formatter.dart';
import 'package:powerbank/HelperClasses/small_services.dart';

class PersonalInfoScreenController extends GetxService {
  final altNoController = TextEditingController();
  final addressController = TextEditingController();
  final zipCodeController = TextEditingController();
  final fullNameContrlr = TextEditingController();

  final primaryEmailFieldContrlr = TextEditingController();

  final nomineeNameController = TextEditingController();
  final nomineeNumberController = TextEditingController();
  final oldPassController = TextEditingController();
  final newPassController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _hiveBox = Hive.box(hiveBoxName);
  //will save the doc as map
  RxMap personalInfo = <String, dynamic>{}.obs;

  void savePersonalInfo({
    required String nameText,
    required String emailText,
    required String addressText,
    required String zipcodeText,
    required String alternateNoText,
  }) async {
    String mNo = await _hiveBox.get(FireString.mobileNo);
    DocumentReference personalInfo = _firestore
        .collection(FireString.accounts)
        .doc(mNo)
        .collection(FireString.personalInfo)
        .doc(FireString.document1);
    if (nameText == "") {
      SmartDialog.showToast('Wrong Name');
    } else if (!GetUtils.isEmail(emailText)) {
      SmartDialog.showToast('Wrong Email');
    } else {
      SmartDialog.showToast("Saving");
      await personalInfo.set({
        FireString.fullName: nameText,
        FireString.primaryEmail: emailText,
        FireString.address: addressText,
        FireString.zipCode: zipcodeText,
        FireString.alternateNumber: alternateNoText,
      }, SetOptions(merge: true));

      saveToHiveBox();
      SmartDialog.showToast("Success");
      var currentDateTime = await DateTimeHelper.getCurrentDateTime();
      SmallServices.updateUserActivityByDate(userIdMob: mNo, newItemsAsList: [
        "Changed Basic info at ${timeAsTxt(currentDateTime.toString())}"
      ]);
    }
  }

  ///////////////////////
  void getLivePersonalData() async {
    try {
      String mNo = await _hiveBox.get(FireString.mobileNo);
      await _firestore
          .collection(FireString.accounts)
          .doc(mNo)
          .collection(FireString.personalInfo)
          .doc(FireString.document1)
          .get()
          .then((personalData) {
        if (personalData.exists) {
          //this can replace all rx var
          personalInfo.assignAll(personalData.data()!);
          // print("Data Loaded From Firestore");
          fullNameContrlr.text = personalData[FireString.fullName] ?? "";
          primaryEmailFieldContrlr.text =
              personalData[FireString.primaryEmail] ?? "";
          addressController.text = personalData[FireString.address] ?? "";
          zipCodeController.text = personalData[FireString.zipCode] ?? "";
          altNoController.text =
              personalData[FireString.alternateNumber] ?? "";
          saveToHiveBox();
        }
      });
    } catch (e) {
      print("Personal Data Loading Failed Caught");
    }
  }

  void saveToHiveBox() {
    _hiveBox.put(FireString.fullName, fullNameContrlr.text);
    _hiveBox.put(FireString.primaryEmail, primaryEmailFieldContrlr.text);
    _hiveBox.put(FireString.address, addressController.text);
    _hiveBox.put(FireString.zipCode, zipCodeController.text);
    _hiveBox.put(FireString.alternateNumber, altNoController.text);
    // print("Data Saved To Hive");
  }

///// nominee

  saveNominee({required String name, required String number}) async {
    try {
      if (name.isEmpty || number.isEmpty) {
        SmartDialog.showToast("Enter both field correctly");
        throw "required field empty";
      }
      String mNo = await _hiveBox.get(FireString.mobileNo);
      await FirebaseFirestore.instance
          .collection(FireString.accounts)
          .doc(mNo)
          .collection(FireString.personalInfo)
          .doc(FireString.document1)
          .set({
        FireString.nomineeName: name,
        FireString.nomineeNumber: number,
      }, SetOptions(merge: true)).then((value) {
        SmartDialog.showToast("Saved");
      });
    } catch (e) {
      print(e.toString());
    }
  }

  ///////////////////////////change password
  changePassword({required String oldPass, required String newPass}) async {
    if (oldPass.length >= 6 && newPass.length >= 6) {
      try {
        String mNo = await _hiveBox.get(FireString.mobileNo);
        await FirebaseFirestore.instance
            .collection(FireString.accounts)
            .doc(mNo)
            .get()
            .then((doc) {
          if (oldPass == doc[FireString.password]) {
            FirebaseFirestore.instance
                .collection(FireString.accounts)
                .doc(mNo)
                .set({FireString.password: newPass},
                    SetOptions(merge: true)).then(
              (_) {
                SmartDialog.showToast("Password  Changed Success");
                SmartDialog.show(
                  alignmentTemp: Alignment.center,
                  widget: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                            const Icon(
                              FontAwesomeIcons.checkDouble,
                              color: color3,
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              "Password Changed",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: color1),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              "Number: $mNo",
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: colorWhite),
                            ),
                            Text(
                              "Password: $newPass",
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: colorWhite),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              "(Save your new account credential somewhere or save a screenshot for future reference)",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: colorWhite, fontSize: 10),
                            ),
                            const Divider(
                              color: colorWhite,
                            ),
                            TextButton(
                              onPressed: () {
                                SmartDialog.dismiss();
                              },
                              child: const Text(
                                "Ok, I will remember",
                                style: TextStyle(color: colorWhite),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            SmartDialog.showToast("Ohho, wrong current password");
          }
        });
      } catch (e) {}
    } else {
      SmartDialog.showToast("Both password length should 6+");
    }
  }

  reload() {
    fullNameContrlr.clear();
    addressController.clear();
    zipCodeController.clear();
    altNoController.clear();
    primaryEmailFieldContrlr.clear();
    nomineeNameController.clear();
    nomineeNumberController.clear();
    oldPassController.clear();
    newPassController.clear();
    getLivePersonalData();
  }
}
