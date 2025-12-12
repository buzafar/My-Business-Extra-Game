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




  Future<void> createUserInTable() async {

    if (supabase.auth.currentUser == null) {
      print("createUserInTable() - currentUser is null");
      return ;
    }

    final user = supabase.auth.currentUser!;

    final response = await supabase.from('users').select().eq("user_id", user.id);

    // the user already has a row in the database, no need to create
    if (response.isNotEmpty) {
      print("createUserInTable() - user already has a row");
      return;
    }

    await supabase.from('users').insert({
      "email": user.email,
      "user_id": user.id,
      "balance": 45000
    });
  }

}



final userServiceProvider = Provider<UserService>((ref) {
  return UserService(ref);
});