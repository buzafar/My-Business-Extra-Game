import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:my_business_extra/services/user_service.dart';
import '../models/user.dart';

final currentUserProvider =
    AsyncNotifierProvider<CurrentUserNotifier, UserModel>(
      CurrentUserNotifier.new,
    );

class CurrentUserNotifier extends AsyncNotifier<UserModel> {
  @override
  Future<UserModel> build() async {
    return await ref.read(userServiceProvider).getUser();
  }

  Future<void> increaseBalance(double amount) async {
    final user = state.value!;
    final updated = user.copyWith(balance: user.balance + amount);
    state = AsyncData(updated);
  }

  void decreaseBalance(double amount) {
    final user = state.value!;
    state = AsyncData(user.copyWith(balance: user.balance - amount));
  }
}
