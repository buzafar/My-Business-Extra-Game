import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_business_extra/components/sectionTitleItem.dart';
import 'package:my_business_extra/components/warehouse_product_item.dart';
import 'package:my_business_extra/global_state_providers/warehouse_provider.dart';
import 'package:my_business_extra/helpers/assets.dart';
import 'package:my_business_extra/models/warehouse_product.dart';

class WarehouseWidget extends ConsumerWidget {
  const WarehouseWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final warehouse = ref.watch(warehouseProvider).value!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitleItem(
          title: "Warehouse",
          subtitle:
              "${warehouse.warehouseProducts.length}/${warehouse.capacity}",
          image: Image.asset(Assets.warehouseImage, width: 25, height: 25),
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsetsGeometry.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            // border: Border.all(color: Theme.of(context).colorScheme.primaryContainer, width: 2),
            // borderRadius: BorderRadius.circular(8),
            // image: DecorationImage(image: AssetImage('assets/images/warehouse.jpg'), fit: BoxFit.fill)
          ),
          child: Wrap(
            spacing: 8,
            children: [
              for (WarehouseProduct product in warehouse.warehouseProducts)
                WarehouseProductItem(warehouseProduct: product),
            ],
          ),
        ),
      ],
    );
  }
}
