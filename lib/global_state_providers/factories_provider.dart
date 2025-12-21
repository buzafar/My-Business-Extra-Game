import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:my_business_extra/models/factory.dart';

import '../services/factory_service.dart';

final factoriesProvider =
    AsyncNotifierProvider<FactoriesNotifier, List<Factory>>(
      () => FactoriesNotifier(),
    );

// Notifier
class FactoriesNotifier extends AsyncNotifier<List<Factory>> {
  @override
  Future<List<Factory>> build() async {
    // This is automatically called once when the provider is first read
    return ref.read(factoryServiceProvider).loadFactories();
  }

  // Optional: manual reload method
  Future<void> reloadFactories() async {
    state = const AsyncValue.loading();
    state = AsyncValue.data(
      await ref.read(factoryServiceProvider).loadFactories(),
    );
  }
}
