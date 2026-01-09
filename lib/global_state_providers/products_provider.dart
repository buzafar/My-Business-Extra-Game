import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:my_business_extra/models/product.dart';
import 'package:my_business_extra/services/products_service.dart';

final productsProvider = AsyncNotifierProvider<ProductsNotifier, List<Product>>(
  () => ProductsNotifier(),
);

// The notifier
class ProductsNotifier extends AsyncNotifier<List<Product>> {
  @override
  Future<List<Product>> build() async {
    // This is automatically called once when the provider is first read
    return ref.read(productsService).loadProducts();
  }
}
