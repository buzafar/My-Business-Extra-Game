import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:my_business_extra/global_state_providers/current_user_provider.dart';
import 'package:my_business_extra/failure.dart';
import 'package:my_business_extra/services/auth_service.dart';
import 'package:my_business_extra/services/user_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';



final authControllerProvider = StateNotifierProvider<AuthController, AsyncValue<User?>>((ref) {
  return AuthController(ref);
});



class AuthController extends StateNotifier<AsyncValue<User?>> {
  AuthController(this.ref): super(AsyncData(null));

  final Ref ref;

  Future<void> signIn(String email, String password) async {
    state = const AsyncLoading();

    try {
      await ref.read(authServiceProvider).signIn(email, password);
      state = AsyncData(ref
          .read(authServiceProvider)
          .currentUser);
    } on AuthApiException catch (e, st) {
      state = AsyncError(GeneralFailure(), st);
    } catch (e, st) {
      state = AsyncError(GeneralFailure() as Failure, st);
    }
  }

  Future<void> signUp(String email, String password) async {
    state = const AsyncLoading();

    try {
      await ref.read(authServiceProvider).signUp(email, password);
      state = AsyncData(ref.read(authServiceProvider).currentUser);
    } on AuthApiException catch (e, st) {
      if (e.code == "user_already_exists") {
        print(e);
        state = AsyncError(EmailTakenFailure(), st);
      } else {
        state = AsyncError(GeneralFailure(), st);
      }

    } catch (e, st) {
      state = AsyncError(GeneralFailure() as Failure, st);
    }
  }


  Future<void> signOut() async {
    await ref.read(authServiceProvider).signOut();
    state = const AsyncData(null);
  }
}