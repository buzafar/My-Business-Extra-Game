import 'package:flutter/material.dart';

import '../helpers/format_price.dart';



class Balance extends StatelessWidget {
  const Balance({super.key, required this.balance});

  final num balance;

  @override
  Widget build(BuildContext context) {
    return Text(formatPrice(balance), style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white, fontWeight: FontWeight.bold));
  }
}
