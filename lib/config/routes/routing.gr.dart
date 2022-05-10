// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i6;
import 'package:mooover/pages/home/home_page.dart' as _i1;
import 'package:mooover/pages/login/login_page.dart' as _i2;
import 'package:mooover/pages/settings/settings_page.dart' as _i4;
import 'package:mooover/pages/user_profile/user_profile_page.dart' as _i3;

class AppRouter extends _i5.RootStackRouter {
  AppRouter([_i6.GlobalKey<_i6.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    HomePageRoute.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i1.HomePage());
    },
    LoginPageRoute.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i2.LoginPage());
    },
    UserProfilePageRoute.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i3.UserProfilePage());
    },
    SettingsPageRoute.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i4.SettingsPage());
    }
  };

  @override
  List<_i5.RouteConfig> get routes => [
        _i5.RouteConfig(HomePageRoute.name, path: '/'),
        _i5.RouteConfig(LoginPageRoute.name, path: '/login'),
        _i5.RouteConfig(UserProfilePageRoute.name, path: '/user_profile'),
        _i5.RouteConfig(SettingsPageRoute.name, path: '/settings')
      ];
}

/// generated route for
/// [_i1.HomePage]
class HomePageRoute extends _i5.PageRouteInfo<void> {
  const HomePageRoute() : super(HomePageRoute.name, path: '/');

  static const String name = 'HomePageRoute';
}

/// generated route for
/// [_i2.LoginPage]
class LoginPageRoute extends _i5.PageRouteInfo<void> {
  const LoginPageRoute() : super(LoginPageRoute.name, path: '/login');

  static const String name = 'LoginPageRoute';
}

/// generated route for
/// [_i3.UserProfilePage]
class UserProfilePageRoute extends _i5.PageRouteInfo<void> {
  const UserProfilePageRoute()
      : super(UserProfilePageRoute.name, path: '/user_profile');

  static const String name = 'UserProfilePageRoute';
}

/// generated route for
/// [_i4.SettingsPage]
class SettingsPageRoute extends _i5.PageRouteInfo<void> {
  const SettingsPageRoute() : super(SettingsPageRoute.name, path: '/settings');

  static const String name = 'SettingsPageRoute';
}
