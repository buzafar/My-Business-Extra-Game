import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:my_business_extra/components/primary_button.dart';
import 'package:my_business_extra/designs/values.dart';

import '../../../failure.dart';
import '../../../router/app_router.gr.dart';
import '../providers/auth_provider.dart';

import 'package:auto_route/auto_route.dart';


@RoutePage()
class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authControllerProvider);

    final email = TextEditingController();
    final password = TextEditingController();

    ref.listen(authControllerProvider, (prev, next) {
      next.whenOrNull(
        data: (user) {
          if (user != null) {
            context.router.replace(const LoadingRoute());
          }
        },
        error: (err, _) {
          print(err.toString());
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text((err as Failure).message), behavior: SnackBarBehavior.floating),
          );
        },
      );
    });

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.all(screenPadding),
          child: Center(
            child: Column(
              children: [
                Text("Welcome to My Business Extra", style: Theme.of(context).textTheme.headlineLarge,),
                Gap(32),
                TextField(controller: email, decoration: const InputDecoration(labelText: "Email")),
                Gap(24),
                TextField(controller: password, obscureText: true, decoration: const InputDecoration(labelText: "Password")),
                Gap(48),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () {
                      ref.read(authControllerProvider.notifier).signIn(
                        email.text,
                        password.text,
                      );
                    },
                    child: ref.watch(authControllerProvider).isLoading ? CircularProgressIndicator(color: Colors.white,) : Text("Login"),
                  ),
                ),
                Gap(64),
                TextButton(
                  onPressed: () => context.router.replace(const SignupRoute()),
                  child: const Text("Create an account"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}