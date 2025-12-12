import 'package:intl/intl.dart';


String formatNumber(double number) {
  final formatter = NumberFormat('###,###,###,###,###,###,###');
  return formatter.format(number);
}