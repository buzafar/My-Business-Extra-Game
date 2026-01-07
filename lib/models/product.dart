class BaseProduct {

}


class Product extends BaseProduct {

  final int id;
  final String createdAt;
  final String name;
  final num normalPrice;
  final num lowestPrice;
  final num highestPrice;
  final String imageName;

  Product({required this.id, required this.createdAt, required this.name, required this.normalPrice, required this.lowestPrice, required this.highestPrice, required this.imageName});

  factory Product.fromJson(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      createdAt: map['created_at'],
      name: map['name'],
      normalPrice: map['normal_price'],
      lowestPrice: map['lowest_price'],
      highestPrice: map['highest_price'],
      imageName: map['image_name'],
    );
  }

  


}