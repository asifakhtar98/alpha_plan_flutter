import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:intl/intl.dart';
import 'package:powerbank/App/RechargeScreen/Controllers/Cashfree.Pg.Controller.dart';
import 'package:powerbank/App/RechargeScreen/Controllers/Razor.Pay.Controller.dart';
import 'package:powerbank/App/RechargeScreen/Controllers/Recharge.Screen.Controller.dart';
import 'package:powerbank/App/RechargeScreen/Controllers/Upi.Pay.Controller.dart';
import 'package:powerbank/Constants/Colors.dart';
import 'package:powerbank/Constants/strings.dart';
import 'package:powerbank/GetxStreams/Wallet.Value.Stream.dart';
import 'package:selectable_container/selectable_container.dart';
import 'package:upi_pay/upi_pay.dart';

var _walletBalanceStreamer = Get.find<WalletBalanceStreamController>();
TextEditingController customAmount = TextEditingController();
var _rechargeScreenController = Get.find<RechargeScreenController>();
var _razorpayController = Get.find<RazorpayController>();
var _cashfreePgController = Get.find<CashfreePgController>();
var _upiPay = Get.find<UpiPayController>();
int minCustomAmount = 500;

class RechargeScreen extends StatelessWidget {
  static String screenName = "/RECHARGE_SCREEN";

  const RechargeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _rechargeScreenController.getAllLiveRechargingData();

