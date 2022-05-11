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

class UserPersonalInfoScreen extends StatefulWidget {
  const UserPersonalInfoScreen({Key? key}) : super(key: key);

  @override
  State<UserPersonalInfoScreen> createState() => _UserPersonalInfoScreenState();
}

class _UserPersonalInfoScreenState extends State<UserPersonalInfoScreen> {
  final _textStyle1 = const TextStyle(color: color4, fontSize: 13);

  final _textStyle2 = const TextStyle(color: colorWhite);

  final _hiveBox = Hive.box(hiveBoxName);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _personalInfoScreenController.reload();
  }

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
                      return TextField(
                        controller:
                            _personalInfoScreenController.fullNameContrlr,
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
                      return TextField(
                        controller:
                            _personalInfoScreenController.addressController,
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
                      return TextField(
                        controller:
                            _personalInfoScreenController.zipCodeController,
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
                      return TextField(
                        controller: _personalInfoScreenController
                            .primaryEmailFieldContrlr,
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
                      return TextField(
                        controller:
                            _personalInfoScreenController.altNoController,
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
                            nameText: _personalInfoScreenController
                                .fullNameContrlr.text
                                .replaceAll(' ', ''),
                            emailText: _personalInfoScreenController
                                .primaryEmailFieldContrlr.text
                                .replaceAll(' ', ''),
                            zipcodeText: _personalInfoScreenController
                                .zipCodeController.text
                                .replaceAll(' ', ''),
                            addressText: _personalInfoScreenController
                                .addressController.text
                                .replaceAll(' ', ''),
                            alternateNoText: _personalInfoScreenController
                                .altNoController.text
                                .replaceAll(' ', ''));
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
                      _personalInfoScreenController.nomineeNumberController
                          .text = _personalInfoScreenController
                              .personalInfo[FireString.nomineeNumber] ??
                          "";
                      return TextField(
                        controller: _personalInfoScreenController
                            .nomineeNumberController,
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
                      _personalInfoScreenController.nomineeNameController.text =
                          _personalInfoScreenController
                                  .personalInfo[FireString.nomineeName] ??
                              "";
                      return TextField(
                        controller:
                            _personalInfoScreenController.nomineeNameController,
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
                            name: _personalInfoScreenController
                                .nomineeNameController.text,
                            number: _personalInfoScreenController
                                .nomineeNumberController.text);
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
                      controller:
                          _personalInfoScreenController.oldPassController,
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
                      controller:
                          _personalInfoScreenController.newPassController,
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
                            oldPass: _personalInfoScreenController
                                .oldPassController.text,
                            newPass: _personalInfoScreenController
                                .newPassController.text);
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
