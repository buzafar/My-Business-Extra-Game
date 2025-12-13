import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:my_business_extra/models/user.dart';
import 'package:my_business_extra/models/warehouse.dart';
import 'package:my_business_extra/models/warehouse_product.dart';
import 'package:my_business_extra/services/warehouse_service.dart';

import 'current_user_provider.dart';

final warehouseProvider = StateNotifierProvider((ref) {
  final userAsync = ref.watch(currentUserProvider); // load warehouse only when the user is fully loaded, because loading warehouse depends on user
  return WarehouseNotifier(ref, userAsync);
});


class WarehouseNotifier extends StateNotifier<AsyncValue<Warehouse>> {
  WarehouseNotifier(this.ref, this.userAsync) : super(AsyncLoading()) {
    userAsync.whenData((user) {
      loadWarehouse(user.id);
    }); // try to load warehouse of the user only when user data has been loaded

  }

  final Ref ref;
  final AsyncValue<UserModel> userAsync;

  Future<void> loadWarehouse(int userId) async {
    state = AsyncLoading();
    state = AsyncData(await ref.read(warehouseServiceProvider).loadWarehouse(userId: userId));
    print(1);
  }

  Future<void> addProductToWarehouse(WarehouseProduct newWarehouseProduct) async {
    int initialQuantity = 0;

    bool productAlreadyExists = false; // to know whether to add the product as a new instance or increase the quantity of already existing product
    state.value!.warehouseProducts.forEach((e) {

      if (e.productId == newWarehouseProduct.productId) {
        productAlreadyExists = true;
        e.quantity += newWarehouseProduct.quantity;
        initialQuantity = e.quantity;
      }
    });


    if (productAlreadyExists == false) {
      state.value!.warehouseProducts.add(newWarehouseProduct);
    }

    final updatedWarehouse = state.value!.copyWith(warehouseProducts: state.value!.warehouseProducts);

    state = AsyncData(updatedWarehouse);

    await ref.read(warehouseServiceProvider).addToProductToWarehouse(newWarehouseProduct, productAlreadyExists: productAlreadyExists, initialQuantity: initialQuantity);
  }


}