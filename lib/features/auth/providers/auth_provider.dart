import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:my_business_extra/services/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});


final authStateProvider = StreamProvider<User?>((ref) {
  final supabase = Supabase.instance.client;

  return supabase.auth.onAuthStateChange.map((event) => event.session?.user);
});



final authControllerProvider = StateNotifierProvider<AuthController, AsyncValue<User?>>((ref) {
  return AuthController(ref);
});



class AuthController extends StateNotifier<AsyncValue<User?>> {
  AuthController(this.ref): super(const AsyncLoading());

  final Ref ref;

  Future<void> signIn(String email, String password) async {
    state = const AsyncLoading();

    try {
      await ref.read(authServiceProvider).signIn(email, password);
      state = AsyncData(ref.read(authServiceProvider).currentUser);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> signUp(String email, String password) async {
    state = const AsyncLoading();

    try {
      await ref.read(authServiceProvider).signUp(email, password);
      state = AsyncData(ref.read(authServiceProvider).currentUser);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }


  Future<void> signOut() async {
    await ref.read(authServiceProvider).signOut();
    state = const AsyncData(null);
  }
}