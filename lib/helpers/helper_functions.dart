import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:currency_formatter/currency_formatter.dart';

String formatPrice(num price) {
  final r = CurrencyFormatter.format(
    price,
    CurrencyFormat.usd,
    enforceDecimals: true,
  );
  return r;
}

String formatNumber(num number) {
  final formatter = NumberFormat('###,###,###,###,###,###,###');
  return formatter.format(number);
}

int generateRandomNumberId() {
  // Define the minimum 6-digit number (inclusive)
  int min = 100000;
  // Define the maximum 6-digit number (inclusive)
  int max = 999999;

  var randomizer = Random();

  int randomNumber = min + randomizer.nextInt(max - min + 1);

  return randomNumber;
}

// this is used to get the global position of a widget who has the key connected to it
// then the global position(Offset) is used to show FloatingBubbleWidget(e.g: redCostText after production)
Offset getGlobalPosition(GlobalKey key) {
  final renderBox = key.currentContext?.findRenderObject() as RenderBox?;
  if (renderBox == null) return Offset.zero;
  return renderBox.localToGlobal(Offset.zero);
}
