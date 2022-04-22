import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:powerbank/Constants/Colors.dart';
import 'package:powerbank/HelperClasses/Widgets.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color1,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: color1,
        centerTitle: true,
        title: const Text("Help Center"),
        bottom: PreferredSize(
          preferredSize: MediaQuery.of(context).size * 0.27,
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(4),
            height: Get.height * 0.27,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [color1, color4, color1],
              ),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (Map m in contactsMapList)
                    Container(
                      margin: const EdgeInsets.all(4),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: color3,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: CachedNetworkImage(
                                  width: 150,
                                  fit: BoxFit.fitWidth,
                                  imageUrl: m["Image"]),
                            ),
                          ),
                          MaterialButton(
                            onPressed: m["onClick"],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            minWidth: 150,
                            color: color4,
                            child: Text(m["ActionText"]),
                          ),
                          Text(
                            m["Place"],
                            style: TextStyle(
                              fontSize: 12,
                              color: colorWhite.withOpacity(0.8),
                            ),
                          )
                        ],
                      ),
                    )
                ],
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SizedBox(
          height: Get.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 8,
                    ),
                    Container(
                      height: 50,
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
                      "Frequently\nAsked Questions",
                      style: TextStyle(fontSize: 24, color: colorWhite),
                    ),
                  ],
                ),
                for (Map m in faqMapList)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          m["q"],
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: color4),
                        ),
                        Text(
                          "➥ ${m["a"]}",
                          style: const TextStyle(
                              fontSize: 14,
                              fontStyle: FontStyle.italic,
                              color: colorWhite),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                      ],
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

List<Map> contactsMapList = [
  {
    "Place": "Alert Channel",
    "onClick": () {
      CustomerSupport.openTelegramChannel();
    },
    "Image":
        "https://res.cloudinary.com/earnindia/image/upload/v1644341452/AlphaPlan2/Assets/my8lc5mwzubyomrakv5m.jpg",
    "ActionText": "Join Now"
  },
  {
    "Place": "Manager",
    "onClick": () {
      CustomerSupport.whatsappSupportAdmin1();
    },
    "Image":
        "https://res.cloudinary.com/earnindia/image/upload/v1644341519/AlphaPlan2/Assets/ghxjz2jwwnwh1ud1g6s3.jpg",
    "ActionText": "WhatsApp"
  },
  {
    "Place": "Accountant",
    "onClick": () {
      CustomerSupport.whatsappSupportAdmin2();
    },
    "Image":
        "https://res.cloudinary.com/earnindia/image/upload/v1644341502/AlphaPlan2/Assets/xxh4vfxupqeqd3wztea4.jpg",
    "ActionText": "WhatsApp"
  },
  {
    "Place": "Developer",
    "onClick": () {
      CustomerSupport.openDeveloperSite();
    },
    "Image":
        "https://res.cloudinary.com/earnindia/image/upload/v1644341468/AlphaPlan2/Assets/felxygmint1nyoi3exgp.jpg",
    "ActionText": "Order Apps"
  },
];

List<Map> faqMapList = [
  {
    "q": "What is the income credit time of alpha 2 app plans?",
    "a":
        "Daily income of each active plan is credited at sharp 12.00 am midnight"
  },
  {
    "q": "Is income generated from plan can be withdraw directly?",
    "a":
        "Yes, incomes are credited to withdrawable wallet. So they can be withdraw right-away"
  },
  {
    "q": "How refer commission are distributed?",
    "a":
        "Refer commission are grabbed by your account when your refers(downline members) recharge in alpha 2 recharge section by any methods"
  },
  {
    "q": "What happen when wrong bank info are available in account?",
    "a":
        "While withdrawing with wrong bank details your full withdraw amount will get refund instantly or within few minutes. Then you can withdraw that amount again with correct bank details"
  },
  {
    "q": "How to get best supports from alpha 2 managers/accountants",
    "a":
        "While connecting for help support with alpha 2 manager/accountant explain your query, complain, issue with details and visual or proofs. Record and send video if you found any bugs or issue in app"
  },
];
