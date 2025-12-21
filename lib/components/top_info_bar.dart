import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_business_extra/components/balance.dart';
import 'package:my_business_extra/designs/values.dart';
import 'package:my_business_extra/global_state_providers/current_user_provider.dart';

class TopInfoBar extends ConsumerWidget {
  const TopInfoBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userModel = ref.watch(currentUserProvider).value;

    return SafeArea(
      child: Container(
        height: topBarInfoHeight,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceTint,
        ),
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: screenPadding),
          child: Row(children: [BalanceCounter(balance: userModel!.balance)]),
        ),
      ),
    );
  }
}
