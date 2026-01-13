import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:my_business_extra/components/base_padding.dart';
import 'package:my_business_extra/components/demand_widget.dart';
import 'package:my_business_extra/components/sectionTitleItem.dart';
import 'package:my_business_extra/global_state_providers/demands_provider.dart';
import 'package:my_business_extra/helpers/assets.dart';
import 'package:my_business_extra/helpers/helper_functions.dart';

@RoutePage()
class CityMarketPage extends ConsumerWidget {
  const CityMarketPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final demands = ref.watch(demandsProvider);
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(Assets.cityBackgroundImage)),
        ),
        child: SafeArea(
          child: BasePadding(
            child: Column(
              children: [
                Gap(16),
                Row(
                  children: [
                    SizedBox(
                      width: 50,
                      height: 50,
                      child: Image.asset(Assets.cityImage),
                    ),
                    Gap(16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Melburg City",
                          style:
                              Theme.of(
                                context,
                              ).textTheme.headlineSmall!.copyWith(),
                        ),
                        Row(
                          children: [
                            Text(
                              "Population: ${formatNumber(350000)}",
                              style:
                                  Theme.of(
                                    context,
                                  ).textTheme.bodyMedium!.copyWith(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),

                Gap(16),

                Container(
                  width: double.infinity,
                  height: 300,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      SectionTitleItem(
                        title: "City Demand and Supply",

                        image: Image.asset(
                          Assets.cityImage,
                          width: 20,
                          height: 20,
                        ),
                        subtitleWidget: Row(
                          children: [
                            Text(
                              "Live",
                              style: TextTheme.of(
                                context,
                              ).titleSmall!.copyWith(color: Colors.red),
                            ),
                            Gap(4),
                            Icon(Icons.live_tv, size: 18, color: Colors.red),
                          ],
                        ),
                      ),

                      Gap(16),
                      for (var demand in demands)
                        Padding(
                          padding: EdgeInsetsGeometry.only(bottom: 16),
                          child: DemandWidget(
                            demandId: demand.id,
                            externalPadding: 32,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
