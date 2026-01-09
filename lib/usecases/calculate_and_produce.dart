import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_business_extra/global_state_providers/current_user_provider.dart';
import 'package:my_business_extra/global_state_providers/factories_provider.dart';
import 'package:my_business_extra/global_state_providers/user_factories_provider.dart';
import 'package:my_business_extra/global_state_providers/warehouse_provider.dart';
import 'package:my_business_extra/models/user_factory.dart';
import 'package:my_business_extra/models/warehouse_product.dart';
import 'package:my_business_extra/services/user_factory_service.dart';
import 'package:my_business_extra/services/user_service.dart';
import 'package:my_business_extra/services/warehouse_service.dart';

class CalculateAndProduce {
  /*
  This usecase is used for factory production when user opens
  the app for the first time after being offline.
  It is used to calculate how much a factory has produced while the user was offline.


  1. How much products has been produced while the user was offline is calculated
  2. The calculated products are then added to the warehouse
  3. Set the lastTimeProducedLocally to now
  3. The balance of the user is decreased by userFactory.productionCost * howMuchToProduce

  Updates both locally and in server
   */

  CalculateAndProduce(this.ref);
  final Ref ref;

  Future<void> run({required UserFactory userFactory}) async {
    final factories = ref.read(factoriesProvider).value!;
    final warehouse = ref.read(warehouseProvider).value!;
    final user = ref.read(currentUserProvider).value!;

    final productId =
        factories.firstWhere((e) => e.id == userFactory.factoryId).productId;

    final now = DateTime.now();
    final secondsPassed = now.difference(userFactory.lastProduced).inSeconds;
    print("SECONDS PASSED $secondsPassed");

    final howMuchToProduce =
        (secondsPassed ~/ userFactory.requiredSeconds) *
        userFactory.outputSlots;

    final price = (howMuchToProduce * userFactory.productionCost);

    final warehouseProduct = WarehouseProduct(
      productId: productId,
      warehouseId: warehouse.id,
      quantity: howMuchToProduce,
    );

    // -------------------------    LOCAL UPDATE -----------------------------------------
    ref
        .read(warehouseProvider.notifier)
        .addProductToWarehouse(warehouseProduct);

    ref
        .read(userFactoriesProvider.notifier)
        .updateLastProducedLocallyToNow(userFactory);

    ref.read(currentUserProvider.notifier).decreaseBalance(price.toDouble());

    // -------------------------    SERVER UPDATE -----------------------------------------
    await Future.wait([
      ref
          .read(warehouseServiceProvider)
          .addProductToWarehouse(warehouseProduct),
      ref.read(userFactoryServiceProvider).setLastProducedTime(userFactory),
      ref
          .read(userServiceProvider)
          .decreaseBalance(newBalance: user.balance.toDouble() - price),
    ]);
  }
}

final calculateAndProduceUseCaseProvider = Provider<CalculateAndProduce>((ref) {
  return CalculateAndProduce(ref);
});
