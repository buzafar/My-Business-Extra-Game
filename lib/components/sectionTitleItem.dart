import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../helpers/assets.dart';
import '../designs/values.dart';

class SectionTitleItem extends StatelessWidget {
  const SectionTitleItem({
    super.key,
    required this.title,
    this.subtitle,
    required this.image,
    this.subtitleWidget,
  });

  final String title;
  final String? subtitle;
  final Image image;
  final Widget? subtitleWidget;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Image.asset(Assets.warehouseImage, width: 25, height: 25,),
                image,
                Gap(8),
                Text(
                  title,
                  style: TextTheme.of(
                    context,
                  ).labelMedium!.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),

            if (subtitleWidget != null) subtitleWidget!,

            if (subtitle != null)
              Text(subtitle!, style: TextTheme.of(context).bodySmall),
          ],
        ),

        Gap(4),

        Container(
          width: double.infinity,
          height: 2,
          color: Theme.of(context).colorScheme.secondaryContainer,
        ),
      ],
    );
  }
}
