import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:powerbank/Constants/Colors.dart';
import 'package:powerbank/HelperClasses/Widgets.dart';
import 'package:powerbank/Constants/strings.dart';
import 'package:powerbank/HelperClasses/date_time_formatter.dart';

import 'all_activity_controller.dart';

class AllActivityScreen extends StatelessWidget {
  static String screenName = "/all-activity-screen";

  AllActivityScreen({Key? key}) : super(key: key);
  final _screenController = Get.find<AllActScreenController>();

  @override
  Widget build(BuildContext context) {
    _screenController.getMyActivities();
    return Scaffold(
        backgroundColor: color1,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: color1,
          centerTitle: true,
          title: const Text("App Activities"),
          actions: [
            IconButton(
                onPressed: () {
                  CustomerSupport.openTelegramChannel();
                },
                icon: const Icon(FontAwesomeIcons.globeAsia))
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: Obx(() {
                List myActs = _screenController.myActivities.reversed.toList();
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: myActs.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ExpansionTileCard(
                        title: Text(
                          ddMMMyyyy(myActs[index].id),
                          style: const TextStyle(color: colorWhite),
                        ),
                        baseColor: color3,
                        expandedTextColor: colorWhite,
                        expandedColor: color4,
                        children: [
                          for (var items in myActs[index]
                                  [FireString.myActivities]
                              .reversed)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                items,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 12,
                                    color: color2,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          const SizedBox(height: 8)
                        ],
                      ),
                    );
                  },
                );
              }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(width: 25, height: 25, child: AppIconWidget()),
                const SizedBox(
                  width: 12,
                ),
                Text(
                  appName.toUpperCase(),
                  style: const TextStyle(
                      color: colorWhite,
                      fontSize: 18,
                      fontWeight: FontWeight.w900),
                ),
              ],
            ),
          ],
        ));
  }
}
