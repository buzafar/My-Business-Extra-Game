import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:my_business_extra/components/demand_widget.dart';
import 'package:my_business_extra/components/sectionTitleItem.dart';
import 'package:my_business_extra/components/warehouse_product_item.dart';
import 'package:my_business_extra/designs/values.dart';
import 'package:my_business_extra/global_state_providers/demands_provider.dart';
import 'package:my_business_extra/global_state_providers/warehouse_provider.dart';
import 'package:my_business_extra/helpers/assets.dart';
import 'package:my_business_extra/helpers/helper_functions.dart';
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

  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    ref.read(warehouseProvider).value!.warehouseProducts.forEach((wp) {
      if (wp.id == widget.warehouseProductId) {
        warehouseProduct = wp;
      }
    });

    ref.read(demandsProvider).value!.forEach((d) {
      if (d.productId == warehouseProduct.productId) {
        demand = d;
      }
    });

    _controller = TextEditingController(
      text: (warehouseProduct.quantity ~/ 2).toString(),
    );
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
              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () {
                    context.router.maybePop();
                  },
                  child: Icon(Icons.arrow_back, color: Colors.black),
                ),
              ),
              Gap(16),
              WarehouseProductItem(warehouseProduct: warehouseProduct),
              Gap(16),
              SectionTitleItem(
                subtitle: "",
                title: "City demand",
                image: Image.asset(Assets.cityImage, width: 30, height: 30),
              ),
              Padding(
                padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
                child: DemandWidget(demand: demand),
              ),

              Gap(32),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    flex: 1,
                    child: TextField(
                      controller: _controller,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        if (int.parse(value) <= 0) {
                          
                        }
                      },
                      decoration: InputDecoration(
                        prefixIcon: GestureDetector(
                          onTap: () {
                            // if (int.parse(_controller.text) == 0) {
                            //   return;
                            // }
                            _controller.text =
                                (int.parse(_controller.text) - 1).toString();
                            setState(() {});
                          },
                          child: Icon(Icons.minimize),
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            _controller.text =
                                (int.parse(_controller.text) + 1).toString();
                            setState(() {});
                          },
                          child: Icon(
                            Icons.add,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        // border: OutlineInputBorder(
                        //   borderSide: BorderSide(color: Colors.green),
                        // ),
                      ),
                    ),
                  ),

                  Flexible(
                    flex: 1,
                    child: Text(
                      formatPrice(
                        int.parse(_controller.text) * demand.productPrice,
                      ).toString(),
                      style: TextTheme.of(context).titleMedium,
                    ),
                  ),
                ],
              ),
              Gap(8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: FilledButton(
                      onPressed: () {},
                      child: Text(r"$ Sell to the city"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _plusMinusIconButton(
  BuildContext context,
  bool plus, {
  required Function onPressed,
}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: Theme.of(context).colorScheme.primary,
    ),
    child: IconButton(
      onPressed: () {
        onPressed();
      },
      icon: Text(
        plus ? "+" : "-",
        style: Theme.of(
          context,
        ).textTheme.titleLarge!.copyWith(color: Colors.white),
      ),
      color: Colors.white,
    ),
  );
}
