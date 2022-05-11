import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:powerbank/Constants/Colors.dart';
import 'package:powerbank/Constants/strings.dart';
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
                                  fit: BoxFit.cover,
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
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                              color: color4),
                        ),
                        Text(
                          "➥ ${m["a"]}",
                          style:
                              const TextStyle(fontSize: 14, color: colorWhite),
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
        "https://res.cloudinary.com/promisedpayment/image/upload/v1650794761/DreamLightCity/AppAssets/telegram3627_qniduu.png",
    "ActionText": "Join Now"
  },
  {
    "Place": "Manager",
    "onClick": () {
      CustomerSupport.whatsappSupportAdmin1();
    },
    "Image":
        "https://res.cloudinary.com/promisedpayment/image/upload/v1650793484/DreamLightCity/AppAssets/official-man1241_na6g6e.jpg",
    "ActionText": "WhatsApp"
  },
  {
    "Place": "Server Admin",
    "onClick": () {
      CustomerSupport.openComplainLink();
    },
    "Image":
        "https://res.cloudinary.com/promisedpayment/image/upload/v1650793538/DreamLightCity/AppAssets/official-woman12414_v9kwqv.jpg",
    "ActionText": "Open Form"
  },
  {
    "Place": "Developer",
    "onClick": () {
      CustomerSupport.openDeveloperSite();
    },
    "Image":
        "https://res.cloudinary.com/promisedpayment/image/upload/v1651164426/DreamLightCity/AppAssets/felxygmint1nyoi3exgp_tcj8o6.jpg",
    "ActionText": "Order Apps"
  },
];

List<Map> faqMapList = [
  {
    "q": "What is the income credit time of $appNameShort App?",
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
        "Refer commission are grabbed by your account when your refers(downline members) recharge in $appNameShort App recharge section by any methods"
  },
  {
    "q": "What happen when wrong bank info are available in account?",
    "a":
        "While withdrawing with wrong bank details your full withdraw amount will get refund instantly or within few minutes. Then you can withdraw that amount again with correct bank details"
  },
  {
    "q": "How to get best supports from $appNameShort App managers/accountants",
    "a":
        "While connecting for help support with $appNameShort App manager/server admin explain your query, complain, issue with details and visual or proofs. Record and send video if you found any bugs or issue in app"
  },
];
