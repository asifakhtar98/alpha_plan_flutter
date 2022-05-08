import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:powerbank/Constants/firestore_strings.dart';
import 'package:powerbank/Constants/strings.dart';

class OrderUiController extends GetxService {
  final _hiveBox = Hive.box(hiveBoxName);
  @override
  void onInit() {
    // TODO: implement onReady
    super.onInit();
    getUserInvestedPlans();
  }

  RxList userInvestedPlans = <Map>[].obs;
  void getUserInvestedPlans() async {
    String mobileNo = await _hiveBox.get(FireString.mobileNo);
    print("From orderUiController: Mob: $mobileNo");
    try {
      FirebaseFirestore.instance
          .collection(FireString.accounts)
          .doc(mobileNo)
          .collection(FireString.myInvestments)
          .snapshots()
          .listen((documentSnapshot) {
        userInvestedPlans.clear();

        for (var document in documentSnapshot.docs.reversed) {
          userInvestedPlans.add({
            FireString.docID: document.id,
            FireString.isCompleted: document.get(FireString.isCompleted),
            FireString.planCapturedDate:
                document.get(FireString.planCapturedDate),
            FireString.planUid: document.get(FireString.planUid),
            FireString.planCapturedAt: document.get(FireString.planCapturedAt),
            FireString.returnedAmount: document.get(FireString.returnedAmount),
            FireString.servedDays: document.get(FireString.servedDays),
          });
          // print(document.get(FireString.checkoutPrice));
        }
      });
    } on FirebaseException catch (e) {
      print("User Order Stream Error $e");
    }
  }
}