    return Scaffold(
      backgroundColor: color1,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Recharge Account"),
        backgroundColor: color1,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: color4.withOpacity(0.3),
                    border: Border.all(color: color4),
                    borderRadius: BorderRadius.circular(15)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                child: Column(
                  children: [
                    Obx(() {
                      return AnimatedFlipCounter(
                        value: _walletBalanceStreamer.depositCoin.value,
                        prefix: '₹ ',
                        duration: const Duration(seconds: 2),
                        textStyle: const TextStyle(
                            fontSize: 40,
                            color: colorWhite,
                            fontWeight: FontWeight.bold),
                      );
                    }),
                    const Text(
                      "Available To Invest",
                      style: TextStyle(color: colorWhite),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
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
                    "Available Options",
                    style: TextStyle(fontSize: 18, color: colorWhite),
                  ),
                ],
              ),
              const WAddDCoin(),
              const SizedBox(
                height: 8,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  "Important Notes",
                  style: TextStyle(color: color3, fontSize: 12),
                ),
              ),
              Obx(() {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        "1. Custom amount can be entered between ₹$minCustomAmount-₹${_rechargeScreenController.maxCustomAmount.value}",
                        style: const TextStyle(color: color3, fontSize: 12),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        "2. The balance here is the amount you can invest in the plans provided by the app",
                        style: TextStyle(color: color3, fontSize: 12),
                      ),
                    ),
                  ],
                );
              }),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MaterialButton(
                  onPressed: () async {
                    depositMethodsList.shuffle();
                    print("depositMethodsList: ${depositMethodsList.length}");
                    bool haveCredential =
                        await _rechargeScreenController.checkEmailAndFullName();
                    if (haveCredential) {
                      SmartDialog.show(
                        alignmentTemp: Alignment.bottomCenter,
                        maskColorTemp: color1.withOpacity(0.8),
                        clickBgDismissTemp: true,
                        widget: SafeArea(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              maxHeight: Get.height * 0.66,
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text(
                                    "$appName\nAuto Payment Options",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: color4,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    "Select Payment Method To Add Rs. ${_rechargeScreenController.selectedDCoin.value}",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontSize: 12, color: color4),
                                  ),
                                  for (Map m in depositMethodsList)
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 4),
                                      child: OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                          primary: Colors.white,
                                          backgroundColor: color4,
                                          side: const BorderSide(
                                              color: Colors.white, width: 1),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                        ),
                                        onPressed: m["onTap"],
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Text(
                                            m["text"],
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),
                                  InkWell(
                                    onTap: () {
                                      SmartDialog.dismiss(
                                          status: SmartStatus.dialog);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(12),
                                      margin: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: Colors.amber.withOpacity(0.33),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(12),
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          for (String i in _paymentOptionsNotes)
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: Row(
                                                children: [
                                                  const Icon(
                                                    FontAwesomeIcons.infoCircle,
                                                    color: Colors.amber,
                                                    size: 8,
                                                  ),
                                                  Expanded(
                                                    child: AutoSizeText(
                                                      "  $i",
                                                      style: const TextStyle(
                                                          fontSize: 10,
                                                          color: Colors.amber),
                                                      minFontSize: 11,
                                                      maxLines: 2,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                  },
                  color: color4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text("Proceed To Payment"),
                  ),
                ),
              ),
              Obx(
                () {
                  return Text(
                    "Last Deposit Enquiry Code\n${_rechargeScreenController.lastRechargeRefNo.value}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: color3, fontSize: 12),
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 8,
                  ),
                  Container(
                    height: 30,
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
                    "Recharge History",
                    style: TextStyle(fontSize: 24, color: colorWhite),
                  ),
                ],
              ),
              const Divider(),
              const RechargeHistoryView(),
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
                  )
                ],
              ),
              const SizedBox(
                height: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<Map<String, dynamic>> dCoins = [
  {"val": 1, "sel": false},
  {"val": 300, "sel": false},
  {"val": 500, "sel": false},
  {"val": 1000, "sel": true},
  {"val": 1500, "sel": false},
  {"val": 2000, "sel": false},
  {"val": 3000, "sel": false},
  {"val": 5000, "sel": false},
  {"val": 6000, "sel": false},
  {"val": 7000, "sel": false},
  {"val": 8000, "sel": false},
  {"val": 10000, "sel": false},
  {"val": 20000, "sel": false},
  {"val": 40000, "sel": false},
];
List depositMethodsList = [];

void assignAllDepositMethods() {
  depositMethodsList = [
    if (_rechargeScreenController.directUpiEnabled)
      {
        "text": "Via Paytm App",
        "onTap": () {
          _rechargeScreenController.showSecLoading(5);
          _upiPay.createUpiRechargeRequest(upiApp: UpiApplication.paytm);
        }
      },
    if (_rechargeScreenController.directUpiEnabled)
      {
        "text": "Via GooglePay",
        "onTap": () {
          _rechargeScreenController.showSecLoading(5);
          _upiPay.createUpiRechargeRequest(upiApp: UpiApplication.googlePay);
        }
      },
    if (_rechargeScreenController.directUpiEnabled)
      {
        "text": "Via AmazonPay",
        "onTap": () {
          _rechargeScreenController.showSecLoading(5);
          _upiPay.createUpiRechargeRequest(upiApp: UpiApplication.amazonPay);
        }
      },
    if (_rechargeScreenController.directUpiEnabled)
      {
        "text": "Via SBI Pay",
        "onTap": () {
          _rechargeScreenController.showSecLoading(5);
          _upiPay.createUpiRechargeRequest(upiApp: UpiApplication.sbiPay);
        }
      },
    if (_rechargeScreenController.razorpayEnabled)
      {
        "text": "Via RP Upi Id",
        "onTap": () {
          _rechargeScreenController.showSecLoading(5);
          _razorpayController.createRazorpayRechargeRequest("upi");
        }
      },
    if (_rechargeScreenController.cashfreeEnabled)
      {
        "text": "Via CF Upi Id",
        "onTap": () {
          _rechargeScreenController.showSecLoading(5);
          _cashfreePgController.createCashfreeRechargeRequest("upi");
        }
      },
    if (_rechargeScreenController.razorpayEnabled)
      {
        "text": "Via RP Digi Wallets",
        "onTap": () {
          _rechargeScreenController.showSecLoading(5);
          _razorpayController.createRazorpayRechargeRequest("wallet");
        }
      },
    if (_rechargeScreenController.cashfreeEnabled)
      {
        "text": "Via CF NetBanking",
        "onTap": () {
          _rechargeScreenController.showSecLoading(5);
          _cashfreePgController.createCashfreeRechargeRequest("nb");
        }
      },
    if (_rechargeScreenController.razorpayEnabled)
      {
        "text": "Via RP NetBanking",
        "onTap": () {
          _rechargeScreenController.showSecLoading(5);
          _razorpayController.createRazorpayRechargeRequest("netbanking");
        }
      },
    if (_rechargeScreenController.razorpayEnabled)
      {
        "text": "Via RP Debit Card",
        "onTap": () {
          _rechargeScreenController.showSecLoading(5);
          _razorpayController.createRazorpayRechargeRequest("card");
        }
      },
    if (_rechargeScreenController.cashfreeEnabled)
      {
        "text": "Via CF Debit Card",
        "onTap": () {
          _rechargeScreenController.showSecLoading(5);
          _cashfreePgController.createCashfreeRechargeRequest("dc");
        }
      },
  ];
}

List<String> _paymentOptionsNotes = [
  "Instant ⇋ All recharge methods are automatic",
  "Tips ⇋ Trying different available methods on each recharge is a good practice"
];
List depositNotes = [
  " Notes-",
  "1. Custom amount can be entered between ₹$minCustomAmount-₹40000",
  "2. Trying different available methods on each recharge is a good practice"
];

class WAddDCoin extends StatefulWidget {
  const WAddDCoin({
    Key? key,
  }) : super(key: key);

  @override
  State<WAddDCoin> createState() => _WAddDCoinState();
}

class _WAddDCoinState extends State<WAddDCoin> {
  updateCustomAmount() {
    String s = customAmount.text;
    if (int.parse(s) >= minCustomAmount &&
        int.parse(s) <= _rechargeScreenController.maxCustomAmount.value) {
      _rechargeScreenController.selectedDCoin.value = int.parse(s);
      setState(() {
        customAmountBgColor = color4;
        customAmountCheckVisibility = true;
        for (var i in dCoins) {
          i["sel"] = false;
        }
      });
    } else {
      setState(() {
        if (int.parse(s) > _rechargeScreenController.maxCustomAmount.value) {
          for (var i in dCoins) {
            i["sel"] = false;
          }
          _rechargeScreenController.selectedDCoin.value = 8000;
          dCoins[dCoins.length - 1]["sel"] = true;
        }
        customAmountCheckVisibility = false;
        customAmountBgColor = Colors.transparent;
      });
    }
  }

  Color customAmountBgColor = Colors.transparent;
  bool customAmountCheckVisibility = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(4), topLeft: Radius.circular(8))),
      child: SingleChildScrollView(
        child: Obx(() {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 15,
              ),
              Wrap(
                alignment: WrapAlignment.center,
                children: [
                  for (Map e in dCoins)
                    SelectableContainer(
                      marginColor: color1,
                      unselectedOpacity: 1.0,
                      elevation: 0,
                      borderRadius: 30,
                      unselectedBorderColor: Colors.grey,
                      unselectedBackgroundColor: color1,
                      iconSize: 8,
                      selected: e["sel"],
                      padding: 8,
                      iconColor: Colors.black,
                      selectedBorderColor: Colors.white,
                      selectedBackgroundColor: color4,
                      onValueChanged: (v) {
                        _rechargeScreenController.selectedDCoin.value =
                            e["val"];

                        for (var i in dCoins) {
                          i["sel"] = false;
                        }
                        setState(() {
                          customAmountBgColor = Colors.transparent;
                          customAmountCheckVisibility = false;
                          e["sel"] = true;
                        });
                      },
                      child: SizedBox(
                        width: 95,
                        child: Text(
                          "₹${e["val"]}",
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(
                height: 6,
              ),
              if (_rechargeScreenController.maxCustomAmount.value > 0)
                GestureDetector(
                  onTap: updateCustomAmount,
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Container(
                        height: 41,
                        width: 180,
                        decoration: BoxDecoration(
                            color: customAmountBgColor,
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(
                                color: colorWhite.withOpacity(0.7), width: 2)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "      ₹",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            SizedBox(
                              width: 70,
                              child: TextField(
                                onChanged: (s) {
                                  updateCustomAmount();
                                },
                                onTap: updateCustomAmount,
                                controller: customAmount,
                                // textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 14),
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  hintText: "0000",
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: customAmountCheckVisibility,
                        child: Positioned(
                          top: 0,
                          right: 95,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: colorWhite,
                              border: Border.all(color: Colors.white),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.check,
                              color: Colors.black,
                              size: 8,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
            ],
          );
        }),
      ),
    );
  }
}

class RechargeHistoryView extends StatelessWidget {
  const RechargeHistoryView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return IndexedStack(
        index: _rechargeScreenController.selectedStackIndex.value,
        children: [
          SizedBox(
            height: Get.height * 0.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(
                  FontAwesomeIcons.clipboardList,
                  size: 90,
                  color: color4.withOpacity(0.7),
                ),
                const SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  onPressed: () {
                    _rechargeScreenController.selectedStackIndex.value = 1;
                    _rechargeScreenController.loadMyDepositHistoryList();
                  },
                  child: const Text("See Full History"),
                )
              ],
            ),
          ),
          Obx(() {
            return Column(
              children: [
                for (DocumentSnapshot docSnap
                    in _rechargeScreenController.myDepositListOfMaps)
                  Column(
                    children: [
                      ListTile(
                        title: const Text(
                          "Recharge Success",
                          style: TextStyle(color: colorWhite),
                        ),
                        subtitle: Text(
                          "➥ ${DateFormat("d MMM ").add_jm().format((docSnap[FireString.depositInfo][FireString.depositDateTime]).toDate())}\n➥ Ref No - ${docSnap[FireString.depositInfo][FireString.lastRechargeRefNo]}",
                          style: TextStyle(
                              fontSize: 12, color: colorWhite.withOpacity(0.6)),
                        ),
                        trailing: Text(
                          "₹${docSnap[FireString.depositInfo][FireString.depositAmount]}",
                          style: const TextStyle(color: Colors.green),
                        ),
                      ),
                      const Divider()
                    ],
                  ),
              ],
            );
          })
        ],
      );
    });
  }
}
