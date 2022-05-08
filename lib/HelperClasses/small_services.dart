import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:powerbank/Constants/firestore_strings.dart';

import 'date_time_formatter.dart';

class SmallServices {
  static updateUserActivityByDate(
      {required String userIdMob, required List newItemsAsList}) async {
    var currentDateTime = await DateTimeHelper.getCurrentDateTime();
    try {
      await FirebaseFirestore.instance
          .collection(FireString.accounts)
          .doc(userIdMob)
          .collection(FireString.myActivities)
          .doc(timeAsFireDoc(currentDateTime.toString()))
          .set({FireString.myActivities: FieldValue.arrayUnion(newItemsAsList)},
              SetOptions(merge: true));
    } on FirebaseException catch (e) {
      print(e.toString());
    }
  }
}
