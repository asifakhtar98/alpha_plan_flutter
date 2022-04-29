import 'package:intl/intl.dart';
import 'package:ntp/ntp.dart';

String ddMMMyyyy(String txt) {
  final DateFormat dateFormatter = DateFormat("dd : MMM - yyyy");
  return dateFormatter.format(DateTime.parse(txt));
}

String ddMMMyyyyTime(String txt) {
  final DateFormat dateFormatter = DateFormat("dd : MMM - yyyy At hh:mm a");
  return dateFormatter.format(DateTime.parse(txt));
}

String timeAsTxt(String txt) {
  final DateFormat dateFormatter = DateFormat("hh:mm a");
  return dateFormatter.format(DateTime.parse(txt));
}

String timeAsFireDoc(String txt) {
  final DateFormat dateFormatter = DateFormat("yyyy-MM-dd");
  return dateFormatter.format(DateTime.parse(txt));
}

class DateTimeHelper {
  DateTimeHelper._();
  static Future<DateTime> getCurrentDateTime() async {
    DateTime currentDateTime = DateTime.now();
    try {
      currentDateTime = await NTP.now();
    } catch (e) {
      currentDateTime = DateTime.now();
      print(e);
    }
    return currentDateTime;
  }
}
