import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_business_extra/models/factory.dart';
import 'package:my_business_extra/models/user_factory.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserFactoryService {
  UserFactoryService(this.ref);

  final Ref ref;

  final supabase = Supabase.instance.client;

  Future<List<UserFactory>> loadUserFactories({required int userId}) async {
    final data = await supabase
        .from('user_factories')
        .select()
        .eq('user_id', userId);

    final List<UserFactory> userFactories = [];

    data.forEach((map) {
      userFactories.add(UserFactory.fromJson(map));
    });

    return userFactories;
  }

  Future<void> setLastProducedTime(UserFactory userFactory) async {
    await supabase
        .from('user_factories')
        .update({"last_produced": DateTime.now().toUtc().toIso8601String()})
        .eq("id", userFactory.id);
  }
}

final userFactoryServiceProvider = Provider((ref) {
  return UserFactoryService(ref);
});
