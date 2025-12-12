import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_business_extra/services/user_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


class AuthService {

  AuthService(this.ref);
  final Ref ref;

  final supabase = Supabase.instance.client;

  Future<AuthResponse> signIn(String email, String password) async {
    final authResponse = await supabase.auth.signInWithPassword(email: email, password: password);
    await ref.read(userServiceProvider).createUserInTable();
    return authResponse;
  }

  Future<AuthResponse> signUp(String email, String password) async {
    return await supabase.auth.signUp(email: email, password: password);
  }

  Future<void> signOut() async {
    await supabase.auth.signOut();
  }

  User? get currentUser => supabase.auth.currentUser;

}


final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService(ref);
});
