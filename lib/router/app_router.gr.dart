// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:my_business_extra/features/auth/pages/login_page.dart' as _i2;
import 'package:my_business_extra/features/auth/pages/signup_page.dart' as _i3;
import 'package:my_business_extra/features/home/pages/home_page.dart' as _i1;

/// generated route for
/// [_i1.HomePage]
class HomeRoute extends _i4.PageRouteInfo<void> {
  const HomeRoute({List<_i4.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i1.HomePage();
    },
  );
}

/// generated route for
/// [_i2.LoginPage]
class LoginRoute extends _i4.PageRouteInfo<void> {
  const LoginRoute({List<_i4.PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i2.LoginPage();
    },
  );
}

/// generated route for
/// [_i3.SignupPage]
class SignupRoute extends _i4.PageRouteInfo<void> {
  const SignupRoute({List<_i4.PageRouteInfo>? children})
    : super(SignupRoute.name, initialChildren: children);

  static const String name = 'SignupRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i3.SignupPage();
    },
  );
}
