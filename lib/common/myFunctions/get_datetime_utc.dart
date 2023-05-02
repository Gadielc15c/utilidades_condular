import 'package:intl/intl.dart';

String getDateTime() {
  DateTime now = DateTime.now().toUtc();
  String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
  return formattedDate;
}
