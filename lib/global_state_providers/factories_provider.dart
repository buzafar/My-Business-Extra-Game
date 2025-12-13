

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:my_business_extra/models/factory.dart';

import '../services/factory_service.dart';

final factoriesProvider = StateNotifierProvider((ref) {
  return FactoriesNotifier(ref);
});


class FactoriesNotifier extends StateNotifier<AsyncValue<List<Factory>>> {
  FactoriesNotifier(this.ref) : super(AsyncLoading()) {
    loadFactories();
  }
  final Ref ref;

  Future<void> loadFactories() async {
    state = AsyncLoading();
    state = AsyncData(await ref.read(factoryServiceProvider).loadFactories());
  }
}