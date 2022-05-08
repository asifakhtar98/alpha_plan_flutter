import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:hive/hive.dart';
import 'package:powerbank/Constants/Colors.dart';
import 'package:powerbank/Constants/firestore_strings.dart';
import 'package:powerbank/Constants/strings.dart';

import 'Controllers/Personal.Info.Screen.Controller.dart';

var _personalInfoScreenController = Get.put(PersonalInfoScreenController());

class UserPersonalInfoScreen extends StatelessWidget {
  UserPersonalInfoScreen({Key? key}) : super(key: key);
  final TextStyle _textStyle1 = const TextStyle(color: color4, fontSize: 13);

  final TextStyle _textStyle2 = const TextStyle(color: colorWhite);

  final TextEditingController _altNoController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();
  final TextEditingController _fullNameContrlr = TextEditingController();

  final TextEditingController _primaryEmailFieldContrlr =
      TextEditingController();

  final TextEditingController _nomineeNameController = TextEditingController();
  final TextEditingController _nomineeNumberController =
      TextEditingController();
  final TextEditingController _oldPassController = TextEditingController();
  final TextEditingController _newPassController = TextEditingController();
  final _hiveBox = Hive.box(hiveBoxName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color1,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: color2,
        title: const Text("My Personal Info"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                width: 8,
              ),
              Container(
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.amber.withOpacity(0.3),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: const Text(
                  "Please enter you personal info correctly and accurately and don't change it frequently.",
                  style: TextStyle(color: colorWhite, fontSize: 14),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 25),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 8,
                    ),
                    Container(
                      height: 25,
                      width: 5,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        gradient: LinearGradient(
                          colors: [color3, color4],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    const Text(
                      "About Me",
                      style: TextStyle(fontSize: 18, color: colorWhite),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Registered Mobile Number",
                      style: _textStyle1,
                    ),
                    const SizedBox(height: 8),
                    Container(
                      color: color2,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(13),
                      child: Text(
                        _hiveBox.get(FireString.mobileNo),
                        style: const TextStyle(color: colorWhite),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Your Legal Name",
                      style: _textStyle1,
                    ),
                    const SizedBox(height: 8),
                    Obx(() {
                      _fullNameContrlr.text =
                          _personalInfoScreenController.fullName.value;
                      return TextField(
                        controller: _fullNameContrlr,
                        style: _textStyle2,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter your full name",
                            fillColor: color2,
                            filled: true),
                      );
                    }),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Your Address",
                      style: _textStyle1,
                    ),
                    const SizedBox(height: 8),
                    Obx(() {
                      _addressController.text =
                          _personalInfoScreenController.address.value;
                      return TextField(
                        controller: _addressController,
                        style: _textStyle2,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Optional",
                            fillColor: color2,
                            filled: true),
                      );
                    }),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Area Zip Code",
                      style: _textStyle1,
                    ),
                    const SizedBox(height: 8),
                    Obx(() {
                      _zipCodeController.text =
                          _personalInfoScreenController.zipcode.value;
                      return TextField(
                        controller: _zipCodeController,
                        keyboardType: TextInputType.number,
                        style: _textStyle2,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter your Zip Code",
                            fillColor: color2,
                            filled: true),
                      );
                    }),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Personal Email Address",
                      style: _textStyle1,
                    ),
                    const SizedBox(height: 8),
                    Obx(() {
                      _primaryEmailFieldContrlr.text =
                          _personalInfoScreenController.primaryEmail.value;
                      return TextField(
                        controller: _primaryEmailFieldContrlr,
                        style: _textStyle2,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter your Email Id",
                            fillColor: color2,
                            filled: true),
                      );
                    }),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Alternate Mobile No",
                      style: _textStyle1,
                    ),
                    const SizedBox(height: 8),
                    Obx(() {
                      _altNoController.text =
                          _personalInfoScreenController.alternateNumber.value;
                      return TextField(
                        controller: _altNoController,
                        style: _textStyle2,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter an alternate number",
                            fillColor: color2,
                            filled: true),
                      );
                    }),
                    const SizedBox(
                      height: 12,
                    ),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      color: color4,
                      onPressed: () {
                        _personalInfoScreenController.savePersonalInfo(
                            nameText: _fullNameContrlr.text.replaceAll(' ', ''),
                            emailText: _primaryEmailFieldContrlr.text
                                .replaceAll(' ', ''),
                            zipcodeText:
                                _zipCodeController.text.replaceAll(' ', ''),
                            addressText:
                                _addressController.text.replaceAll(' ', ''),
                            alternateNoText:
                                _altNoController.text.replaceAll(' ', ''));
                      },
                      child: const Text("Save"),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 25),
                      child: Row(
                        children: [
                          Container(
                            height: 25,
                            width: 5,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              gradient: LinearGradient(
                                colors: [color3, color4],
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          const Text(
                            "About Nominee",
                            style: TextStyle(fontSize: 18, color: colorWhite),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "Nominee Number",
                      style: _textStyle1,
                    ),
                    const SizedBox(height: 8),
                    Obx(() {
                      _nomineeNumberController.text =
                          _personalInfoScreenController
                                  .personalInfo[FireString.nomineeNumber] ??
                              "";
                      return TextField(
                        controller: _nomineeNumberController,
                        style: _textStyle2,
                        keyboardType: TextInputType.phone,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Number that is Regd On $appName",
                            fillColor: color2,
                            filled: true),
                      );
                    }),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Nominee Name",
                      style: _textStyle1,
                    ),
                    const SizedBox(height: 8),
                    Obx(() {
                      _nomineeNameController.text =
                          _personalInfoScreenController
                                  .personalInfo[FireString.nomineeName] ??
                              "";
                      return TextField(
                        controller: _nomineeNameController,
                        style: _textStyle2,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter nominee full name",
                            fillColor: color2,
                            filled: true),
                      );
                    }),
                    const SizedBox(
                      height: 12,
                    ),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      color: color4,
                      onPressed: () {
                        _personalInfoScreenController.saveNominee(
                            name: _nomineeNameController.text,
                            number: _nomineeNumberController.text);
                      },
                      child: const Text("Save Nominee"),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 25),
                      child: Row(
                        children: [
                          Container(
                            height: 25,
                            width: 5,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              gradient: LinearGradient(
                                colors: [color3, color4],
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          const Text(
                            "Change Password",
                            style: TextStyle(fontSize: 18, color: colorWhite),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "Current Password",
                      style: _textStyle1,
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _oldPassController,
                      style: _textStyle2,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter Current One",
                          fillColor: color2,
                          filled: true),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "New Password",
                      style: _textStyle1,
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _newPassController,
                      style: _textStyle2,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter New One (> 6 Digit)",
                          fillColor: color2,
                          filled: true),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      color: color4,
                      onPressed: () {
                        _personalInfoScreenController.changePassword(
                            oldPass: _oldPassController.text,
                            newPass: _newPassController.text);
                        // _newPassController.text = "";
                        // _oldPassController.text = "";
                      },
                      child: const Text("Change Password"),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.amber.withOpacity(0.3),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: const Text(
                        "Enter nominee info to recover your account if you forget your both number & password, also nominee number can recover any amount from account in case if you have some worst situation or medical condition. Also choose a nominee member whom you can trust indefinitely.",
                        textAlign: TextAlign.justify,
                        style: TextStyle(color: colorWhite, fontSize: 13),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          FontAwesomeIcons.shieldAlt,
                          color: Colors.green,
                          size: 14,
                        ),
                        Text(
                          "  Secure & Protected By Avast",
                          style: TextStyle(color: Colors.green, fontSize: 12),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
