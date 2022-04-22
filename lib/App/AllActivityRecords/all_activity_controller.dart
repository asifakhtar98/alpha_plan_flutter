import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:powerbank/Constants/strings.dart';

class AllActScreenController extends GetxService {
  final _hiveBox = Hive.box(hiveBoxName);
  RxList myActivities = [].obs;
  getMyActivities() async {
    String mobileNo = await _hiveBox.get(FireString.mobileNo);
    await FirebaseFirestore.instance
        .collection(FireString.accounts)
        .doc(mobileNo)
        .collection(FireString.myActivities)
        .get()
        .then((allDocs) {
      myActivities.assignAll(allDocs.docs);
      print(myActivities.toString());
    });
  }
}
