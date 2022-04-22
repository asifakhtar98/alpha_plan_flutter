import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:powerbank/App/AboutApp/Ui/About.App.Screen.dart';
import 'package:powerbank/App/AllActivityRecords/all_activity_screen.dart';
import 'package:powerbank/App/HelpCenter/Help.Center.Screen.dart';
import 'package:powerbank/App/MainFrame/GetxController/Main.Frame.Service.dart';
import 'package:powerbank/App/RechargeScreen/Recharge.Screen.dart';
import 'package:powerbank/App/ReferIncome/Ui/Refer.Income.Screen.dart';
import 'package:powerbank/App/ReferralProgram/Referral.Program.Screen.dart';
import 'package:powerbank/App/UserBankInfo/Ui/Bank.Info.Screen.dart';
import 'package:powerbank/App/UserPersonalInfo/User.Personal.Info.Screen.dart';
import 'package:powerbank/App/Withdraw/Ui/Withdraw.Screen.dart';
import 'package:powerbank/Constants/Colors.dart';
import 'package:powerbank/GetxStreams/Wallet.Value.Stream.dart';
import 'package:powerbank/HelperClasses/Widgets.dart';

var _walletBalanceStreamer = Get.find<WalletBalanceStreamController>();

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);
  static String viewName = "Profile";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 50),
        Container(
          height: MediaQuery.of(context).size.height * 0.23,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [color2, color3],
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
                      "Referral\nIncome",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: color4.withOpacity(0.7)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Obx(() {
                      return AnimatedFlipCounter(
                        value: _walletBalanceStreamer.referralIncome.value,
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
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                for (ProfileActionTile oList in profileActionList)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () => oList.onTap(),
                      child: ListTile(
                        leading: Icon(
                          oList.icon,
                          color: color3,
                          size: 22,
                        ),
                        title: Text(
                          oList.actionText,
                          style: const TextStyle(color: colorWhite),
                        ),
                        trailing: const Icon(
                          FontAwesomeIcons.chevronRight,
                          color: color3,
                          size: 14,
                        ),
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Get.to(() => const AboutAppScreen());
                    },
                    child: const ListTile(
                      leading: SizedBox(
                          width: 27, height: 27, child: AppIconWidget()),
                      title: Text(
                        "About Us",
                        style: TextStyle(color: colorWhite),
                      ),
                      trailing: Icon(
                        FontAwesomeIcons.chevronRight,
                        color: color3,
                        size: 14,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 70),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class ProfileActionTile {
  final IconData icon;
  final String actionText;
  final Function onTap;

  ProfileActionTile(
      {required this.icon, required this.actionText, required this.onTap});
}

List<ProfileActionTile> profileActionList = [
  ProfileActionTile(
      icon: FontAwesomeIcons.user,
      actionText: "My Personal Info",
      onTap: () {
        Get.to(() => UserPersonalInfoScreen());
      }),
  ProfileActionTile(
    icon: FontAwesomeIcons.wallet,
    actionText: "Recharge Account",
    onTap: () {
      Get.toNamed(RechargeScreen.screenName);
    },
  ),
  ProfileActionTile(
    icon: FontAwesomeIcons.handHoldingUsd,
    actionText: "Withdraw Balance",
    onTap: () {
      Get.to(() => const WithdrawScreen());
    },
  ),
  ProfileActionTile(
      icon: FontAwesomeIcons.moneyCheckAlt,
      actionText: "My Bank Info",
      onTap: () {
        Get.to(() => BankInfoScreen());
      }),
  ProfileActionTile(
      icon: FontAwesomeIcons.piggyBank,
      actionText: "Referral Income",
      onTap: () {
        Get.toNamed(UserReferIncomeScreen.screenName);
      }),
  ProfileActionTile(
      icon: FontAwesomeIcons.sitemap,
      actionText: "Referral Program",
      onTap: () {
        Get.to(() => const ReferralProgramScreen());
      }),
  ProfileActionTile(
      icon: FontAwesomeIcons.globeAsia,
      actionText: "Server Activities",
      onTap: () {
        Get.toNamed(AllActivityScreen.screenName);
      }),
  ProfileActionTile(
      icon: FontAwesomeIcons.headset,
      actionText: "Help Center",
      onTap: () {
        Get.to(() => const HelpCenterScreen());
      }),
  ProfileActionTile(
      icon: FontAwesomeIcons.signOutAlt,
      actionText: "Log Out",
      onTap: () {
        Get.find<MainFrameGService>().logout();
      }),
];
