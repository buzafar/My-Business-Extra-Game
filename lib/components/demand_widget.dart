import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:my_business_extra/components/sectionTitleItem.dart';
import 'package:my_business_extra/global_state_providers/products_provider.dart';
import 'package:my_business_extra/helpers/assets.dart';
import 'package:my_business_extra/helpers/helper_functions.dart';
import 'package:my_business_extra/models/demand.dart';
import 'package:my_business_extra/models/product.dart';

class DemandWidget extends ConsumerStatefulWidget {
  const DemandWidget({super.key, required this.demand});

  final Demand demand;

  @override
  ConsumerState<DemandWidget> createState() => _DemandsWidgetState();
}

class _DemandsWidgetState extends ConsumerState<DemandWidget> {
  // the product of the demand
  late Product product;

  //progressbar values
  final double progressBarWidth = 400;
  double progressBarFilled = 0;

  @override
  void initState() {
    super.initState();

    ref.read(productsProvider).value!.forEach((p) {
      if (p.id == widget.demand.productId) {
        product = p;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    progressBarFilled =
        (widget.demand.supply * progressBarWidth) / widget.demand.demand;

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  "assets/images/${product.imageName}.png",
                  width: 30,
                  height: 30,
                ),

                Gap(8),

                Text(
                  "${formatPrice(widget.demand.productPrice)}",
                  style: TextTheme.of(context).bodySmall,
                ),
              ],
            ),

            Row(
              children: [
                Text(
                  " ${(widget.demand.supply / widget.demand.demand) * 100}% filled - ${formatNumber(widget.demand.supply)}/${formatNumber(widget.demand.demand)}",
                  style: TextTheme.of(context).bodySmall,
                ),
              ],
            ),
          ],
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
    );
  }
}
