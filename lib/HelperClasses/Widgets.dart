import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:powerbank/Constants/firestore_strings.dart';
import 'package:powerbank/Constants/strings.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Constants/Colors.dart';

class AppIconWidget extends StatelessWidget {
  const AppIconWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset("assets/png_app_logo.png");
  }
}

class DialogAppNameTag extends StatelessWidget {
  const DialogAppNameTag({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: Get.width - 150,
        ),
        Container(
            padding: const EdgeInsets.fromLTRB(8, 3, 8, 0),
            decoration: const BoxDecoration(
                color: color4,
                borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
            child: const Text(
              appName,
              style: TextStyle(fontSize: 8, color: colorWhite),
            )),
      ],
    );
  }
}

class CustomerSupport {
  static whatsappSupportAdmin1() async {
    FirebaseFirestore.instance
        .collection(FireString.globalSystem)
        .doc(FireString.customerSupport)
        .get()
        .then((docMap) async {
      String tmpVal = docMap.get(FireString.admin1No);
      print(tmpVal);
      await canLaunch("https://wa.me/$tmpVal?text=Hii,I'm<YourName>")
          ? await launch("https://wa.me/$tmpVal?text=Hii,I'm<YourName>")
          : throw "Cant launch url";
    });
  }

  //Not used
  static openComplainLink() async {
    FirebaseFirestore.instance
        .collection(FireString.globalSystem)
        .doc(FireString.customerSupport)
        .get()
        .then((docMap) async {
      String tmpVal = docMap.get(FireString.complainLink);
      print(tmpVal);
      await canLaunch(tmpVal) ? await launch(tmpVal) : throw "Cant launch url";
    });
  }

  static openTelegramChannel() async {
    FirebaseFirestore.instance
        .collection(FireString.globalSystem)
        .doc(FireString.customerSupport)
        .get()
        .then((docMap) async {
      String tmpVal = docMap.get(FireString.telegramChannelLink);
      print(tmpVal);
      await canLaunch(tmpVal) ? await launch(tmpVal) : throw "Cant launch url";
    });
  }

  static openDeveloperSite() async {
    FirebaseFirestore.instance
        .collection(FireString.globalSystem)
        .doc(FireString.customerSupport)
        .get()
        .then((docMap) async {
      String tmpVal = docMap.get(FireString.developerSite);
      print(tmpVal);
      await canLaunch(tmpVal) ? await launch(tmpVal) : throw "Cant launch url";
    });
  }

  static openFirestoreExternalLinks({required String fbFieldName}) async {
    SmartDialog.showToast("Opening $fbFieldName");
    FirebaseFirestore.instance
        .collection(FireString.globalSystem)
        .doc(FireString.externalLinks)
        .get()
        .then((docMap) async {
      String tmpVal = docMap.get(fbFieldName);
      print(tmpVal);
      await canLaunch(tmpVal) ? await launch(tmpVal) : throw "Cant launch url";
    });
  }

  static openPrivacyPolicy() async {
    await canLaunch(appPrivacyPolicyLink)
        ? await launch(appPrivacyPolicyLink)
        : throw "Cant launch url";
  }
}
