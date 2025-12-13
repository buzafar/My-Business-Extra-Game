import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:auto_route/auto_route.dart';
import 'package:gap/gap.dart';
import 'package:my_business_extra/assets.dart';
import 'package:my_business_extra/components/factoryItem.dart';
import 'package:my_business_extra/components/productItem.dart';
import 'package:my_business_extra/components/sectionTitleItem.dart';
import 'package:my_business_extra/designs/values.dart';
import 'package:my_business_extra/global_state_providers/current_user_provider.dart';
import 'package:my_business_extra/components/balance.dart';
import 'package:my_business_extra/global_state_providers/factories_provider.dart';
import 'package:my_business_extra/global_state_providers/products_provider.dart';
import 'package:my_business_extra/global_state_providers/user_factories_provider.dart';
import 'package:my_business_extra/global_state_providers/warehouse_provider.dart';
import 'package:my_business_extra/models/warehouse_product.dart';

import '../../../models/product.dart';
import '../../../router/app_router.gr.dart';
import '../../auth/providers/auth_provider.dart';

@RoutePage()
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final user = ref.watch(authStateProvider).value;
    final userModel = ref.watch(currentUserProvider).value;
    final List<Product>? products = ref.watch(productsProvider).value;
    final warehouse = ref.watch(warehouseProvider).value!;
    final userFactories = ref.watch(userFactoriesProvider).value!;


    return Scaffold(

      appBar: AppBar(
        toolbarHeight: 40,
        title:  Balance(balance: userModel!.balance),
        centerTitle: false,
        backgroundColor: Theme.of(context).colorScheme.surfaceTint,
         ),

      body:  SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [


            Padding(
            padding: EdgeInsetsGeometry.all(screenPadding),
            child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // SectionTitleItem(title: "Factory", subtitle: "${warehouse.warehouseProducts.length}/${warehouse.capacity}", image: Image.asset(Assets.warehouseImage, width: 25, height: 25,)),
                  Factoryitem(userFactory: userFactories[0],),
              ],
            ),
            ),


              Padding(
                padding: EdgeInsetsGeometry.all(screenPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SectionTitleItem(title: "Warehouse", subtitle: "${warehouse.warehouseProducts.length}/${warehouse.capacity}", image: Image.asset(Assets.warehouseImage, width: 25, height: 25,)),
                    Container(
                      height: 400,
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
                          WarehouseProductItem(warehouseProduct: product)
                      ],),
                    ),
                  ],
                ),
              ),

          ],
        ),
      ),
    );
  }
}