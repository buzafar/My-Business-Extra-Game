import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:my_business_extra/helpers/assets.dart';
import 'package:my_business_extra/components/factory_product_item.dart';
import 'package:my_business_extra/components/warehouse_product_item.dart';
import 'package:my_business_extra/global_state_providers/factories_provider.dart';
import 'package:my_business_extra/global_state_providers/products_provider.dart';
import 'package:my_business_extra/global_state_providers/user_factories_provider.dart';
import 'package:my_business_extra/global_state_providers/warehouse_provider.dart';
import 'package:my_business_extra/models/user_factory.dart';
import 'package:my_business_extra/models/warehouse_product.dart';
import 'package:my_business_extra/usecases/calculate_and_produce.dart';
import 'package:my_business_extra/usecases/produce_in_time.dart';

import '../models/factory.dart';
import 'floating_bubble_widget.dart';

class Factoryitem extends ConsumerStatefulWidget {
  const Factoryitem({super.key, required this.userFactory});

  final UserFactory userFactory;

  @override
  ConsumerState<Factoryitem> createState() => _FactoryitemState();
}

class _FactoryitemState extends ConsumerState<Factoryitem> {
  late Factory factory;

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    final factories = ref.read(factoriesProvider).value!;

    factories.forEach((e) {
      if (widget.userFactory.factoryId == e.id) {
        factory = e;
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref
          .read(calculateAndProduceUseCaseProvider)
          .run(userFactory: widget.userFactory);

      _timer?.cancel();
      _timer = Timer.periodic(
        Duration(seconds: widget.userFactory.requiredSeconds),
        (_) {
          ref.read(produceInTimeUseCaseProvider).run(widget.userFactory);
        },
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final warehouse = ref.watch(warehouseProvider).value!;
    // final userFactories = ref.watch(userFactoriesProvider).value!;
    // final userFactories = ref.watch(factoryProductionProvider);
    return Container(
      padding: EdgeInsetsGeometry.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary,
          width: 2,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(factory.imageName, width: 90, height: 90),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  factory.name,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),

          Gap(8),

          Row(
            spacing: 12,
            children: [
              for (int i = 0; i < widget.userFactory.outputSlots; i++)
                FactoryProductItem(
                  productBeingProduced: ref
                      .read(productsProvider)
                      .value!
                      .firstWhere((e) => e.id == factory.productId),
                  userFactory: widget.userFactory,
                ),
            ],
          ),
        ],
      ),
    );
  }
}
