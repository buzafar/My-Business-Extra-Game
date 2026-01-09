import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_business_extra/models/demand.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DemandsService {
  final Ref ref;
  DemandsService(this.ref);

  final supabase = Supabase.instance.client;

  Future<List<Demand>> loadDemands() async {
    try {
      final response = await supabase.from("demands").select();

      final List<Demand> demands = [];

      response.forEach((map) {
        demands.add(Demand.fromMap(map));
      });

      return demands;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Stream<List<Demand>> streamDemands() {
    return supabase
        .from('demands')
        .stream(primaryKey: ['id'])
        .map((data) => data.map((map) => Demand.fromMap(map)).toList());
  }

  Future<void> increaseSupply(Demand demand, {required int newAmount}) async {
    await supabase
        .from('demands')
        .update({"supply": newAmount})
        .eq('id', demand.id);
  }

  Future<void> newPrice(Demand demand, {required double newPrice}) async {
    await supabase
        .from('demands')
        .update({"product_price": newPrice})
        .eq("id", demand.id);
  }
}

final demandsServiceProvider = Provider<DemandsService>((ref) {
  return DemandsService(ref);
});
