import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_business_extra/global_state_providers/load_initial_data_provider.dart';
import 'package:my_business_extra/global_state_providers/current_user_provider.dart';
import 'package:auto_route/auto_route.dart';
import 'package:my_business_extra/helpers/failure.dart';
import 'package:my_business_extra/global_state_providers/products_provider.dart';
import 'package:my_business_extra/models/product.dart';
import 'package:my_business_extra/router/app_router.gr.dart';

import 'models/user.dart';

@RoutePage()
class LoadingPage extends ConsumerWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(loadInitialDataProvider, (prev, next) {
      next.whenData((_) {
        context.router.replace(TabsRoute());
      });
    });

    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
