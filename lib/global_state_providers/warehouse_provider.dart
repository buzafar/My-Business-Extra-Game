import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:my_business_extra/models/user.dart';
import 'package:my_business_extra/models/warehouse.dart';
import 'package:my_business_extra/models/warehouse_product.dart';
import 'package:my_business_extra/services/warehouse_service.dart';

import 'current_user_provider.dart';

final warehouseProvider = AsyncNotifierProvider<WarehouseNotifier, Warehouse>(
  WarehouseNotifier.new,
);

// to be able to see what product got added to the warehouse
// invoked when a new product is added warehouse
// we invoke different things in ui depending on what product is added
final warehouseNewProductAddedEventProvider = StateProvider<WarehouseProduct?>(
  (ref) => null,
);

class WarehouseNotifier extends AsyncNotifier<Warehouse> {
  @override
  Future<Warehouse> build() async {
    return ref
        .read(warehouseServiceProvider)
        .loadWarehouse(userId: ref.read(currentUserProvider).value!.id);
  }

  bool doesProductExist(WarehouseProduct product) {
    final bool exists = state.value!.warehouseProducts.any(
      (p) => p.productId == product.productId,
    );
    return exists;
  }

  /// Add or increase product quantity (IMMUTABLE)
  void addProductToWarehouse(WarehouseProduct newProduct) {
    final warehouse = state.value!;

    final bool exists = doesProductExist(newProduct);

    if (exists) {
      warehouse.warehouseProducts.forEach((e) {
        if (e.productId == newProduct.productId) {
          e.quantity += newProduct.quantity;
        }
      });
    } else {
      warehouse.warehouseProducts.add(newProduct);
    }

    ref.read(warehouseNewProductAddedEventProvider.notifier).state = newProduct;

    state = AsyncData(warehouse.copyWith());
  }
}
