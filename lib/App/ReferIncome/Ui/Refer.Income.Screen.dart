import 'dart:io';

import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:powerbank/App/BuyProduct/Controllers/Commission.Controller.dart';
import 'package:powerbank/App/ReferIncome/GetxControllers/Refer.Controller.dart';
import 'package:powerbank/Constants/Colors.dart';
import 'package:powerbank/Constants/strings.dart';
import 'package:powerbank/GetxStreams/Wallet.Permission.Stream.dart';
import 'package:powerbank/GetxStreams/Wallet.Value.Stream.dart';
import 'package:powerbank/HelperClasses/Widgets.dart';
import 'package:powerbank/generated/assets.dart';
import 'package:share_plus/share_plus.dart';

var _walletBalanceStreamer = Get.find<WalletBalanceStreamController>();
var _walletPermissionStreamController =
    Get.find<WalletPermissionStreamController>();
var _userReferIncomeController = Get.find<ReferIncomeController>();

int selectedIndex = 0;

TextStyle _textStyle1 = const TextStyle(fontSize: 12, color: Colors.white);
TextStyle _textStyle2 = const TextStyle(fontSize: 12, color: Colors.amber);
TextStyle _textStyle3 = const TextStyle(fontSize: 12, color: color4);
TextStyle _textStyle4 = const TextStyle(fontSize: 12, color: Colors.amber);
BorderRadiusGeometry _borderRadius1 =
    const BorderRadius.vertical(top: Radius.circular(15));
BorderRadiusGeometry _borderRadius2 =
    const BorderRadius.vertical(bottom: Radius.circular(15));
LinearGradient _linearGradient1 = const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [color3, color4]);
LinearGradient _linearGradient2 = const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [color3, color2]);

class UserReferIncomeScreen extends StatelessWidget {
  static String screenName = "/REFER_INCOME_SCREEN";

