import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:my_business_extra/global_state_providers/products_provider.dart';
import 'package:my_business_extra/global_state_providers/warehouse_provider.dart';
import 'package:my_business_extra/models/warehouse_product.dart';

import '../models/product.dart';





class WarehouseProductItem extends ConsumerStatefulWidget {
  const WarehouseProductItem({super.key, required this.warehouseProduct});

  final WarehouseProduct warehouseProduct;

  @override
  ConsumerState<WarehouseProductItem> createState() => _WarehouseProductItemState();
}

class _WarehouseProductItemState extends ConsumerState<WarehouseProductItem> {

  late Product product;

  @override
  void initState() {
    super.initState();

    final products = ref.read(productsProvider).value!;

    products.forEach((e) {
      if (widget.warehouseProduct.productId == e.id) {
        product = e;
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            // border: Border.all(color: Theme.of(context).colorScheme.surfaceTint, width: 2),
            color: Theme.of(context).colorScheme.secondaryContainer
          ),
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                Padding(
                  padding: EdgeInsetsGeometry.all(16),
                    child: Image.asset('assets/images/${product.imageName}.png', width: 40, height: 40,)),
                Padding(
                  padding: EdgeInsetsGeometry.all(2),
                  child: FittedBox(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        borderRadius: BorderRadius.circular(4)
                      ),
                      child: Padding(
                        padding: EdgeInsetsGeometry.all(2),
                          child: Center(child: Text("${widget.warehouseProduct.quantity}", style: Theme.of(context).textTheme.labelSmall!.copyWith(color: Colors.black, fontWeight: FontWeight.bold),))),
                    ),
                  ),
                )
              ],
            )
        ),
        Gap(2),
        Text("${product.name}")
      ],
    );
  }
}
