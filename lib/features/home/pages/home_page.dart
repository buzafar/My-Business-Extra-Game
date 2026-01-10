import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:auto_route/auto_route.dart';
import 'package:gap/gap.dart';
import 'package:my_business_extra/components/demand_widget.dart';
import 'package:my_business_extra/components/factory_product_item.dart';
import 'package:my_business_extra/components/warehouse_widget.dart';
import 'package:my_business_extra/global_state_providers/demands_provider.dart';
import 'package:my_business_extra/helpers/assets.dart';
import 'package:my_business_extra/components/factory_item.dart';
import 'package:my_business_extra/components/warehouse_product_item.dart';
import 'package:my_business_extra/components/sectionTitleItem.dart';
import 'package:my_business_extra/designs/values.dart';
import 'package:my_business_extra/global_state_providers/current_user_provider.dart';
import 'package:my_business_extra/components/balance.dart';
import 'package:my_business_extra/global_state_providers/factories_provider.dart';
import 'package:my_business_extra/global_state_providers/products_provider.dart';
import 'package:my_business_extra/global_state_providers/user_factories_provider.dart';
import 'package:my_business_extra/global_state_providers/warehouse_provider.dart';
import 'package:my_business_extra/models/warehouse_product.dart';
import 'package:slide_countdown/slide_countdown.dart';

import '../../../models/product.dart';
import '../../../router/app_router.gr.dart';
import '../../auth/providers/auth_provider.dart';

@RoutePage()
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userFactories = ref.watch(userFactoriesProvider).value!;
    final demands = ref.watch(demandsProvider);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.only(top: topPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsGeometry.all(screenPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SectionTitleItem(title: "Factory", subtitle: "${warehouse.warehouseProducts.length}/${warehouse.capacity}", image: Image.asset(Assets.warehouseImage, width: 25, height: 25,)),
                    Factoryitem(userFactory: userFactories[0]),
                    // Factoryitem(userFactory: userFactories[0]),
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsetsGeometry.all(screenPadding),
                child: WarehouseWidget(),
              ),

              Padding(
                padding: EdgeInsetsGeometry.all(screenPadding),
                child: Column(
                  children: [
                    SectionTitleItem(
                      title: "City Demand",
                      subtitle: "",
                      image: Image.asset(
                        Assets.cityImage,
                        width: 25,
                        height: 25,
                      ),
                    ),

                    Row(
                      children: [
                        Text("The city will consume the supply in "),
                        SlideCountdown(
                          duration: Duration(days: 2),
                          decoration: BoxDecoration(color: Colors.green),
                        ),
                      ],
                    ),

                    SizedBox(
                      width: 30,
                      height: 30,
                      child: Image.asset(Assets.liveImage),
                    ),

                    for (var demand in demands)
                      Padding(
                        padding: EdgeInsetsGeometry.only(bottom: 16),
                        child: DemandWidget(demandId: demand.id),
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
