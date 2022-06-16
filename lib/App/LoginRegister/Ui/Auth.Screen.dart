import 'package:auto_size_text/auto_size_text.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:powerbank/App/LoginRegister/GetXControllers/Auth.Controller.dart';
import 'package:powerbank/Constants/Colors.dart';
import 'package:powerbank/Constants/strings.dart';
import 'package:powerbank/GetxStreams/Server.Permit.Stream.dart';
import 'package:powerbank/HelperClasses/Notice.Get.Service.dart';
import 'package:powerbank/HelperClasses/Password.Renew.Controller.dart';
import 'package:powerbank/HelperClasses/Server.Stats.Service.dart';
import 'package:powerbank/HelperClasses/Widgets.dart';

//////////////////////////////////
var _regPhoneNoCntrlr = TextEditingController();
var _regPasswordCntrlr = TextEditingController();
var _regConfirmPasswordCntrlr = TextEditingController();
var _regCapthaKeyCntrlr = TextEditingController();
var _regReferCodeCntrlr = TextEditingController();
var _loginPhoneNoCntrlr = TextEditingController();
var _loginPasswordCntrlr = TextEditingController();
var _loginCapthaKeyCntrlr = TextEditingController();
var _authGController = Get.find<AuthGController>();
var _passwordRenewController = Get.find<PasswordRenewController>();
var _noticeGetxService = Get.find<NoticeGetxService>();
var _serverStatsController = Get.find<ServerStatsController>();
var _serverPermitStreamController = Get.find<ServerPermitStreamController>();

