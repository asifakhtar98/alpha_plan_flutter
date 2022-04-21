import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:ntp/ntp.dart';

import 'package:powerbank/Constants/strings.dart';
import 'package:powerbank/HelperClasses/date_time_formatter.dart';
import 'package:powerbank/HelperClasses/small_services.dart';
import 'package:powerbank/MainFrame/GetxController/Main.Frame.Service.dart';

class BankInfoScreenController extends GetxService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _hiveBox = Hive.box(hiveBoxName);
  RxString payeeName = "".obs;
  RxString bankName = "".obs;
  RxString bankAcNumber = "".obs;
  RxString bankIfsc = "".obs;
  RxString payeeEmail = "".obs;
  RxString payeeUpiLink = "".obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

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
          payeeName.value = nameText;
          bankName.value = bank;
          bankAcNumber.value = acNo;
          bankIfsc.value = ifsc;
          payeeEmail.value = emailText;
          payeeUpiLink.value = upiLink;
          saveToHiveBox();
          SmartDialog.showToast("Success");
          var currentDateTime = await NTP.now();
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
          .then((_bankData) {
        if (_bankData.exists) {
          print("Data Loaded From Firestore");
          payeeName.value = _bankData[FireString.payeeName] ?? "";
          bankName.value = _bankData[FireString.bankName] ?? "";
          bankAcNumber.value = _bankData[FireString.bankAcNumber] ?? "";
          bankIfsc.value = _bankData[FireString.bankIfsc] ?? "";
          payeeEmail.value = _bankData[FireString.payeeEmail] ?? "";
          payeeUpiLink.value = _bankData[FireString.payeeUpiLink] ?? "";
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
    await _hiveBox.put(FireString.payeeName, payeeName.value);
    await _hiveBox.put(FireString.bankName, bankName.value);
    await _hiveBox.put(FireString.bankAcNumber, bankAcNumber.value);
    await _hiveBox.put(FireString.bankIfsc, bankIfsc.value);
    await _hiveBox.put(FireString.payeeEmail, payeeEmail.value);
    await _hiveBox.put(FireString.payeeUpiLink, payeeUpiLink.value);
    print("Data Saved To Hive");
  }
}
