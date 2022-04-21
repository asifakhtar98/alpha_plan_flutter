import 'package:intl/intl.dart';

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
