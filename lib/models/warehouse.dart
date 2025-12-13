import 'package:my_business_extra/models/warehouse_product.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Warehouse {

  final int id;
  final String createdAt;
  final int userId;
  int capacity;
  List<WarehouseProduct> warehouseProducts;


  Warehouse({required this.id, required this.createdAt, required this.userId, required this.capacity, this.warehouseProducts=const []});

  factory Warehouse.fromJson(Map<String, dynamic> map) {
    return Warehouse(
      id: map['id'],
      createdAt: map['created_at'],
      userId: map['user_id'],
      capacity: map['capacity'],
    );
  }


  Warehouse copyWith({
    int? id,
    String? createdAt,
    int? userId,
    int? capacity,
    List<WarehouseProduct>? warehouseProducts
  }) {
    return Warehouse(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      userId: userId ?? this.userId,
      capacity: capacity ?? this.capacity,
      warehouseProducts: warehouseProducts ?? this.warehouseProducts
    );
  }



}