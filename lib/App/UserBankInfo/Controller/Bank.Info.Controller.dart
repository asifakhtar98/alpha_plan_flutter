import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:powerbank/App/MainFrame/GetxController/Main.Frame.Service.dart';
import 'package:powerbank/Constants/firestore_strings.dart';
import 'package:powerbank/Constants/strings.dart';
import 'package:powerbank/HelperClasses/date_time_formatter.dart';
import 'package:powerbank/HelperClasses/small_services.dart';

class BankInfoScreenController extends GetxService {
  final payeeNameTextController = TextEditingController();
  final bankNameTextController = TextEditingController();
  final accountNoTextController = TextEditingController();
  final bankIfscTextController = TextEditingController();
  final payeeEmailTextController = TextEditingController();
  final upiLinkTextController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _hiveBox = Hive.box(hiveBoxName);

  reload() {
    payeeNameTextController.clear();
    bankNameTextController.clear();
    accountNoTextController.clear();
    bankIfscTextController.clear();
    payeeEmailTextController.clear();
    upiLinkTextController.clear();
    getBankInfo();
  }

  void savePersonalInfo({
    required String nameText,
    required String emailText,
    required String acNo,
    required String ifsc,
    required String bank,
    required String upiLink,
  }) async {
    String mNo = await _hiveBox.get(FireString.mobileNo);
    DocumentReference personalInfo = _firestore
        .collection(FireString.accounts)
        .doc(mNo)
        .collection(FireString.bankInfo)
        .doc(FireString.document1);
    if (nameText == "") {
      SmartDialog.showToast('Wrong Name');
    } else if (!GetUtils.isEmail(emailText)) {
      SmartDialog.showToast('Wrong Email');
    } else if (acNo.length < 10) {
      SmartDialog.showToast('Wrong Account Number');
    } else if (ifsc.length < 8) {
      SmartDialog.showToast('Wrong Ifsc Code');
    } else {
      SmartDialog.showToast("Saving");
      try {
        if (await InternetConnectionChecker().hasConnection != true) {
          SmartDialog.showToast("No Internet Connection");
          throw "noInternetConnection";
        }
        await personalInfo.set({
          FireString.payeeName: nameText,
          FireString.bankName: bank,
          FireString.bankAcNumber: acNo,
          FireString.bankIfsc: ifsc,
          FireString.payeeEmail: emailText,
          FireString.payeeUpiLink: upiLink,
        }, SetOptions(merge: true)).then((value) async {
          saveToHiveBox();
          SmartDialog.showToast("Success");
          var currentDateTime = await DateTimeHelper.getCurrentDateTime();
          SmallServices.updateUserActivityByDate(
              userIdMob: mNo,
              newItemsAsList: [
                "Changed Bank info from ${Get.find<MainFrameGService>().currentDevice} at ${timeAsTxt(currentDateTime.toString())}"
              ]);
        });
      } catch (e) {
        print(e.toString());
      }
    }
  }

  ///////////////////////
  void getBankInfo() async {
    try {
      String mNo = await _hiveBox.get(FireString.mobileNo);
      await _firestore
          .collection(FireString.accounts)
          .doc(mNo)
          .collection(FireString.bankInfo)
          .doc(FireString.document1)
          .get()
          .then((bankData) {
        if (bankData.exists) {
          print("Data Loaded From Firestore");
          payeeNameTextController.text = bankData[FireString.payeeName] ?? "";
          bankNameTextController.text = bankData[FireString.bankName] ?? "";
          accountNoTextController.text =
              bankData[FireString.bankAcNumber] ?? "";
          bankIfscTextController.text = bankData[FireString.bankIfsc] ?? "";
          payeeEmailTextController.text =
              bankData[FireString.payeeEmail] ?? "";
          upiLinkTextController.text = bankData[FireString.payeeUpiLink] ?? "";
          saveToHiveBox();
          //
          //
        }
      });
    } catch (e) {
      print(e.toString());
    }
  }

  void saveToHiveBox() async {
    await _hiveBox.put(FireString.payeeName, payeeNameTextController.text);
    await _hiveBox.put(FireString.bankName, bankNameTextController.text);
    await _hiveBox.put(FireString.bankAcNumber, accountNoTextController.text);
    await _hiveBox.put(FireString.bankIfsc, bankIfscTextController.text);
    await _hiveBox.put(FireString.payeeEmail, payeeEmailTextController.text);
    await _hiveBox.put(FireString.payeeUpiLink, upiLinkTextController.text);
    print("Data Saved To Hive");
  }
}