/////////////////////////////////
class AuthScreen extends StatefulWidget {
  static const screenName = "/AUTH_SCREEN";

  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  void initState() {
    _authGController.reload();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      _regCapthaKeyCntrlr.text = _authGController.currentCaptha.value;
      _loginCapthaKeyCntrlr.text = _authGController.currentCaptha.value;
    }
    return DoubleBack(
      background: color3,
      child: Scaffold(
        backgroundColor: color1,
        body: SafeArea(
          child: SizedBox(
            width: Get.width,
            height: Get.height,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: const [
                          SizedBox(
                            height: 50,
                          ),
                          SizedBox(
                              width: 50, height: 50, child: AppIconWidget()),
                          SizedBox(
                            height: 18,
                          ),
                          Text(
                            "DREAM",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: colorWhite,
                                fontSize: 35,
                                fontWeight: FontWeight.w900),
                          ),
                          Text(
                            "LIGHT CITY",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: color4,
                                fontSize: 35,
                                fontWeight: FontWeight.w900),
                          ),
                        ],
                      ),
                      Positioned(
                        child: IconButton(
                          onPressed: () {
                            _noticeGetxService.showNoticeWallDialog();
                          },
                          icon: const Icon(
                            FontAwesomeIcons.bell,
                            color: color3,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        top: 8,
                        child: InkWell(
                          onTap: () {
                            _noticeGetxService.showNoticeWallDialog();
                          },
                          child: SizedBox(
                            width: 65,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const AutoSizeText(
                                  "Tutorial",
                                  style: TextStyle(color: color3, fontSize: 12),
                                  minFontSize: 8,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(8),
                                  decoration: const BoxDecoration(
                                    color: color3,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5),
                                    ),
                                  ),
                                  child: const Icon(
                                    FontAwesomeIcons.youtube,
                                    size: 38,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Obx(() {
                      return IndexedStack(
                        index: _authGController.currentStackViewIndex.value,
                        children: const [
                          DelayedDisplay(
                              fadingDuration: Duration(milliseconds: 600),
                              child: RegistrationView()),
                          LoginView(),
                        ],
                      );
                    }),
                  ),
                  if (kDebugMode)
                    MaterialButton(
                      onPressed: () {
                        _authGController.loginUser(
                            mNo: demoMobileNo,
                            pass: demoPassword,
                            captha: _authGController.currentCaptha.value);
                      },
                      child: const Text("Login As Guest"),
                    ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Server Status- ",
                        style: TextStyle(color: color4, fontSize: 12),
                      ),
                      Text(
                        "Online",
                        style: TextStyle(color: color4, fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Total ",
                        style: TextStyle(color: color4, fontSize: 12),
                      ),
                      const Icon(
                        FontAwesomeIcons.userGroup,
                        size: 14,
                        color: color4,
                      ),
                      const SizedBox(width: 8),
                      Obx(() {
                        return Text(
                          (_serverStatsController.totalGlobalUsers.value +
                                  11675)
                              .toString(),
                          style: const TextStyle(color: color4, fontSize: 12),
                        );
                      }),
                      const SizedBox(width: 20),
                      const Text(
                        "Online ",
                        style: TextStyle(color: color4, fontSize: 12),
                      ),
                      const Icon(
                        FontAwesomeIcons.userGroup,
                        size: 14,
                        color: color4,
                      ),
                      const SizedBox(width: 8),
                      Obx(() {
                        return Text(
                          "${_serverStatsController.totalGlobalUsers.value + 7655}",
                          style: const TextStyle(color: color4, fontSize: 12),
                        );
                      }),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      CustomerSupport.openPrivacyPolicy();
                    },
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      children: const [
                        Text(
                          "By processing further you will agree to our ",
                          style: TextStyle(color: colorWhite, fontSize: 12),
                        ),
                        Text(
                          "Privacy Policy - Terms & Conditions",
                          style: TextStyle(color: color4, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LoginView extends StatelessWidget {
  const LoginView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          inputFormatters: [
            LengthLimitingTextInputFormatter(10),
            FilteringTextInputFormatter.allow(RegExp("[0-9]")),
          ],
          controller: _loginPhoneNoCntrlr,
          style: const TextStyle(color: colorWhite),
          keyboardType: TextInputType.number,
          onChanged: (v) {
            _authGController.showLoginMobileTick.value =
                (v.length == 10) ? true : false;
          },
          autofillHints: const [AutofillHints.telephoneNumberLocal],
          decoration: InputDecoration(
              prefixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(FontAwesomeIcons.mobile),
                  Text(
                    "   ",
                    style: TextStyle(color: colorWhite, fontSize: 1),
                  ),
                ],
              ),
              suffixIcon: Obx(() {
                return Visibility(
                    visible: _authGController.showLoginMobileTick.value,
                    child: const Icon(FontAwesomeIcons.circleCheck));
              }),
              hintText: "Mobile Number"),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _loginPasswordCntrlr,
          style: const TextStyle(color: colorWhite),
          obscureText: true,
          decoration: InputDecoration(
              prefixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(FontAwesomeIcons.key),
                  Text(
                    "   ",
                    style: TextStyle(color: colorWhite, fontSize: 1),
                  ),
                ],
              ),
              hintText: "Password"),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _loginCapthaKeyCntrlr,
          style: const TextStyle(color: colorWhite),
          decoration: InputDecoration(
              prefixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(FontAwesomeIcons.shieldHalved),
                  Text(
                    "   ",
                    style: TextStyle(color: colorWhite, fontSize: 1),
                  ),
                ],
              ),
              hintText: "Enter Captcha Key"),
        ),
        Row(
          children: [
            const Spacer(),
            IconButton(
              icon: const Icon(
                FontAwesomeIcons.retweet,
                color: color3,
              ),
              onPressed: () {
                _authGController.setNewCapthaCode(5);
              },
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                height: 40,
                alignment: Alignment.center,
                decoration: const BoxDecoration(color: color3),
                child: Obx(() {
                  return Text(
                    _authGController.currentCaptha.value,
                    style: const TextStyle(fontSize: 17),
                  );
                }),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        MaterialButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          minWidth: MediaQuery.of(context).size.width - 100,
          color: color4,
          onPressed: () {
            _authGController.loginUser(
                mNo: _loginPhoneNoCntrlr.text,
                pass: _loginPasswordCntrlr.text,
                captha: _loginCapthaKeyCntrlr.text);
          },
          child: const Text("Login Now"),
        ),
        const SizedBox(
          height: 25,
        ),
        MaterialButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          onPressed: () {
            _authGController.setNewCapthaCode(5);
            _authGController.currentStackViewIndex.value = 0;
          },
          child: const Text(
            "Create A New Account",
            style: TextStyle(color: color4),
          ),
        ),
        TextButton(
          onPressed: () {
            _passwordRenewController.showRenewPasswordDialog();
          },
          child: const Text('Forget Password'),
        ),
      ],
    );
  }
}

