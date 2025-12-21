import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_business_extra/models/demand.dart';
import 'package:my_business_extra/services/demands_service.dart';

final demandsProvider = AsyncNotifierProvider<DemandsNotifier, List<Demand>>(
  () {
    return DemandsNotifier();
  },
);

class DemandsNotifier extends AsyncNotifier<List<Demand>> {
  @override
  FutureOr<List<Demand>> build() {
    return ref.read(demandsServiceProvider).loadDemands();
  }
}
