import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_business_extra/models/factory.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FactoryService {

  FactoryService(this.ref);

  final Ref ref;

  final supabase = Supabase.instance.client;

  Future<List<Factory>> loadFactories() async {
    final data = await supabase.from('factories').select();

    final List<Factory> factories = [];

    data.forEach((map) {
      factories.add(Factory.fromJson(map));
    });

    return factories;
  }

}



final factoryServiceProvider = Provider((ref) {
  return FactoryService(ref);
});