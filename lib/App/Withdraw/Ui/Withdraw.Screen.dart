import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:intl/intl.dart';
import 'package:powerbank/App/Withdraw/GetxControllers/Withdraw.Screen.Controller.dart';
import 'package:powerbank/Constants/Colors.dart';
import 'package:powerbank/Constants/firestore_strings.dart';
import 'package:powerbank/GetxStreams/Wallet.Permission.Stream.dart';
import 'package:powerbank/GetxStreams/Wallet.Value.Stream.dart';
import 'package:rotated_corner_decoration/rotated_corner_decoration.dart';

var _walletBalanceStreamer = Get.find<WalletBalanceStreamController>();
var _withdrawScreenController = Get.put(WithDrawScreenController());
var _walletPermissionController = Get.find<WalletPermissionStreamController>();
TextEditingController enteredAmountTEController = TextEditingController();

class WithdrawScreen extends StatefulWidget {
  const WithdrawScreen({Key? key}) : super(key: key);

  @override
  _WithdrawScreenState createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {
  final _textStyle = const TextStyle(fontSize: 11, color: Colors.amber);
  @override
  void initState() {
    super.initState();
    _withdrawScreenController.reload();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color1,
      appBar: AppBar(
        backgroundColor: color1,
        elevation: 0,
        centerTitle: true,
        title: const Text("Withdraw"),
        bottom: PreferredSize(
          preferredSize: MediaQuery.of(context).size * 0.18,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.18,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [color1, color3],
              ),
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(15),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Withdrawable\nBalance",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: color4.withOpacity(0.7)),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Obx(() {
                        return AnimatedFlipCounter(
                          value: _walletBalanceStreamer.withdrawalCoin.value,
                          prefix: '₹ ',
                          duration: const Duration(seconds: 2),
                          textStyle: const TextStyle(
                              color: colorWhite,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        );
                      })
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 40),
                  width: 2,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      gradient: LinearGradient(colors: [color3, color4])),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Withdrawn\nBalance",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: color4.withOpacity(0.7)),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Obx(() {
                        return AnimatedFlipCounter(
                          value: _walletBalanceStreamer.totalWithdrawal.value,
                          prefix: '₹ ',
                          duration: const Duration(seconds: 2),
                          textStyle: const TextStyle(
                              color: colorWhite,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        );
                      })
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.amber.withOpacity(0.33),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                  child: Obx(() {
                    return Column(
                      children: [
                        for (String i
                            in _withdrawScreenController.withdrawNoticeList)
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Row(
                              children: [
                                const Icon(
                                  FontAwesomeIcons.infoCircle,
                                  color: Colors.amber,
                                  size: 8,
                                ),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    i,
                                    style: _textStyle,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    );
                  }),
                ),
                const SizedBox(
                  height: 12,
                ),
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  child: Obx(() {
                    return Container(
                      padding: const EdgeInsets.all(25),
                      height: Get.height * 0.35,
                      decoration: BoxDecoration(
                        color: color3.withOpacity(0.4),
                      ),
                      foregroundDecoration: RotatedCornerDecoration(
                        textSpan: TextSpan(
                          text: (_walletPermissionController
                                  .withdrawEnabled.value)
                              ? "Online"
                              : "Offline",
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        color:
                            (_walletPermissionController.withdrawEnabled.value)
                                ? color4
                                : Colors.redAccent,
                        geometry: const BadgeGeometry(
                            width: 50,
                            height: 50,
                            cornerRadius: 0,
                            alignment: BadgeAlignment.topLeft),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              "Type the amount you want to withdraw",
                              style: TextStyle(color: color4, fontSize: 14),
                            ),
                          ),
                          TextField(
                            controller: enteredAmountTEController,
                            keyboardType: TextInputType.number,
                            style: const TextStyle(
                                color: colorWhite,
                                fontSize: 26,
                                fontWeight: FontWeight.bold),
                            decoration: const InputDecoration(
                              prefixIcon: Icon(
                                FontAwesomeIcons.indianRupeeSign,
                                color: colorWhite,
                              ),
                            ),
                          ),
                          MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            minWidth: Get.width - 35,
                            color: color4,
                            onPressed: () async {
                              enteredAmountTEController.text =
                                  enteredAmountTEController.text
                                      .replaceAll(" ", "");
                              if (enteredAmountTEController.text != "") {
                                bool haveCredential =
                                    await _withdrawScreenController
                                        .checkBankInfo();
                                if (haveCredential) {
                                  _withdrawScreenController.checkOtherParameter(
                                      enteredAmount: int.parse(
                                          enteredAmountTEController.text));
                                }
                              } else {
                                SmartDialog.showToast("Enter amount");
                              }
                            },
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 12),
                              child: Text(
                                "Withdraw Now",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                FontAwesomeIcons.bolt,
                                color: colorWhite.withOpacity(0.7),
                                size: 14,
                              ),
                              Text(
                                "  Powered By Open Bank Gateway",
                                style: TextStyle(
                                    color: colorWhite.withOpacity(0.7),
                                    fontSize: 12),
                              )
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
                ),
                const SizedBox(
                  height: 25,
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
                      "Withdraw History",
                      style: TextStyle(fontSize: 24, color: colorWhite),
                    ),
                  ],
                ),
                Obx(() {
                  return IndexedStack(
                    index: _withdrawScreenController.selectedStackIndex.value,
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
                              height: 24,
                            ),
                            Text(
                              "My Withdrawal History",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 22,
                                  color: color4.withOpacity(0.7),
                                  letterSpacing: -2),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            MaterialButton(
                              onPressed: () {
                                _withdrawScreenController
                                    .selectedStackIndex.value = 1;
                                _withdrawScreenController
                                    .loadMyWithdrawalsHistoryList();
                              },
                              child: const Text("See Full History"),
                            )
                          ],
                        ),
                      ),
                      Obx(() {
                        return Column(
                          children: [
                            const SizedBox(
                              height: 8,
                            ),
                            for (DocumentSnapshot docSnap
                                in _withdrawScreenController
                                    .myWithdrawalsMaps.reversed
                                    .toList())
                              Column(
                                children: [
                                  ListTile(
                                    isThreeLine: true,
                                    title: Text(
                                      "Withdraw ₹${docSnap[FireString.withdrawalAmount]}",
                                      style: const TextStyle(color: colorWhite),
                                    ),
                                    subtitle: Text(
                                      "➥ ${DateFormat("d MMM ").add_jm().format((docSnap[FireString.withdrawDateTime]).toDate())} \n➥ From ${docSnap[FireString.userDeviceName]}",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: colorWhite.withOpacity(0.6)),
                                    ),
                                    trailing: Text(
                                      "${docSnap[FireString.withdrawStatus]}",
                                      style: TextStyle(
                                        color: (docSnap[FireString
                                                    .withdrawStatus] ==
                                                FireString.success)
                                            ? Colors.green
                                            : (docSnap[FireString
                                                        .withdrawStatus] ==
                                                    FireString.failedRefunded)
                                                ? Colors.redAccent
                                                : Colors.amber.withOpacity(0.7),
                                      ),
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
                }),
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
      ),
    );
  }
}
