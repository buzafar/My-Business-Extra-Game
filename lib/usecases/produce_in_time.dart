import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_business_extra/global_state_providers/current_user_provider.dart';
import 'package:my_business_extra/global_state_providers/factories_provider.dart';
import 'package:my_business_extra/global_state_providers/products_provider.dart';
import 'package:my_business_extra/global_state_providers/user_factories_provider.dart';
import 'package:my_business_extra/global_state_providers/warehouse_provider.dart';
import 'package:my_business_extra/models/user_factory.dart';
import 'package:my_business_extra/models/warehouse_product.dart';
import 'package:my_business_extra/services/user_factory_service.dart';
import 'package:my_business_extra/services/user_service.dart';
import 'package:my_business_extra/services/warehouse_service.dart';

class ProduceInTime {
  /*
  This usecase is used for factory production.
  Every userFactory.requiredSeconds, this usecase gets called
  and a new product is produced.

  1. A new product is added to the warehouse of the user
  2. The lastProduced field of userFactory is set to now.
  3. The balance of the user is decreased by userFactory.productionCost

  Updates both locally and in server
   */

  final Ref ref;

  ProduceInTime(this.ref);

  Future<void> run(UserFactory userFactory) async {
    print("Hello World");
    final factories = ref.read(factoriesProvider).value!;
    final warehouse = ref.read(warehouseProvider).value!;
    final user = ref.read(currentUserProvider).value!;

    final productId =
        factories.firstWhere((e) => e.id == userFactory.factoryId).productId;

    final warehouseProduct = WarehouseProduct(
      productId: productId,
      warehouseId: warehouse.id,
      quantity: userFactory.outputSlots,
    );

    final price = userFactory.productionCost * userFactory.outputSlots;

    // local update
    ref
        .read(warehouseProvider.notifier)
        .addProductToWarehouse(warehouseProduct);
    ref
        .read(userFactoriesProvider.notifier)
        .updateLastProducedLocallyToNow(userFactory);
    ref.read(currentUserProvider.notifier).decreaseBalance(price.toDouble());

    // server sync
    await Future.wait([
      ref
          .read(warehouseServiceProvider)
          .addProductToWarehouse(warehouseProduct),
      ref.read(userFactoryServiceProvider).setLastProducedTime(userFactory),
      ref
          .read(userServiceProvider)
          .decreaseBalance(
            newBalance: user.balance.toDouble() - price.toDouble(),
          ),
    ]);
  }
}

final produceInTimeUseCaseProvider = Provider<ProduceInTime>((ref) {
  return ProduceInTime(ref);
});
