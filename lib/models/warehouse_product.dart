import 'package:my_business_extra/models/product.dart';
import 'package:my_business_extra/models/warehouse.dart';

class WarehouseProduct extends BaseProduct {

  final int? id;
  final DateTime? createdAt;
  final int productId;
  final int warehouseId;
  int quantity;

  WarehouseProduct({this.id, this.createdAt, required this.productId, required this.warehouseId, required this.quantity});


  factory WarehouseProduct.fromJson(Map<String, dynamic> map) {
    return WarehouseProduct(
      id: map['id'],
      createdAt: DateTime.parse(map['created_at']),
      productId: map['product_id'],
      warehouseId: map['warehouse_id'],
      quantity: map['quantity']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      // 'id': id,
      // 'createdAt': createdAt.toUtc().toIso8601String(),
      'product_id': productId,
      'warehouse_id': warehouseId,
      'quantity': quantity
    };
  }


}