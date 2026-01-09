import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_business_extra/global_state_providers/current_user_provider.dart';
import 'package:my_business_extra/models/warehouse.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/warehouse_product.dart';

class WarehouseService {
  WarehouseService(this.ref);

  final Ref ref;

  final supabase = Supabase.instance.client;

  Future<Warehouse> loadWarehouse({required int userId}) async {
    // final currentUser = ref.read(currentUserProvider).value!;

    // load the warehouse data of the user;
    final warehouseData =
        await supabase
            .from('warehouses')
            .select()
            .eq('user_id', userId)
            .single();

    // load warehouse product that belong to the loaded warehouse
    final warehouseProductsData = await supabase
        .from('warehouse_products')
        .select()
        .eq('warehouse_id', warehouseData['id']);

    final Warehouse warehouse = Warehouse.fromJson(warehouseData);
    warehouse.warehouseProducts =
        warehouseProductsData
            .map((data) => WarehouseProduct.fromJson(data))
            .toList();

    return warehouse;
  }

  Future<ProductCheck> doesProductExist(WarehouseProduct product) async {
    final warehouseProductsData = await supabase
        .from('warehouse_products')
        .select()
        .eq('warehouse_id', product.warehouseId)
        .eq('product_id', product.productId);

    return ProductCheck(
      exists: warehouseProductsData.isNotEmpty,
      quantity:
          warehouseProductsData.isNotEmpty
              ? warehouseProductsData[0]['quantity']
              : 0,
    );
  }

  Future<void> addProductToWarehouse(WarehouseProduct warehouseProduct) async {
    final productCheck = await doesProductExist(warehouseProduct);
    if (productCheck.exists) {
      await supabase
          .from("warehouse_products")
          .update({
            "quantity": productCheck.quantity + warehouseProduct.quantity,
          })
          .eq("warehouse_id", warehouseProduct.warehouseId)
          .eq("product_id", warehouseProduct.productId);
      return;
    }
    await supabase.from('warehouse_products').insert(warehouseProduct.toMap());
  }

  Future<void> removeProductFromWarehouse(
    WarehouseProduct warehouseProduct,
  ) async {
    final productCheck = await doesProductExist(warehouseProduct);
    if (!productCheck.exists) return;

    await supabase
        .from('warehouse_products')
        .update({"quantity": productCheck.quantity - warehouseProduct.quantity})
        .eq("warehouse_id", warehouseProduct.warehouseId)
        .eq("product_id", warehouseProduct.productId);
  }
}

final warehouseServiceProvider = Provider<WarehouseService>((ref) {
  return WarehouseService(ref);
});

// This is used in doesProductExist() function
// to check if the product is already in the warehouse and return the quantity
class ProductCheck {
  final bool exists;
  final int quantity;
  ProductCheck({required this.exists, required this.quantity});
}
