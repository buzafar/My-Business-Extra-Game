import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_business_extra/global_state_providers/current_user_provider.dart';
import 'package:my_business_extra/global_state_providers/products_provider.dart';

final appReadyProvider = Provider<AsyncValue>((ref) {

  final currentUser = ref.watch(currentUserProvider);
  final products = ref.watch(productsProvider);

  if (currentUser.isLoading || products.isLoading) {
    return const AsyncLoading();
  }

  if (currentUser.hasError) return AsyncError(currentUser.error!, currentUser.stackTrace!);
  if (products.hasError) return AsyncError(products.error!, products.stackTrace!);

  if (currentUser.hasValue && products.hasValue) {
    return AsyncData(null);
  }

  return const AsyncLoading();

});