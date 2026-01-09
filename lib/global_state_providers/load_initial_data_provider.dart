import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_business_extra/global_state_providers/current_user_provider.dart';
import 'package:my_business_extra/global_state_providers/demands_provider.dart';
import 'package:my_business_extra/global_state_providers/factories_provider.dart';
import 'package:my_business_extra/global_state_providers/products_provider.dart';
import 'package:my_business_extra/global_state_providers/user_factories_provider.dart';
import 'package:my_business_extra/global_state_providers/warehouse_provider.dart';

enum LoadingStatus {
  userLoading,
  productsLoading,
  factoriesLoading,
  demandsLoading,
  warehouseLoading,
  userFactoriesLoading,
  done,
}

final loadInitialDataProvider =
    AsyncNotifierProvider<LoadInitialDataNotifier, LoadingStatus>(
      LoadInitialDataNotifier.new,
    );

class LoadInitialDataNotifier extends AsyncNotifier<LoadingStatus> {
  // To initialize providers and make them load all the necesarry data from internet
  // when the app is launched. This is used in loading_page.dart

  @override
  Future<LoadingStatus> build() async {
    // The currentUser must always be loaded first
    //becase its id is used to load all the other data below.
    final currentUser = await ref.read(currentUserProvider.future);
    print("currentUser loaded");

    final products = await ref.read(productsProvider.future);
    print("products loaded");

    final factories = await ref.read(factoriesProvider.future);
    print("factories loaded");

    final demands = ref.read(demandsProvider);
    print("demands loaded");

    // final demandsStream = await ref.read(demandsStreamProvider);
    // print("demands stream loaded");

    final warehouse = await ref.read(warehouseProvider.future);
    print("warehouse loaded");

    final userFactories = await ref.read(userFactoriesProvider.future);
    print("user factories loaded");

    print("Everything loaded");

    return LoadingStatus.done;
  }
}
