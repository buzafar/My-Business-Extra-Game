import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:my_business_extra/assets.dart';
import 'package:my_business_extra/global_state_providers/factories_provider.dart';
import 'package:my_business_extra/global_state_providers/user_factories_provider.dart';
import 'package:my_business_extra/global_state_providers/warehouse_provider.dart';
import 'package:my_business_extra/models/user_factory.dart';
import 'package:my_business_extra/models/warehouse_product.dart';

import '../models/factory.dart';



class Factoryitem extends ConsumerStatefulWidget {
  const Factoryitem({super.key, required this.userFactory});

  final UserFactory userFactory;

  @override
  ConsumerState<Factoryitem> createState() => _FactoryitemState();
}

class _FactoryitemState extends ConsumerState<Factoryitem> {

  late Factory factory;

  Future<void> calculateAndProduce() async  {
    print("calculateAndProduce");
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(userFactoriesProvider.notifier).calculateAndProduce(widget.userFactory);
    });
  }


  Future<void> produceInTime() async {
    print("produceInTime");

    await ref.read(userFactoriesProvider.notifier).produceInTime(widget.userFactory);
  }




  @override
  void initState() {
    super.initState();

    final factories = ref.read(factoriesProvider).value!;

    factories.forEach((e) {
      if (widget.userFactory.factoryId == e.id) {
        factory = e;
      }
    });

    calculateAndProduce();

    Timer.periodic( Duration(seconds: widget.userFactory.requiredSeconds), (_) {
      produceInTime();
    });

  }


  @override
  Widget build(BuildContext context) {
    final userFactories = ref.watch(userFactoriesProvider);
    return Container(
      padding: EdgeInsetsGeometry.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Theme.of(context).colorScheme.primary, width: 2)
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(factory.imageName, width: 90, height: 90,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(4)
                ),
                  child: Text(factory.name, style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold, color: Colors.white),)),

            ],
          ),

          Gap(8),

          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Theme.of(context).colorScheme.primaryFixedDim)
            ),
          )
        ],
      ),
    );
  }
}
