import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:my_business_extra/global_state_providers/current_user_provider.dart';
import 'package:my_business_extra/global_state_providers/factories_provider.dart';
import 'package:my_business_extra/global_state_providers/warehouse_provider.dart';
import 'package:my_business_extra/helpers/generateRandomNumberId.dart';
import 'package:my_business_extra/models/user_factory.dart';
import 'package:my_business_extra/services/user_factory_service.dart';

import '../models/user.dart';
import '../models/warehouse_product.dart';

final userFactoriesProvider = StateNotifierProvider((ref) {
  final userAsync = ref.watch(currentUserProvider);
  return UserFactoriesNotifier(ref, userAsync);
});


class UserFactoriesNotifier extends StateNotifier<AsyncValue<List<UserFactory>>> {
  UserFactoriesNotifier(this.ref, this.userAsync): super(AsyncLoading()) {
    // wait until user data is loaded first
    userAsync.whenData((user) {
      loadUserFactories(user.id);
    });
  }

  final Ref ref;
  final AsyncValue<UserModel> userAsync;

  Future<void> loadUserFactories(int userId) async {
    state = AsyncLoading();
    state = AsyncData(await ref.read(userFactoryServiceProvider).loadUserFactories(userId: userId));
  }


  Future<void> produceInTime(UserFactory userFactory) async {


    final int productId = ref.read(factoriesProvider).value!.firstWhere((e) => e.id == userFactory.factoryId).productId;

    ref.watch(warehouseProvider.notifier).addProductToWarehouse(
        WarehouseProduct(productId: productId, warehouseId: ref.read(warehouseProvider).value!.id, quantity: 1)
    );

    state.value!.forEach((e) async {
      if (e.id == userFactory.id) {
        e.lastProduced = DateTime.now();
      }
    });

    await ref.read(userFactoryServiceProvider).setLastProducedTime(userFactory);


    state = AsyncData([...state.value!]);
  }


  Future<void> calculateAndProduce(UserFactory userFactory) async {
    print(2);
    final start = userFactory.lastProduced;
    final now = DateTime.now();

    final secondsPassed = now.difference(start).inSeconds;

    final int howMuchToProduce = secondsPassed ~/ userFactory.requiredSeconds;
    print(howMuchToProduce);

    final int productId = ref.read(factoriesProvider).value!.firstWhere((e) => e.id == userFactory.factoryId).productId;

    ref.watch(warehouseProvider.notifier).addProductToWarehouse(
        WarehouseProduct(productId: productId, warehouseId: ref.read(warehouseProvider).value!.id, quantity: howMuchToProduce)
    );

    await ref.read(userFactoryServiceProvider).setLastProducedTime(userFactory);

    state = AsyncData([...state.value!]);
  }

}