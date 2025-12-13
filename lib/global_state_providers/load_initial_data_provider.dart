import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_business_extra/global_state_providers/current_user_provider.dart';
import 'package:my_business_extra/global_state_providers/factories_provider.dart';
import 'package:my_business_extra/global_state_providers/products_provider.dart';
import 'package:my_business_extra/global_state_providers/user_factories_provider.dart';
import 'package:my_business_extra/global_state_providers/warehouse_provider.dart';

final loadInitialDataProvider = Provider<AsyncValue>((ref) {

  final currentUser = ref.watch(currentUserProvider);
  final products = ref.watch(productsProvider);
  final warehouse = ref.watch(warehouseProvider);
  final factories = ref.watch(factoriesProvider);
  final userFactories = ref.watch(userFactoriesProvider);

  if (currentUser.isLoading || products.isLoading || warehouse.isLoading || factories.isLoading || userFactories.isLoading) {
    return const AsyncLoading();
  }

  if (currentUser.hasError) return AsyncError(currentUser.error!, currentUser.stackTrace!);
  if (products.hasError) return AsyncError(products.error!, products.stackTrace!);
  if (warehouse.hasError) return AsyncError(warehouse.error!, warehouse.stackTrace!);
  if (factories.hasError) return AsyncError(factories.error!, factories.stackTrace!);
  if (userFactories.hasError) return AsyncError(userFactories.error!, userFactories.stackTrace!);

  if (currentUser.hasValue && products.hasValue && warehouse.hasValue && factories.hasValue
  && userFactories.hasValue) {
    return AsyncData(null);
  }

  return const AsyncLoading();

});