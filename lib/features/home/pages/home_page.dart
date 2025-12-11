import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:auto_route/auto_route.dart';

import '../../../router/app_router.gr.dart';
import '../../auth/providers/auth_provider.dart';

@RoutePage()
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateProvider).value;

    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome ${user?.email}"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              ref.read(authControllerProvider.notifier).signOut();
              context.router.replace(const LoginRoute());
            },
          )
        ],
      ),
      body: const Center(child: Text("Home")),
    );
  }
}