class RegistrationView extends StatelessWidget {
  const RegistrationView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            TextField(
              inputFormatters: [
                LengthLimitingTextInputFormatter(10),
                FilteringTextInputFormatter.allow(RegExp("[0-9]")),
              ],
              controller: _regPhoneNoCntrlr,
              style: const TextStyle(color: colorWhite),
              keyboardType: TextInputType.number,
              onChanged: (v) {
                _authGController.showRegMobileTick.value =
                    (v.length == 10) ? true : false;
              },
              autofillHints: const [AutofillHints.telephoneNumberLocal],
              decoration: InputDecoration(
                  prefixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        FontAwesomeIcons.lock,
                        color: color1,
                      ),
                      Text(
                        "   ",
                        style: TextStyle(color: colorWhite, fontSize: 1),
                      ),
                    ],
                  ),
                  suffixIcon: Obx(() {
                    return Visibility(
                        visible: _authGController.showRegMobileTick.value,
                        child: const Icon(FontAwesomeIcons.circleCheck));
                  }),
                  hintText: "Mobile Number"),
            ),
            CountryCodePicker(
              countryList: const [
                {
                  "name": "भारत",
                  "code": "IN",
                  "dial_code": "+91",
                },
                {
                  "name": "United States",
                  "code": "US",
                  "dial_code": "+1",
                },
                {
                  "name": "Singapore",
                  "code": "SG",
                  "dial_code": "+65",
                },
                {
                  "name": "France",
                  "code": "FR",
                  "dial_code": "+33",
                },
                {
                  "name": "الكويت",
                  "code": "KW",
                  "dial_code": "+965",
                },
              ],
              flagWidth: 30,
              dialogBackgroundColor: color2,
              dialogTextStyle: const TextStyle(color: colorWhite),
              hideMainText: true,
              onChanged: (code) {
                _authGController.countryCode.value = code.toString();
              },
              searchStyle: const TextStyle(color: colorWhite),
              barrierColor: Colors.transparent,
              // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
              initialSelection: 'IN',
              favorite: const [],
              dialogSize: Get.size * 0.6,
              // optional. Shows only country name and flag
              showCountryOnly: false,
              padding: EdgeInsets.zero,
              textStyle: const TextStyle(fontSize: 1),
              // optional. Shows only country name and flag when popup is closed.
              showOnlyCountryWhenClosed: false,
              // optional. aligns the flag and the Text left
              alignLeft: false,
            ),
          ],
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _regPasswordCntrlr,
          obscureText: true,
          style: const TextStyle(color: colorWhite),
          onChanged: (v) {
            _authGController.showRegPassTick.value =
                (v.length >= 6) ? true : false;
          },
          decoration: InputDecoration(
              prefixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  SizedBox(
                    width: 10,
                  ),
                  Icon(FontAwesomeIcons.key),
                  Text(
                    "     ",
                    style: TextStyle(color: colorWhite, fontSize: 1),
                  ),
                ],
              ),
              suffixIcon: Obx(
                () {
                  return Visibility(
                      visible: _authGController.showRegPassTick.value,
                      child: const Icon(FontAwesomeIcons.circleCheck));
                },
              ),
              hintText: "Password"),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _regConfirmPasswordCntrlr,
          style: const TextStyle(color: colorWhite),
          onChanged: (v) {
            _authGController.showRegConfPassTick.value =
                (v.length >= 6 && v == _regPasswordCntrlr.text) ? true : false;
          },
          decoration: InputDecoration(
              prefixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  SizedBox(
                    width: 10,
                  ),
                  Icon(FontAwesomeIcons.lock),
                  Text(
                    "   ",
                    style: TextStyle(color: colorWhite, fontSize: 1),
                  ),
                ],
              ),
              suffixIcon: Obx(() {
                return Visibility(
                    visible: _authGController.showRegConfPassTick.value,
                    child: const Icon(FontAwesomeIcons.circleCheck));
              }),
              hintText: "Confirm Password"),
        ),
        const SizedBox(height: 8),
        Obx(() {
          return TextField(
            controller: _regReferCodeCntrlr,
            style: const TextStyle(color: colorWhite),
            onChanged: (v) async {
              if (v.length >= referCodeLength - 4) {
                _authGController.validateReferrerCode(v);
              }
            },
            decoration: InputDecoration(
                prefixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    SizedBox(
                      width: 10,
                    ),
                    Icon(FontAwesomeIcons.child),
                    Text(
                      "   ",
                      style: TextStyle(color: colorWhite, fontSize: 1),
                    ),
                  ],
                ),
                suffixIcon: Obx(() {
                  return (_authGController.showReferrerBoxTick.value)
                      ? const Icon(FontAwesomeIcons.circleCheck)
                      : const Icon(
                          FontAwesomeIcons.solidFaceDizzy,
                          color: Color(0xFF8A3D3D),
                        );
                }),
                hintText:
                    "Refer Code ${_serverPermitStreamController.isReferCodeCompulsory.value ? " (Required)" : " (Optional)"}"),
          );
        }),
        const SizedBox(height: 8),
        TextField(
          controller: _regCapthaKeyCntrlr,
          style: const TextStyle(color: colorWhite),
          decoration: InputDecoration(
              prefixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  SizedBox(
                    width: 10,
                  ),
                  Icon(FontAwesomeIcons.shieldHalved),
                  Text(
                    "   ",
                    style: TextStyle(color: colorWhite, fontSize: 1),
                  ),
                ],
              ),
              hintText: "Enter Captcha Key"),
        ),
        Row(
          children: [
            const Spacer(),
            IconButton(
              icon: const Icon(FontAwesomeIcons.retweet, color: color3),
              onPressed: () {
                _authGController.setNewCapthaCode(5);
              },
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                height: 40,
                alignment: Alignment.center,
                decoration: const BoxDecoration(color: color3),
                child: Obx(() {
                  return Text(
                    _authGController.currentCaptha.value,
                    style: const TextStyle(fontSize: 17, color: color1),
                  );
                }),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        MaterialButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          minWidth: MediaQuery.of(context).size.width - 100,
          color: color4,
          onPressed: () {
            _regPhoneNoCntrlr.text = _regPhoneNoCntrlr.text.removeAllWhitespace
                .replaceAll(",", "")
                .replaceAll("-", "")
                .replaceAll(".", "")
                .replaceAll("+91", "")
                .replaceAll(RegExp(r'[^\w\s]+'), '');
            _regPasswordCntrlr.text.removeAllWhitespace.replaceAll("/", "");
            _authGController.registerUser(
                mNo: _regPhoneNoCntrlr.text,
                pass: _regPasswordCntrlr.text,
                cPass: _regConfirmPasswordCntrlr.text,
                captha: _regCapthaKeyCntrlr.text,
                referredByCode: _regReferCodeCntrlr.text);
          },
          child: const Text("Register"),
        ),
        const SizedBox(
          height: 25,
        ),
        MaterialButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          onPressed: () {
            _authGController.setNewCapthaCode(5);
            _authGController.currentStackViewIndex.value = 1;
          },
          child: const Text(
            "Already Have An Account",
            style: TextStyle(color: color4),
          ),
        ),
        TextButton(
          onPressed: () {
            _passwordRenewController.showRenewPasswordDialog();
          },
          child: const Text('Forget Password'),
        )
      ],
    );
  }
}
