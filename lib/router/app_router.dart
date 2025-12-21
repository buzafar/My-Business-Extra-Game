import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_business_extra/features/auth/providers/auth_provider.dart';
import 'package:my_business_extra/router/app_router.gr.dart';
import 'package:my_business_extra/services/auth_service.dart';
import 'package:my_business_extra/services/user_service.dart';

final appRouterProvider = Provider<AppRouter>((ref) {
  return AppRouter(ref);
});

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  AppRouter(this.ref);

  final Ref ref;

  //Default route type
  @override
  RouteType get defaultRouteType => const RouteType.material(); //.cupertino, .adaptive

  @override
  List<AutoRoute> get routes => [
    /// routes go here
    AutoRoute(page: LoginRoute.page),
    AutoRoute(page: HomeRoute.page, guards: [AuthGuard(ref)]),
    AutoRoute(page: SignupRoute.page),
    AutoRoute(page: SellProductRoute.page),

    // never go to loading page if user is not signed in. otherwise, it will cause null error and app crashes
    // therefore AuthGuard is a must;
    AutoRoute(page: LoadingRoute.page, initial: true, guards: [AuthGuard(ref)]),
  ];

  // @override
  // List<AutoRouteGuard> get guards => [
  //   AuthGuard(ref),
  // ];
}

class AuthGuard extends AutoRouteGuard {
  AuthGuard(this.ref);

  final Ref ref;

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final user = ref.read(authServiceProvider).currentUser;

    if (user == null) {
      router.push(const SignupRoute());
    } else {
      resolver.next();
    }
  }
}
