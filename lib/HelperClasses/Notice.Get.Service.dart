import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:powerbank/Constants/Colors.dart';
import 'package:powerbank/Constants/firestore_strings.dart';
import 'package:powerbank/Constants/strings.dart';
import 'package:url_launcher/url_launcher.dart';

import '../App/HelpCenter/Help.Center.Screen.dart';

class NoticeGetxService extends GetxService {
  RxList adminNotices = [].obs;

  loadNotices() {
    FirebaseFirestore.instance
        .collection(FireString.notifications)
        .get()
        .then((documentsList) {
      adminNotices.assignAll(documentsList.docs);
    });
  }

  showNoticeWallDialog() {
    if (adminNotices.isEmpty) loadNotices();
    loadNotices();
    SmartDialog.show(
        maskColorTemp: color2.withOpacity(0.85),
        widget: SafeArea(
          child: SizedBox(
            height: Get.height,
            width: Get.width,
            child: Column(
              children: [
                const SizedBox(height: 8),
                const Text(
                  "- $appName Important Notices -",
                  style: TextStyle(color: color4),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: SingleChildScrollView(
                    child: Obx(() {
                      return Column(
                        children: [
                          for (var doc in adminNotices)
                            Visibility(
                              visible: doc[FireString.visibility],
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 6, vertical: 4),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: color3,
                                    ),
                                    child: ListTile(
                                      title: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 15.0),
                                        child: Text(
                                          doc[FireString.noticeText],
                                          style: const TextStyle(
                                              color: colorWhite),
                                        ),
                                      ),
                                      onTap: () async {
                                        if (doc[FireString.launchUrl] != "") {
                                          await canLaunch(
                                                  doc[FireString.launchUrl])
                                              ? await launch(
                                                  doc[FireString.launchUrl])
                                              : throw "cantLaunchUrl";
                                        }
                                      },
                                    ),
                                  ),
                                  Positioned(
                                    left: 8,
                                    top: 0,
                                    child: Icon(
                                      FontAwesomeIcons.solidBookmark,
                                      color: color4.withOpacity(0.9),
                                      size: 20,
                                    ),
                                  ),
                                  if (doc[FireString.launchUrl] != "")
                                    Positioned(
                                      right: 15,
                                      bottom: 12,
                                      child: Icon(
                                        (doc[FireString.launchUrl]
                                                    .contains('youtube') ||
                                                doc[FireString.launchUrl]
                                                    .contains(
                                                        'https://youtu.be'))
                                            ? FontAwesomeIcons.youtube
                                            : FontAwesomeIcons.chrome,
                                        color: colorWhite,
                                        size: 20,
                                      ),
                                    )
                                ],
                              ),
                            )
                        ],
                      );
                    }),
                  ),
                ),
                TextButton(
                    onPressed: () async {
                      SmartDialog.dismiss();
                      Get.to(() => const HelpCenterScreen());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          FontAwesomeIcons.whatsapp,
                          size: 16,
                          color: Colors.green,
                        ),
                        Text(
                          " Contact Us (24x7)",
                          style: TextStyle(fontSize: 12, color: Colors.green),
                        ),
                      ],
                    ))
              ],
            ),
          ),
        ));
  }
}
