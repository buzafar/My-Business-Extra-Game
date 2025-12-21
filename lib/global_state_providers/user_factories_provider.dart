import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:my_business_extra/global_state_providers/current_user_provider.dart';
import 'package:my_business_extra/global_state_providers/factories_provider.dart';
import 'package:my_business_extra/global_state_providers/warehouse_provider.dart';
import 'package:my_business_extra/models/user_factory.dart';
import 'package:my_business_extra/services/user_factory_service.dart';

import '../models/user.dart';
import '../models/warehouse_product.dart';

final userFactoriesProvider =
    AsyncNotifierProvider<UserFactoriesNotifier, List<UserFactory>>(
      UserFactoriesNotifier.new,
    );

class UserFactoriesNotifier extends AsyncNotifier<List<UserFactory>> {
  @override
  Future<List<UserFactory>> build() async {
    final initialState = ref
        .read(userFactoryServiceProvider)
        .loadUserFactories(userId: ref.read(currentUserProvider).value!.id);
    return initialState;
  }

  /// Local-only update (safe)
  void updateLastProducedLocallyToNow(UserFactory userFactory) {
    final factories = state.value;
    if (factories == null) return;

    state = AsyncData(
      factories.map((f) {
        if (f.id == userFactory.id) {
          return f.copyWith(lastProduced: DateTime.now());
        }
        return f;
      }).toList(),
    );
  }
}
