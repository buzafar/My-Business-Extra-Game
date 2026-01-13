import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:my_business_extra/components/base_padding.dart';
import 'package:my_business_extra/components/demand_widget.dart';
import 'package:my_business_extra/components/sectionTitleItem.dart';
import 'package:my_business_extra/components/warehouse_product_item.dart';
import 'package:my_business_extra/designs/values.dart';
import 'package:my_business_extra/features/sell_product/widgets/sold_snackbar.dart';
import 'package:my_business_extra/global_state_providers/demands_provider.dart';
import 'package:my_business_extra/global_state_providers/warehouse_provider.dart';
import 'package:my_business_extra/helpers/assets.dart';
import 'package:my_business_extra/helpers/helper_functions.dart';
import 'package:my_business_extra/helpers/sounds_sevice.dart';
import 'package:my_business_extra/models/demand.dart';
import 'package:my_business_extra/models/warehouse_product.dart';
import 'package:auto_route/auto_route.dart';
import 'package:my_business_extra/usecases/sell_to_city.dart';

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
  late FocusNode _focusNode;

  bool _buttonCooldown = false;

  @override
  void initState() {
    super.initState();

    // this is already done in build method but should put it here as well to prevent late initialization error in the coming lines about the _controller
    ref.read(warehouseProvider).value!.warehouseProducts.forEach((wp) {
      if (wp.productId == widget.warehouseProductId) {
        warehouseProduct = wp;
      }
    });

    _controller = TextEditingController(
      text: (warehouseProduct.quantity ~/ 2).toString(),
    );

    _focusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    //reacting to warehouse because while user is selling the product on this page, there might be more products of same kind added
    ref.watch(warehouseProvider).value!.warehouseProducts.forEach((wp) {
      if (wp.productId == widget.warehouseProductId) {
        warehouseProduct = wp;
      }
    });

    // reacting to demand/market in real time on this selling page
    ref.watch(demandsProvider).forEach((d) {
      if (d.productId == warehouseProduct.productId) {
        demand = d;
      }
    });

    return Scaffold(
      body: SafeArea(
        child: BasePadding(
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
              DemandWidget(demandId: demand.id),

              Gap(16),
              Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary,
                    width: 2,
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Quantity",
                                style: TextTheme.of(
                                  context,
                                ).bodySmall!.copyWith(
                                  color: Color(0xff212529).withOpacity(0.65),
                                ),
                              ),
                              Gap(4),
                              TextField(
                                controller: _controller,
                                focusNode: _focusNode,
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  RangeValueFormatter(
                                    1,
                                    warehouseProduct.quantity,
                                  ),
                                  EmptyFormatter(),
                                ],
                                onChanged: (value) {
                                  if (_controller.text.isEmpty) return;
                                  _controller.text = value;
                                  setState(() {});
                                },
                                decoration: InputDecoration(
                                  prefixIcon: GestureDetector(
                                    onTap: () {
                                      if (int.parse(_controller.text) <= 1) {
                                        return;
                                      }
                                      _controller.text =
                                          (int.parse(_controller.text) - 1)
                                              .toString();
                                      setState(() {});
                                    },
                                    child: Icon(Icons.minimize),
                                  ),
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      if (int.parse(_controller.text) >=
                                          warehouseProduct.quantity) {
                                        return;
                                      }
                                      _controller.text =
                                          (int.parse(_controller.text) + 1)
                                              .toString();
                                      setState(() {});
                                    },
                                    child: Icon(
                                      Icons.add,
                                      color:
                                          Theme.of(
                                            context,
                                          ).colorScheme.secondary,
                                    ),
                                  ),
                                  // border: OutlineInputBorder(
                                  //   borderSide: BorderSide(color: Colors.green),
                                  // ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        Flexible(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Profit",
                                style: TextTheme.of(
                                  context,
                                ).bodySmall!.copyWith(
                                  color: Color(0xff212529).withOpacity(0.65),
                                ),
                              ),
                              Gap(4),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "+ ${formatPrice(double.parse(_controller.text) * demand.productPrice)}",
                                    style: TextTheme.of(context).titleMedium!
                                        .copyWith(fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    "${formatNumber(int.parse(_controller.text))}  * ${formatPrice(demand.productPrice, showDollarSign: false)}",
                                    style: TextTheme.of(context).bodySmall,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    Gap(24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FilledButton(
                          onPressed:
                              _buttonCooldown
                                  ? null
                                  : () async {
                                    // do not continue if the entered quantity is zero
                                    if (_controller.text == "0") return;

                                    // unfocus the quantity textfield
                                    _focusNode.unfocus();

                                    // sell to the city
                                    ref
                                        .read(sellToCityUseCaseProvider)
                                        .run(
                                          warehouseProduct.copyWith(
                                            quantity: (int.parse(
                                              _controller.text,
                                            )),
                                          ),
                                        );

                                    // play sound
                                    SoundsSevice.playCashEarned();

                                    // show bottom snackbar
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: SoldSnackbar(
                                          price:
                                              double.parse(_controller.text) *
                                              demand.productPrice,
                                        ),
                                        behavior: SnackBarBehavior.floating,
                                        showCloseIcon: true,
                                        duration: Duration(seconds: 5),
                                        backgroundColor:
                                            Theme.of(
                                              context,
                                            ).colorScheme.onPrimaryFixedVariant,
                                      ),
                                    );

                                    // set textfield value to zero
                                    _controller.text = "0";
                                    setState(() {});

                                    // disable button for a moment, cooldown to prevent spamming
                                    _buttonCooldown = true;
                                    setState(() {});
                                    await Future.delayed(Duration(seconds: 3));
                                    _buttonCooldown = false;
                                    setState(() {});
                                  },
                          child: Text(r"💰 Sell to the city"),
                        ),
                      ],
                    ),
                  ],
                ),
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

class RangeValueFormatter extends TextInputFormatter {
  final int min;
  final int max;

  RangeValueFormatter(this.min, this.max);

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) return newValue;

    final value = int.tryParse(newValue.text);
    if (value == null || value < min || value > max) {
      return oldValue;
    }
    return newValue;
  }
}

class EmptyFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return TextEditingValue(text: "0");
    }

    if (oldValue.text == "0") {
      return TextEditingValue(text: newValue.text.substring(1));
    }

    return newValue;
  }
}