  const UserReferIncomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _userReferIncomeController.selectedStackIndex.value = 0;
    return Scaffold(
      backgroundColor: color1,
      appBar: AppBar(
        backgroundColor: color1,
        title: const Text("My Referral Incomes"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(12, 12, 12, 2),
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.amber.withOpacity(0.33),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                  child: Column(
                    children: [
                      Obx(() {
                        return Text(
                          "Lifetime Refer Income: ${_userReferIncomeController.lifetimeReferIncome.value}",
                          style: const TextStyle(
                              color: colorWhite,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        );
                      }),
                      const Divider(
                        height: 8,
                        thickness: 2,
                      ),
                      Text(
                        "You obtain ${Get.find<CommissionController>().level1CommissionPercent}% from all level 1 referred users when they recharge/deposit to their wallet, ${Get.find<CommissionController>().level2CommissionPercent}% from level 2 referred users and ${Get.find<CommissionController>().level3CommissionPercent}% from all level 3 refers immediately.",
                        style: _textStyle1,
                      ),
                      Obx(() {
                        return Text(
                          "▷ Minimum value for conversion ₹${_walletPermissionStreamController.minReferIncomeToConvert.value}",
                          style: _textStyle1,
                        );
                      }),
                      const SizedBox(
                        height: 4,
                      ),
                      const Divider(
                        height: 8,
                        thickness: 2,
                      ),
                      TextButton(
                        onPressed: () {
                          SmartDialog.show(
                            alignmentTemp: Alignment.center,
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
                                      height: 270,
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              color4,
                                              color3.withBlue(150)
                                            ]),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Column(
                                        children: [
                                          const Text(
                                            "Total Referral Income",
                                            textAlign: TextAlign.end,
                                            style: TextStyle(color: colorWhite),
                                          ),
                                          Expanded(
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Obx(() {
                                                return AnimatedFlipCounter(
                                                  value: _walletBalanceStreamer
                                                      .referralIncome.value,
                                                  prefix: "₹ ",
                                                  duration: const Duration(
                                                      seconds: 2),
                                                  textStyle: const TextStyle(
                                                      color: colorWhite,
                                                      fontSize: 40,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                );
                                              }),
                                            ),
                                          ),
                                          Obx(() {
                                            return AnimatedFlipCounter(
                                              value: _walletBalanceStreamer
                                                  .withdrawalCoin.value,
                                              prefix:
                                                  "Withdrawable Balance : ₹",
                                              duration:
                                                  const Duration(seconds: 2),
                                              textStyle: const TextStyle(
                                                  color: colorWhite,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold),
                                            );
                                          }),
                                          const SizedBox(
                                            height: 6,
                                          ),
                                          const Text(
                                            "Do you want to convert all your referral income to withdrawable money?",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: colorWhite,
                                                fontSize: 12),
                                          ),
                                          const SizedBox(
                                            height: 6,
                                          ),
                                          const Divider(
                                            color: colorWhite,
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: TextButton(
                                                  onPressed: () {
                                                    SmartDialog.dismiss(
                                                        status:
                                                            SmartStatus.dialog);
                                                  },
                                                  child: const Text(
                                                    "Not Now",
                                                    style: TextStyle(
                                                        color: colorWhite),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: TextButton(
                                                  onPressed: () async {
                                                    _userReferIncomeController
                                                        .convertReferIncomeToWithdrawalBalance(
                                                            _walletBalanceStreamer
                                                                .referralIncome
                                                                .value);
                                                  },
                                                  child: const Text(
                                                    "Convert Now",
                                                    style: TextStyle(
                                                        color: colorWhite),
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
                                      Lottie.asset(
                                          Assets.assetsRupeeCoinLeftRight,
                                          height: 160),
                                      const SizedBox(
                                        height: 270,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                        child: const Text(
                          "Convert Referral Income",
                          style: TextStyle(color: colorWhite),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Obx(() {
                    return childViews[
                        _userReferIncomeController.selectedStackIndex.value];
                  }),
                ),
              ],
            )),
      ),
    );
  }
}

class RefersTimeline extends StatelessWidget {
  const RefersTimeline({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          decoration: BoxDecoration(
              gradient: _linearGradient1, borderRadius: _borderRadius1),
          child: Row(
            children: [
              InkWell(
                  onTap: () {
                    _userReferIncomeController.selectedStackIndex.value = 0;
                  },
                  child: const Icon(FontAwesomeIcons.windowClose)),
              const SizedBox(
                width: 10,
              ),
              Text(
                "Commissions",
                style: _textStyle1,
              ),
              const Spacer(),
              Text(
                "Recharge",
                style: _textStyle2,
              ),
              const SizedBox(
                width: 30,
              ),
              Text(
                "You Got",
                style: _textStyle2,
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          decoration: BoxDecoration(
              gradient: _linearGradient2, borderRadius: _borderRadius2),
          child: Obx(() {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (Map m in _userReferIncomeController.allMembersOfALevel)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Icon(
                          FontAwesomeIcons.child,
                          size: 14,
                          color: color4,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          (m[FireString.fullName] != "")
                              ? m[FireString.fullName]
                              : m[FireString.mobileNo]
                                  .replaceRange(1, 7, "*" * 6),
                          style: _textStyle3,
                        ),
                        const Spacer(),
                        Text(
                          m[FireString.depositAmount].toString(),
                          style: _textStyle1,
                        ),
                        const SizedBox(
                          width: 55,
                        ),
                        Text(
                          m[FireString.commissionAmount].toString(),
                          style: _textStyle1,
                        ),
                      ],
                    ),
                  ),
              ],
            );
          }),
        ),
      ],
    );
  }
}

List childViews = [
  const OnlyReferStats(),
  const RefersTimeline(),
];

class OnlyReferStats extends StatelessWidget {
  const OnlyReferStats({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var allHistory = _userReferIncomeController.allLevelsOverall;
      // print(allHistory.toString());
      int listLength = (allHistory.length < 3) ? 3 : allHistory.length;
      return Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: BoxDecoration(
                gradient: _linearGradient1, borderRadius: _borderRadius1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Referral - Data",
                  style: _textStyle1,
                ),
                InkWell(
                  onTap: () {},
                  child: Text(
                    "Share & Earn",
                    style: _textStyle2,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
                gradient: _linearGradient2, borderRadius: _borderRadius2),
            child: Obx(() {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (var s in _userReferIncomeController.myReferCodes)
                    Column(
                      children: [
                        ListTile(
                          onTap: () {
                            Clipboard.setData(ClipboardData(text: "${s.id}"))
                                .then((value) =>
                                    SmartDialog.showToast("Refer Code Copied"));
                          },
                          trailing: const Icon(
                            FontAwesomeIcons.copy,
                            size: 14,
                            color: color4,
                          ),
                          minLeadingWidth: 1,
                          leading: const Icon(
                            FontAwesomeIcons.child,
                            size: 14,
                            color: color4,
                          ),
                          title: Text(
                            "Code\n${s.id}",
                            style: _textStyle3,
                          ),
                        ),
                        ListTile(
                          onTap: () async {
                            final bytes = await rootBundle.load(
                                'assets/refer_files/AppInsiderCoverPic.jpg');
                            final list = bytes.buffer.asUint8List();

                            final tempDir = await getTemporaryDirectory();
                            final file = await File('${tempDir.path}/image.jpg')
                                .create();
                            file.writeAsBytesSync(list);
                            Share.shareFiles([(file.path)],
                                text:
                                    '$referMsgPrefix:\n\n✅ 110% safe & verified by Google Play Store\n\n✅ AppLink:\n$referLinkPrefix${s.id} \n\n ✅ ReferCode: ${s.id}');
                          },
                          trailing: const Icon(
                            FontAwesomeIcons.shareAlt,
                            size: 14,
                            color: color4,
                          ),
                          minLeadingWidth: 1,
                          leading: const Icon(
                            FontAwesomeIcons.link,
                            size: 14,
                            color: color4,
                          ),
                          title: Text(
                            "Link\n$referLinkPrefix${s.id}",
                            style: _textStyle3,
                          ),
                        ),
                        const Divider(),
                      ],
                    ),
                  Text(
                    "3 Level commission system ${(true) ? "enabled" : "disabled"}",
                    style: _textStyle3,
                  )
                ],
              );
            }),
          ),
          const SizedBox(height: 12),
          for (int i = 1; i <= listLength; i++)
            Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  decoration: BoxDecoration(
                      gradient: _linearGradient1, borderRadius: _borderRadius1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Referral - LEVEL $i",
                        style: _textStyle1,
                      ),
                      InkWell(
                        onTap: () {
                          _userReferIncomeController.getALevelCommissionMembers(
                              "${FireString.commissionLevel}$i");
                          _userReferIncomeController.selectedStackIndex.value =
                              1;
                        },
                        child: Text(
                          ((allHistory.indexWhere((element) =>
                                      element[FireString.commissionLevel] ==
                                      "${FireString.commissionLevel}$i") <
                                  0))
                              ? ""
                              : "View Members>>",
                          // "View History >>",
                          style: _textStyle2,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  decoration: BoxDecoration(
                      gradient: _linearGradient2, borderRadius: _borderRadius2),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            FontAwesomeIcons.child,
                            size: 14,
                            color: color4,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            "Total\nLevel Recharge",
                            style: _textStyle3,
                          ),
                          const Spacer(),
                          Text(
                            ((allHistory.indexWhere((element) =>
                                        element[FireString.commissionLevel] ==
                                        "${FireString.commissionLevel}$i") <
                                    0))
                                ? "000"
                                : "${allHistory[allHistory.indexWhere((element) => element[FireString.commissionLevel] == "${FireString.commissionLevel}$i")]["MapData"][FireString.levelTotalRecharge]}",
                            style: _textStyle4,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          const Icon(
                            FontAwesomeIcons.sitemap,
                            size: 14,
                            color: color4,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            "Referral\nCommission Gained",
                            style: _textStyle3,
                          ),
                          const Spacer(),
                          Text(
                            ((allHistory.indexWhere((element) =>
                                        element[FireString.commissionLevel] ==
                                        "${FireString.commissionLevel}$i") <
                                    0))
                                ? "000"
                                : "${allHistory[allHistory.indexWhere((element) => element[FireString.commissionLevel] == "${FireString.commissionLevel}$i")]["MapData"][FireString.levelTotalCommission]}",
                            style: _textStyle4,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          const Icon(
                            FontAwesomeIcons.chartLine,
                            size: 14,
                            color: color4,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            "Last\nCommission On",
                            style: _textStyle3,
                          ),
                          const Spacer(),
                          Text(
                            ((allHistory.indexWhere((element) =>
                                        element[FireString.commissionLevel] ==
                                        "${FireString.commissionLevel}$i") <
                                    0))
                                ? "N/A"
                                : DateFormat("d MMM ").add_jm().format((allHistory[
                                            allHistory.indexWhere((element) =>
                                                element[FireString
                                                    .commissionLevel] ==
                                                "${FireString.commissionLevel}$i")]
                                        ["MapData"][FireString.lastCommissionOn])
                                    .toDate()),
                            style: _textStyle4,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
        ],
      );
    });
  }
}
