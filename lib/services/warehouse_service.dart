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
    final warehouseData = await supabase.from('warehouses').select().eq('user_id', userId).single();
    
    // load warehouse product that belong to the loaded warehouse
    final warehouseProductsData = await supabase.from('warehouse_products').select().eq('warehouse_id', warehouseData['id']);

    final Warehouse warehouse = Warehouse.fromJson(warehouseData);
    warehouse.warehouseProducts = warehouseProductsData.map((data) => WarehouseProduct.fromJson(data)).toList();

    return warehouse;
    
  }


  Future<void> addToProductToWarehouse(WarehouseProduct warehouseProduct, {required bool productAlreadyExists, required int initialQuantity}) async {
    if (productAlreadyExists) {
      await supabase.from("warehouse_products").update({"quantity": initialQuantity + warehouseProduct.quantity}).eq("product_id", warehouseProduct.productId);
      return;
    }
    await supabase.from('warehouse_products').insert(warehouseProduct.toMap());
  }

}


final warehouseServiceProvider = Provider<WarehouseService>((ref) {
  return WarehouseService(ref);
});