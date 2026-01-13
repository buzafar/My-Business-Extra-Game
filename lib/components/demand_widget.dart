import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:my_business_extra/components/sectionTitleItem.dart';
import 'package:my_business_extra/designs/values.dart';
import 'package:my_business_extra/global_state_providers/demands_provider.dart';
import 'package:my_business_extra/global_state_providers/products_provider.dart';
import 'package:my_business_extra/helpers/assets.dart';
import 'package:my_business_extra/helpers/helper_functions.dart';
import 'package:my_business_extra/models/demand.dart';
import 'package:my_business_extra/models/product.dart';

class DemandWidget extends ConsumerStatefulWidget {
  const DemandWidget({
    super.key,
    required this.demandId,
    this.externalPadding = 0,
  });

  final int demandId;
  final double externalPadding;

  @override
  ConsumerState<DemandWidget> createState() => _DemandsWidgetState();
}

class _DemandsWidgetState extends ConsumerState<DemandWidget> {
  // the product of the demand
  late Product product;
  late Demand demand;

  //progressbar values
  final double imageSize = 30; // both width and height
  final double spaceBetween = 8;
  late double progressBarWidth = 10;
  double progressBarFilled = 0;

  @override
  void initState() {
    super.initState();

    ref.read(demandsProvider).forEach((d) {
      if (d.id == widget.demandId) {
        demand = d;
      }
    });

    ref.read(productsProvider).value!.forEach((p) {
      if (p.id == demand.productId) {
        product = p;
      }
    });

    SchedulerBinding.instance.addPostFrameCallback((_) {
      progressBarWidth =
          MediaQuery.of(context).size.width -
          (DesignValues.screenPadding * 2) -
          imageSize -
          spaceBetween -
          widget.externalPadding;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(demandsProvider).forEach((d) {
      if (d.id == widget.demandId) {
        demand = d;
      }
    });

    progressBarFilled = (demand.supply * progressBarWidth) / demand.demand;

    final num difference = demand.productPrice - product.normalPrice;

    return Row(
      children: [
        Image.asset(
          "${Assets.productImagesSource}${product.imageName}.png",
          width: imageSize,
          height: 30,
        ),
        Gap(spaceBetween),
        Column(
          children: [
            SizedBox(
              width: progressBarWidth,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "${formatPrice(demand.productPrice)}",
                          style: TextTheme.of(context).bodySmall,
                        ),
                        TextSpan(
                          text: " ",
                          style: TextTheme.of(context).labelSmall,
                        ),
                        TextSpan(
                          text: difference < 0 ? "-" : "+",
                          style: TextTheme.of(context).labelSmall!.copyWith(
                            color: difference < 0 ? Colors.red : Colors.green,
                          ),
                        ),
                        TextSpan(
                          text: "${demand.productPrice - product.normalPrice}",
                          style: TextTheme.of(context).labelSmall!.copyWith(
                            color: difference < 0 ? Colors.red : Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Row(
                    children: [
                      Text(
                        " ${((demand.supply / demand.demand) * 100).toStringAsFixed(2)}% filled - ${formatNumber(demand.supply, compact: true)}/${formatNumber(demand.demand, compact: true)}",
                        style: TextTheme.of(context).bodySmall,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Gap(4),

            Container(
              alignment: Alignment.centerLeft,
              width: progressBarWidth,
              height: 10,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Container(
                width: progressBarFilled,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.green,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
