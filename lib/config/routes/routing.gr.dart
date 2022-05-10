// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i4;
import 'package:flutter/material.dart' as _i5;
import 'package:mooover/pages/home/home_page.dart' as _i1;
import 'package:mooover/pages/login/login_page.dart' as _i2;
import 'package:mooover/pages/user_profile/user_profile_page.dart' as _i3;

class AppRouter extends _i4.RootStackRouter {
  AppRouter([_i5.GlobalKey<_i5.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    HomePageRoute.name: (routeData) {
      return _i4.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i1.HomePage());
    },
    LoginPageRoute.name: (routeData) {
      return _i4.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i2.LoginPage());
    },
    ProfilePageRoute.name: (routeData) {
      return _i4.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i3.UserProfilePage());
    }
  };

  @override
  List<_i4.RouteConfig> get routes => [
        _i4.RouteConfig(HomePageRoute.name, path: '/'),
        _i4.RouteConfig(LoginPageRoute.name, path: '/login'),
        _i4.RouteConfig(ProfilePageRoute.name, path: '/user_profile')
      ];
}

/// generated route for
/// [_i1.HomePage]
class HomePageRoute extends _i4.PageRouteInfo<void> {
  const HomePageRoute() : super(HomePageRoute.name, path: '/');

  static const String name = 'HomePageRoute';
}

/// generated route for
/// [_i2.LoginPage]
class LoginPageRoute extends _i4.PageRouteInfo<void> {
  const LoginPageRoute() : super(LoginPageRoute.name, path: '/login');

  static const String name = 'LoginPageRoute';
}

/// generated route for
/// [_i3.ProfilePage]
class ProfilePageRoute extends _i4.PageRouteInfo<void> {
  const ProfilePageRoute() : super(ProfilePageRoute.name, path: '/user_profile');

  static const String name = 'ProfilePageRoute';
}
