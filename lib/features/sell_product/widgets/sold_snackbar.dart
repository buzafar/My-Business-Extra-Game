import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:my_business_extra/helpers/assets.dart';
import 'package:my_business_extra/helpers/helper_functions.dart';
import 'package:my_progress_bar/my_progress_bar.dart';

class SoldSnackbar extends StatelessWidget {
  const SoldSnackbar({super.key, required this.price});

  final double price;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                width: 30,
                height: 30,
                child: Image.asset(Assets.cityImage),
              ),
              const Gap(8),
              const Text("Sold to the City"),
            ],
          ),

          const Gap(16),

          TweenAnimationBuilder<int>(
            tween: IntTween(begin: 0, end: price.toInt()),
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeOut,
            builder: (context, value, child) {
              return Text(
                "+ ${formatPrice(price, compact: false)}",
                style: Theme.of(
                  context,
                ).textTheme.titleLarge!.copyWith(color: Colors.white),
              );
            },
          ),
        ],
      ),
    );
  }
}
