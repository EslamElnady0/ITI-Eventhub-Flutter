import 'package:intl/intl.dart';

class TicketmasterDateTime {
  TicketmasterDateTime._();

  static final DateFormat _formatter = DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'");

  static String format(DateTime value) {
    return _formatter.format(value.toUtc());
  }
}
