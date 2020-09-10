import 'package:intl/intl.dart';

class ReadTimestamp {
  static String readTimestamp(int timestamp) {
    var format = DateFormat('d MMM, hh:mm a');
    if (timestamp != null) {
      var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
      return format.format(date);
    } else {
      return '...';
    }
  }
}
