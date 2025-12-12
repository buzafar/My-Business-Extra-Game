import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:auto_route/auto_route.dart';
import 'package:my_business_extra/global_state_providers/current_user_provider.dart';
import 'package:my_business_extra/components/balance.dart';

import '../../../router/app_router.gr.dart';
import '../../auth/providers/auth_provider.dart';

@RoutePage()
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final user = ref.watch(authStateProvider).value;
    final userModel = ref.watch(currentUserProvider).value;

    return Scaffold(

      body:  SafeArea(
        child: Center(child: Column(
          children: [
            Container(
              padding: EdgeInsetsGeometry.all(8),
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.green),
              child: Row(
                children: [
                  Balance(balance: userModel!.balance),
                ],
              ),
            ),
            FilledButton(onPressed: () {
              ref.read(currentUserProvider.notifier).increaseBalance();
            }, child: Text("Increase by 50"))
          ],
        )),
      ),
    );
  }
}