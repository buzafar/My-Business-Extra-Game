import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_business_extra/global_state_providers/current_user_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:my_business_extra/models/user.dart';

class UserService {

  UserService(this.ref);
  final Ref ref;

  final supabase = Supabase.instance.client;


  Future<UserModel> getUser() async {
    final data = await supabase.from('users').select().eq('user_id', supabase.auth.currentUser!.id).single();
    print(data);
    return UserModel.fromJson(data);
  }



  Future<void> increaseBalance({required double newBalance}) async {
    final currentUser = ref.read(currentUserProvider).value;
    await supabase.from('users').update({"balance":  newBalance}).eq('user_id', supabase.auth.currentUser!.id);
  }




  Future<int> createUserInTable(User user) async {


    final response = await supabase.from('users').select().eq("user_id", user.id).single();

    // the user already has a row in the database, no need to create
    if (response.isNotEmpty) {
      print("createUserInTable() - user already has a row");
      return response['id'];
    }

    // create a row in the data for the user
    await supabase.from('users').insert({
      "email": user.email,
      "user_id": user.id,
      "balance": 45000
    });

    // load that created row
    final createdUserRepsonse = await supabase.from('users').select().eq('user_id', user.id).single();

    return createdUserRepsonse['id'];
  }

  Future<void> createWarehouseForUser(int userId) async {

    final response = await supabase.from('warehouses').select().eq('user_id', userId);

    // user already has a warehouse in the database, no need to create
    if (response.isNotEmpty) {
      return;
    }

    await supabase.from('warehouses').insert({
      "user_id": userId,
      "capacity": 100
    });
  }



  Future<void> createFactoryForUser(int userId) async {
    final response = await supabase.from('user_factories').select().eq('user_id', userId);

    if (response.isNotEmpty) {
      return;
    }

    await supabase.from("user_factories").insert({
      "user_id": userId,
      "factory_id": 1
    });

  }


}



final userServiceProvider = Provider<UserService>((ref) {
  return UserService(ref);
});