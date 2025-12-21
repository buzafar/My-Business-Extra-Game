// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:flutter/material.dart' as _i7;
import 'package:my_business_extra/features/auth/pages/login_page.dart' as _i3;
import 'package:my_business_extra/features/auth/pages/signup_page.dart' as _i5;
import 'package:my_business_extra/features/home/pages/home_page.dart' as _i1;
import 'package:my_business_extra/features/sell_product/pages/sell_product_page.dart'
    as _i4;
import 'package:my_business_extra/loading_page.dart' as _i2;

/// generated route for
/// [_i1.HomePage]
class HomeRoute extends _i6.PageRouteInfo<void> {
  const HomeRoute({List<_i6.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i1.HomePage();
    },
  );
}

/// generated route for
/// [_i2.LoadingPage]
class LoadingRoute extends _i6.PageRouteInfo<void> {
  const LoadingRoute({List<_i6.PageRouteInfo>? children})
    : super(LoadingRoute.name, initialChildren: children);

  static const String name = 'LoadingRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i2.LoadingPage();
    },
  );
}

/// generated route for
/// [_i3.LoginPage]
class LoginRoute extends _i6.PageRouteInfo<void> {
  const LoginRoute({List<_i6.PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i3.LoginPage();
    },
  );
}

/// generated route for
/// [_i4.SellProductPage]
class SellProductRoute extends _i6.PageRouteInfo<SellProductRouteArgs> {
  SellProductRoute({
    _i7.Key? key,
    required int warehouseProductId,
    List<_i6.PageRouteInfo>? children,
  }) : super(
         SellProductRoute.name,
         args: SellProductRouteArgs(
           key: key,
           warehouseProductId: warehouseProductId,
         ),
         initialChildren: children,
       );

  static const String name = 'SellProductRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SellProductRouteArgs>();
      return _i4.SellProductPage(
        key: args.key,
        warehouseProductId: args.warehouseProductId,
      );
    },
  );
}

class SellProductRouteArgs {
  const SellProductRouteArgs({this.key, required this.warehouseProductId});

  final _i7.Key? key;

  final int warehouseProductId;

  @override
  String toString() {
    return 'SellProductRouteArgs{key: $key, warehouseProductId: $warehouseProductId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! SellProductRouteArgs) return false;
    return key == other.key && warehouseProductId == other.warehouseProductId;
  }

  @override
  int get hashCode => key.hashCode ^ warehouseProductId.hashCode;
}

/// generated route for
/// [_i5.SignupPage]
class SignupRoute extends _i6.PageRouteInfo<void> {
  const SignupRoute({List<_i6.PageRouteInfo>? children})
    : super(SignupRoute.name, initialChildren: children);

  static const String name = 'SignupRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i5.SignupPage();
    },
  );
}
