import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_business_extra/models/product.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductsService {
  ProductsService(this.ref);
  final Ref ref;

  final supabase = Supabase.instance.client;

  Future<List<Product>> loadProducts() async {
    final List<Map<String, dynamic>> data = await supabase.from('products').select();

    final List<Product> products = [];

    data.forEach((map) {
      products.add(Product.fromJson(map));
    });

    return products;
  }
}


final productsService = Provider<ProductsService>((ref) {
  return ProductsService(ref);
});