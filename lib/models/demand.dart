// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Demand {
  final int id;
  final String createdAt;
  final int productId;
  final int demand;
  int supply;
  num productPrice;

  Demand({
    required this.id,
    required this.createdAt,
    required this.productId,
    required this.demand,
    required this.supply,
    required this.productPrice,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'createdAt': createdAt,
      'productId': productId,
      'demand': demand,
      'supply': supply,
      'productPrice': productPrice,
    };
  }

  factory Demand.fromMap(Map<String, dynamic> map) {
    return Demand(
      id: map['id'] as int,
      createdAt: map['created_at'] as String,
      productId: map['product_id'] as int,
      demand: map['demand'] as int,
      supply: map['supply'] as int,
      productPrice: map['product_price'] as num,
    );
  }

  String toJson() => json.encode(toMap());

  factory Demand.fromJson(String source) =>
      Demand.fromMap(json.decode(source) as Map<String, dynamic>);

  Demand copyWith({
    int? id,
    String? createdAt,
    int? productId,
    int? demand,
    int? supply,
    double? productPrice,
  }) {
    return Demand(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      productId: productId ?? this.productId,
      demand: demand ?? this.demand,
      supply: supply ?? this.supply,
      productPrice: productPrice ?? this.productPrice,
    );
  }
}
