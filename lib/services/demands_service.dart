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
}

final demandsServiceProvider = Provider<DemandsService>((ref) {
  return DemandsService(ref);
});
