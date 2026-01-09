import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:my_business_extra/components/floating_bubble_widget.dart';
import 'package:my_business_extra/global_state_providers/products_provider.dart';
import 'package:my_business_extra/global_state_providers/warehouse_provider.dart';
import 'package:my_business_extra/helpers/assets.dart';
import 'package:my_business_extra/helpers/helper_functions.dart';
import 'package:my_business_extra/models/warehouse_product.dart';

import 'package:auto_route/auto_route.dart';
import 'package:my_business_extra/router/app_router.gr.dart';

import '../models/product.dart';

class WarehouseProductItem extends ConsumerStatefulWidget {
  const WarehouseProductItem({super.key, required this.warehouseProduct});

  final WarehouseProduct warehouseProduct;

  @override
  ConsumerState<WarehouseProductItem> createState() =>
      _WarehouseProductItemState();
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

    // every time a new product is added to the warehouse, show +1 bubble text and lighten the box
    ref.listenManual(warehouseNewProductAddedEventProvider, (prev, next) {
      if (!mounted) return;
      if (next != null && next.productId == widget.warehouseProduct.productId) {
        showNewProductPopup(quantity: next.quantity);
        lighten = true;
        setState(() {});
        Timer(Duration(milliseconds: 200), () {
          lighten = false;
          setState(() {});
        });
      }
    });
  }

  bool lighten = false;

  final _productKey = GlobalKey();
  void showNewProductPopup({required int quantity}) {
    showPopup(
      context,
      position: getGlobalPosition(_productKey),
      widget: Text(
        "+ $quantity",
        style: TextTheme.of(
          context,
        ).bodyMedium!.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.router.push(
          SellProductRoute(
            warehouseProductId: widget.warehouseProduct.productId,
          ),
        );
      },
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border:
                  lighten ? Border.all(color: Colors.green, width: 1) : null,
              color: Theme.of(context).colorScheme.secondaryContainer,
            ),
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                Padding(
                  padding: EdgeInsetsGeometry.all(16),
                  child: Image.asset(
                    key: _productKey,
                    '${Assets.productImagesSource}${product.imageName}.png',
                    width: 40,
                    height: 40,
                  ),
                ),
                Padding(
                  padding: EdgeInsetsGeometry.all(2),
                  child: FittedBox(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Padding(
                        padding: EdgeInsetsGeometry.all(2),
                        child: Center(
                          child: Text(
                            "${formatNumber(widget.warehouseProduct.quantity)}",
                            style: Theme.of(
                              context,
                            ).textTheme.labelSmall!.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Gap(2),
          Text("${product.name}"),
        ],
      ),
    );
  }
}
