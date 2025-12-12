class Product {

  final int id;
  final String createdAt;
  final String name;
  final double normalPrice;
  final double lowestPrice;
  final double highestPrice;

  Product({required this.id, required this.createdAt, required this.name, required this.normalPrice, required this.lowestPrice, required this.highestPrice});

  factory Product.fromJson(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      createdAt: map['created_at'],
      name: map['name'],
      normalPrice: map['normal_price'],
      lowestPrice: map['lowest_price'],
      highestPrice: map['highest_price']
    );
  }


}