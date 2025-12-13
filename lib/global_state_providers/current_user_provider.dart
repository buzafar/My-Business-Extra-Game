import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:my_business_extra/services/user_service.dart';
import '../models/user.dart';

final currentUserProvider = StateNotifierProvider<CurrentUserStateNotifier, AsyncValue<UserModel>>((ref) {
  return CurrentUserStateNotifier(ref);
});


class CurrentUserStateNotifier extends StateNotifier<AsyncValue<UserModel>> {

  CurrentUserStateNotifier(this.ref) : super(AsyncLoading()) {
    loadUser();
  }


  final Ref ref;

  Future<void> loadUser() async {
    state = AsyncLoading();
    state = AsyncData(await ref.read(userServiceProvider).getUser());
  }


  Future<void> increaseBalance() async {
    final currentUser = state.value;
    if (currentUser == null) return;

    state = AsyncData(currentUser.copyWith(balance: currentUser.balance + 50));
    await ref.read(userServiceProvider).increaseBalance(newBalance: currentUser.balance + 50);
    // so now i need to set the state to the previous user after loading how do i do that
  }
}