class Factory {
  final int id;
  final String createdAt;
  final String name;
  final String imageName;
  final int productId;

  Factory({ required this.id, required this.createdAt, required this.name, required this.imageName, required this.productId});

  factory Factory.fromJson(Map<String, dynamic> map) {
    return Factory(
      id: map['id'],
      createdAt: map['created_at'],
      name: map['name'],
      imageName: map['image_name'],
      productId: map['product_id']
    );
  }



}