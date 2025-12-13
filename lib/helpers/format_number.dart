import 'package:intl/intl.dart';


String formatNumber(num number) {
  final formatter = NumberFormat('###,###,###,###,###,###,###');
  return formatter.format(number);
}