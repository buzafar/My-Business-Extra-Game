import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_business_extra/features/auth/providers/auth_provider.dart';
import 'package:my_business_extra/router/app_router.gr.dart';
import 'package:my_business_extra/services/auth_service.dart';



@AutoRouterConfig()
class AppRouter extends RootStackRouter {

//Default route type
  @override
  RouteType get defaultRouteType => const RouteType.material(); //.cupertino, .adaptive

  @override
  List<AutoRoute> get routes => [
    /// routes go here
    AutoRoute(page: LoginRoute.page),
    AutoRoute(page: HomeRoute.page, guards: [AuthGuard()], initial: true),
    AutoRoute(page: SignupRoute.page)
  ];

  // @override
  // List<AutoRouteGuard> get guards => [
  //   AuthGuard()
  // ];
}




class AuthGuard extends AutoRouteGuard {

  AuthGuard();

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final user = AuthService().currentUser;

    if (user == null) {
      router.push(const SignupRoute());
    } else {
      resolver.next();
    }
  }
}