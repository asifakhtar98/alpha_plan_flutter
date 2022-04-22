import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:powerbank/App/ReferIncome/Ui/Refer.Income.Screen.dart';
import 'package:powerbank/Constants/Colors.dart';
import 'package:powerbank/Constants/strings.dart';

class ReferralProgramScreen extends StatelessWidget {
  const ReferralProgramScreen({Key? key}) : super(key: key);
  final TextStyle _textStyle1 =
      const TextStyle(color: colorWhite, fontSize: 18);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color1,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: color1,
        elevation: 0,
        title: const Text("Referral Program"),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.bottomRight,
                    height: Get.height * 0.30,
                    width: Get.width,
                    decoration: const BoxDecoration(
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(40)),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [color1, color3],
                      ),
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(
                          "https://res.cloudinary.com/asifakhtarcloudinary/image/upload/v1637143581/PowerBankImages/AppAssets/ReferFriend.png",
                        ),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Text(
                        ">> 3 Level Income\n(From all your refers)",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            color: colorWhite,
                            fontStyle: FontStyle.italic,
                            fontSize: 12),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Want To Earn Passive Income?",
                          style: TextStyle(
                              fontSize: 35,
                              color: colorWhite,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                            "Get your link and refer your friends to $appName, enjoy total profit of 21% (more on special events) of your friends investments with 3 Level earning system ",
                            style: _textStyle1),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          height: 5,
                          width: 75,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(colors: [color4, color3]),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                          "Earn Money Now",
                          style: TextStyle(fontSize: 25, color: Colors.amber),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        const Align(
                          alignment: Alignment.center,
                          child: Icon(FontAwesomeIcons.userAlt),
                        ),
                        const Align(
                            child: Text("Level1",
                                style: TextStyle(
                                    fontSize: 12, color: colorWhite))),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                            "Get 12% commission from all your  Level 1 (Direct downline members) refers when they recharge any amount in the app at any time",
                            textAlign: TextAlign.center,
                            style: _textStyle1),
                        const SizedBox(
                          height: 30,
                        ),
                        const Align(
                          alignment: Alignment.center,
                          child: Icon(FontAwesomeIcons.userFriends),
                        ),
                        const Align(
                            child: Text("Level2",
                                style: TextStyle(
                                    fontSize: 12, color: colorWhite))),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                            "Get 6% commission from all your Level 2 (Level 1's direct downline members) refers when they recharge any amount in the app at any time",
                            textAlign: TextAlign.center,
                            style: _textStyle1),
                        const SizedBox(
                          height: 30,
                        ),
                        const Align(
                          alignment: Alignment.center,
                          child: Icon(FontAwesomeIcons.users),
                        ),
                        const Align(
                            child: Text("Level3",
                                style: TextStyle(
                                    fontSize: 12, color: colorWhite))),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                            "Get 12% commission from all your  Level 3 (Level 2's direct downline members) refers when they recharge any amount in the app at any time.",
                            textAlign: TextAlign.center,
                            style: _textStyle1),
                        const SizedBox(
                          height: 30,
                        ),
                        const Align(
                          alignment: Alignment.center,
                          child: Icon(FontAwesomeIcons.solidGrinHearts),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                            "Most importantly during Saturday, Sunday & At events  commissions of each level is increased by +5% to +10%, also don't worry you will get push notification about these bonuses & there is no any restriction on how many members you/your refers can refer",
                            textAlign: TextAlign.center,
                            style: _textStyle1),
                        const SizedBox(
                          height: 50,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  minWidth: Get.width - 12,
                  color: color4,
                  onPressed: () {
                    Get.toNamed(UserReferIncomeScreen.screenName);
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      "My Referral Link-Incomes",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
