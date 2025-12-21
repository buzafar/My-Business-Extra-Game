import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../helpers/assets.dart';
import '../designs/values.dart';




class SectionTitleItem extends StatelessWidget {
  const SectionTitleItem({super.key, required this.title, required this.subtitle, required this.image});

  final String title;
  final String subtitle;
  final Image image;


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
                Text(title, style: TextTheme.of(context).titleSmall!.copyWith(fontWeight: FontWeight.bold),),
              ],
            ),

            Text(subtitle, style: TextTheme.of(context).bodySmall)
          ],

        ),

        Gap(4),
        Container(width: double.infinity, height: 2, color: Colors.green,),
        Gap(12),
      ],
    );
  }
}
