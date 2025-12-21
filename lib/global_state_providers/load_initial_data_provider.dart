import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_business_extra/global_state_providers/current_user_provider.dart';
import 'package:my_business_extra/global_state_providers/demands_provider.dart';
import 'package:my_business_extra/global_state_providers/factories_provider.dart';
import 'package:my_business_extra/global_state_providers/products_provider.dart';
import 'package:my_business_extra/global_state_providers/user_factories_provider.dart';
import 'package:my_business_extra/global_state_providers/warehouse_provider.dart';

final loadInitialDataProvider =
    AsyncNotifierProvider<LoadInitialDataNotifier, void>(
      LoadInitialDataNotifier.new,
    );

class LoadInitialDataNotifier extends AsyncNotifier<void> {
  // To initialize providers and make the load all the necesarry data from internet
  // when the app is launched. This is used in loading_page.dart

  @override
  Future<void> build() async {
    // The currentUser must always be loaded first
    //becase its id is used to load all the other data below.
    final currentUser = await ref.watch(currentUserProvider.future);
    print("currentUser loaded");

    final products = await ref.watch(productsProvider.future);
    print("products loaded");

    final factories = await ref.watch(factoriesProvider.future);
    print("factories loaded");

    final demands = await ref.watch(demandsProvider.future);
    print("demands loaded");

    final warehouse = await ref.watch(warehouseProvider.future);
    print("warehouse loaded");

    final userFactories = await ref.watch(userFactoriesProvider.future);
    print("user factories loaded");

    print("Everything loaded");
  }
}
