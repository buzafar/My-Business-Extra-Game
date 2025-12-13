import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:my_business_extra/models/product.dart';
import 'package:my_business_extra/services/products_service.dart';

final productsProvider = StateNotifierProvider((ref) {
  return ProductsNotifier(ref);
});


class ProductsNotifier extends StateNotifier<AsyncValue<List<Product>>> {
  ProductsNotifier(this.ref) : super(AsyncLoading()) {
    loadProducts();
  }


  final Ref ref;


  Future<void> loadProducts() async {
    state = AsyncLoading();
    state = AsyncData(await ref.read(productsService).loadProducts());
  }

}
