import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:my_business_extra/components/balance.dart';
import 'package:my_business_extra/designs/values.dart';
import 'package:my_business_extra/features/auth/pages/login_page.dart';
import 'package:my_business_extra/global_state_providers/current_user_provider.dart';
import 'package:auto_route/auto_route.dart';
import 'package:my_business_extra/global_state_providers/load_initial_data_provider.dart';
import 'package:my_business_extra/router/app_router.gr.dart';

class TopInfoBar extends ConsumerWidget {
  const TopInfoBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (ref.watch(loadInitialDataProvider).value != LoadingStatus.done) {
      return SizedBox.shrink();
    }

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
