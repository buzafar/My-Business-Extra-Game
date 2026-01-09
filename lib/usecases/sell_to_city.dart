import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_business_extra/game_logic/game_logic.dart';
import 'package:my_business_extra/global_state_providers/current_user_provider.dart';
import 'package:my_business_extra/global_state_providers/demands_provider.dart';
import 'package:my_business_extra/global_state_providers/products_provider.dart';
import 'package:my_business_extra/global_state_providers/warehouse_provider.dart';
import 'package:my_business_extra/models/demand.dart';
import 'package:my_business_extra/models/product.dart';
import 'package:my_business_extra/models/warehouse_product.dart';
import 'package:my_business_extra/services/demands_service.dart';
import 'package:my_business_extra/services/user_service.dart';
import 'package:my_business_extra/services/warehouse_service.dart';

class SellToCity {
  /*
  This usecase is used to sell warehouse product to the city market.

  1. The sold warehouse product quantity is removed from the warehouse of the user
  2. The balance of the user is increased by warehouseProduct.quantity * demand.price
  3. The city supply is increased
  4. New price for the product in the city market is set 

  Updates both locally and in server
   */

  SellToCity(this.ref);
  final Ref ref;

  Future<void> run(WarehouseProduct warehouseProduct) async {
    final products = ref.read(productsProvider).value!;
    final user = ref.read(currentUserProvider).value!;
    final demands = ref.read(demandsProvider);

    final num howMuchToIncreaseBalance =
        warehouseProduct.quantity *
        demands
            .firstWhere((e) => e.productId == warehouseProduct.productId)
            .productPrice;

    final Demand demand = demands.firstWhere(
      (d) => d.productId == warehouseProduct.productId,
    );

    final Product product = products.firstWhere(
      (p) => p.id == warehouseProduct.productId,
    );

    // -------------------------    LOCAL UPDATE -----------------------------------------
    ref
        .read(warehouseProvider.notifier)
        .removeProductFromWarehouse(warehouseProduct);

    ref
        .read(currentUserProvider.notifier)
        .increaseBalance(howMuchToIncreaseBalance.toDouble());

    // We dont do any local changes to demands, because it is shown to the user in real time from internet, so we just update the server

    // -------------------------    SERVER UPDATE -----------------------------------------
    await Future.wait([
      ref
          .read(warehouseServiceProvider)
          .removeProductFromWarehouse(warehouseProduct),

      ref
          .read(userServiceProvider)
          .increaseBalance(
            newBalance: (user.balance + howMuchToIncreaseBalance).toDouble(),
          ),

      ref
          .read(demandsServiceProvider)
          .increaseSupply(
            demand,
            newAmount: demand.supply + warehouseProduct.quantity,
          ),

      ref
          .read(demandsServiceProvider)
          .newPrice(
            demand,
            newPrice: GameLogic.calculateProductPrice(
              normalPrice: product.normalPrice.toDouble(),
              lowestPrice: product.lowestPrice.toDouble(),
              highestPrice: product.highestPrice.toDouble(),
              currentPrice: demand.productPrice.toDouble(),
              demand: demand.demand,
              supply: demand.supply,
            ),
          ),
    ]);
  }
}

final sellToCityUseCaseProvider = Provider<SellToCity>(
  (ref) => SellToCity(ref),
);
