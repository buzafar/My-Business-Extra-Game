import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:my_business_extra/global_state_providers/user_factories_provider.dart';
import 'package:my_business_extra/global_state_providers/warehouse_provider.dart';
import 'package:my_business_extra/helpers/assets.dart';
import 'package:my_business_extra/models/product.dart';
import 'package:my_business_extra/models/user_factory.dart';
import 'package:my_business_extra/router/app_router.gr.dart';

import '../helpers/helper_functions.dart';
import 'floating_bubble_widget.dart';

import 'package:auto_route/auto_route.dart';

class FactoryProductItem extends ConsumerStatefulWidget {
  const FactoryProductItem({
    super.key,
    required this.productBeingProduced,
    required this.userFactory,
  });

  final Product productBeingProduced;
  final UserFactory userFactory;

  @override
  ConsumerState<FactoryProductItem> createState() => _FactoryProductItemState();
}

class _FactoryProductItemState extends ConsumerState<FactoryProductItem> {
  Timer? timer;
  Timer? timer2;

  // progress bar values
  double progressBarWidth = 60;
  double progressBarFilled = 0;
  int progressSeconds = 10;

  // to get the position of container to invoke a bubble text there
  final factoryKey =
      GlobalKey(); // this is given to the container below as a key to get its position

  // to show how much it cost for the current product to produce
  void showCostPopup() {
    if (context.router.current.name != HomeRoute.name) {
      return;
    }

    final String cost = formatPrice(widget.userFactory.productionCost);
    showPopup(
      context,
      position: getGlobalPosition(factoryKey),

      widget: Container(
        padding: EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondaryFixedDim,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          "- $cost",
          style: TextTheme.of(
            context,
          ).bodySmall!.copyWith(color: Colors.red, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    progressSeconds = widget.userFactory.requiredSeconds;

    // progress bar logic
    timer?.cancel();
    timer = Timer.periodic(Duration(milliseconds: 10), (timer) {
      progressBarFilled += (progressBarWidth / progressSeconds) / 100;
      // if (progressBarFilled >= progressBarWidth) {
      //   progressBarFilled = 0;
      // }
      setState(() {});
    });

    timer2?.cancel();
    Timer.periodic(Duration(seconds: widget.userFactory.requiredSeconds), (_) {
      progressBarFilled = 0;
      showCostPopup();
      setState(() {});
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    timer2?.cancel();
    timer = null;
    timer2 = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return Container(
          key: factoryKey,
          width: progressBarWidth,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(8),
            // border: Border.all(color: Theme.of(context).colorScheme.primaryFixedDim)
          ),

          child: Column(
            children: [
              Container(
                width: progressBarWidth,
                decoration: BoxDecoration(
                  // borderRadius: BorderRadius.circular(8),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8),
                    topLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  ),
                  // border: Border.all(color: Theme.of(context).colorScheme.surfaceTint, width: 2),
                  color: Theme.of(context).colorScheme.secondaryContainer,
                ),
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Padding(
                      padding: EdgeInsetsGeometry.all(8),
                      child: Image.asset(
                        '${Assets.productImagesSource}${widget.productBeingProduced.imageName}.png',
                        width: 40,
                        height: 40,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsGeometry.all(2),
                      child: FittedBox(
                        child: Container(
                          decoration: BoxDecoration(
                            color:
                                Theme.of(
                                  context,
                                ).colorScheme.secondaryContainer,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Padding(
                            padding: EdgeInsetsGeometry.all(2),
                            child: Center(
                              child: Text(
                                "1",
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

              Gap(4),

              // progress bar using double containers
              Container(
                height: 8,
                width: progressBarWidth.toDouble(),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(4),
                    bottomRight: Radius.circular(4),
                  ),
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  border: Border.all(
                    color: Theme.of(context).colorScheme.surface,
                    width: 1,
                  ),
                ),
                child: Center(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      height: 8,
                      width: progressBarFilled.toDouble(),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        // borderRadius: BorderRadius.only(bottomLeft: Radius.circular(4)),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
