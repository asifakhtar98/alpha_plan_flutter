import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:powerbank/App/UserBankInfo/Controller/Bank.Info.Controller.dart';
import 'package:powerbank/Constants/Colors.dart';

var _bankScreenController = Get.put(BankInfoScreenController());

class BankInfoScreen extends StatefulWidget {
  const BankInfoScreen({Key? key}) : super(key: key);

  @override
  State<BankInfoScreen> createState() => _BankInfoScreenState();
}

class _BankInfoScreenState extends State<BankInfoScreen> {
  final _textStyle1 = const TextStyle(color: color4, fontSize: 13);

  final _textStyle2 = const TextStyle(color: colorWhite);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bankScreenController.reload();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color1,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: color2,
        title: const Text("My Bank Info"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                child: Text(
                  "Please enter your bank details below to withdraw your balance to your bank account.",
                  style: TextStyle(color: colorWhite, fontSize: 16),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Your Name On Bank",
                      style: _textStyle1,
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      style: _textStyle2,
                      controller: _bankScreenController.payeeNameTextController,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter your full name",
                          fillColor: color2,
                          filled: true),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Bank Name",
                      style: _textStyle1,
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _bankScreenController.bankNameTextController,
                      style: _textStyle2,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Optional",
                          fillColor: color2,
                          filled: true),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Bank Account Number ",
                      style: _textStyle1,
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _bankScreenController.accountNoTextController,
                      style: _textStyle2,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter your bank account number",
                          fillColor: color2,
                          filled: true),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Bank IFSC",
                      style: _textStyle1,
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _bankScreenController.bankIfscTextController,
                      style: _textStyle2,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter your bank IFSC Code",
                          fillColor: color2,
                          filled: true),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Email",
                      style: _textStyle1,
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller:
                          _bankScreenController.payeeEmailTextController,
                      style: _textStyle2,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter your email address",
                          fillColor: color2,
                          filled: true),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Upi Link",
                      style: _textStyle1,
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _bankScreenController.upiLinkTextController,
                      style: _textStyle2,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Optional",
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
                      onPressed: () async {
                        _bankScreenController.savePersonalInfo(
                          nameText: _bankScreenController
                              .payeeNameTextController.text
                              .replaceAll('  ', ' '),
                          bank: _bankScreenController
                              .bankNameTextController.text
                              .replaceAll(' ', ''),
                          upiLink: _bankScreenController
                              .upiLinkTextController.text
                              .replaceAll(' ', ''),
                          acNo: _bankScreenController
                              .accountNoTextController.text
                              .replaceAll(' ', ''),
                          emailText: _bankScreenController
                              .payeeEmailTextController.text
                              .replaceAll(' ', ''),
                          ifsc: _bankScreenController
                              .bankIfscTextController.text
                              .replaceAll(' ', ''),
                        );
                      },
                      child: const Text("Submit"),
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
                        "Please enter you bank info correctly and accurately, We will not responsible for capital loss caused by information error",
                        style: TextStyle(color: colorWhite, fontSize: 16),
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
