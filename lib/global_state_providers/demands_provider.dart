import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_business_extra/models/demand.dart';
import 'package:my_business_extra/services/demands_service.dart';

final demandsProvider = NotifierProvider<DemandsNotifier, List<Demand>>(() {
  return DemandsNotifier();
});

class DemandsNotifier extends Notifier<List<Demand>> {
  StreamSubscription<List<Demand>>? _sub;

  @override
  List<Demand> build() {
    _listenToStream();
    return [];
  }

  void _listenToStream() {
    final service = ref.read(demandsServiceProvider);

    _sub = service.streamDemands().listen((demands) {
      state = demands;
    });

    ref.onDispose(() {
      _sub?.cancel();
    });
  }
}
