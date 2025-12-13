import 'package:my_business_extra/helpers/addDollarSign.dart';
import 'package:my_business_extra/helpers/format_number.dart';


String formatPrice(num price) {
  return "\$ ${formatNumber(price)}";
}