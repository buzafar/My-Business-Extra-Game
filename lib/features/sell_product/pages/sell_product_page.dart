import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_business_extra/components/demand_widget.dart';
import 'package:my_business_extra/components/warehouse_product_item.dart';
import 'package:my_business_extra/designs/values.dart';
import 'package:my_business_extra/global_state_providers/demands_provider.dart';
import 'package:my_business_extra/global_state_providers/warehouse_provider.dart';
import 'package:my_business_extra/models/demand.dart';
import 'package:my_business_extra/models/warehouse_product.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class SellProductPage extends ConsumerStatefulWidget {
  const SellProductPage({super.key, required this.warehouseProductId});

  final int warehouseProductId;

  @override
  ConsumerState<SellProductPage> createState() => _SellProductPageState();
}

class _SellProductPageState extends ConsumerState<SellProductPage> {
  late WarehouseProduct warehouseProduct;
  late Demand demand;

  @override
  void initState() {
    super.initState();
    print(widget.warehouseProductId);
    ref.read(warehouseProvider).value!.warehouseProducts.forEach((wp) {
      print(wp.id);
      if (wp.id == widget.warehouseProductId) {
        warehouseProduct = wp;
        print("IT IS FOUND");
      }
    });

    ref.read(demandsProvider).value!.forEach((d) {
      if (d.productId == warehouseProduct.productId) {
        demand = d;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.only(
            top: topPadding,
            left: screenPadding,
            right: screenPadding,
          ),
          child: Column(
            children: [
              WarehouseProductItem(warehouseProduct: warehouseProduct),
              DemandWidget(demand: demand),
            ],
          ),
        ),
      ),
    );
  }
}
