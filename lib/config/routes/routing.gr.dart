// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i6;
import 'package:flutter/material.dart' as _i7;
import 'package:mooover/pages/group/group_page.dart' as _i4;
import 'package:mooover/pages/home/home_page.dart' as _i1;
import 'package:mooover/pages/login/login_page.dart' as _i2;
import 'package:mooover/pages/profile/profile_page.dart' as _i3;
import 'package:mooover/pages/settings/settings_page.dart' as _i5;

class AppRouter extends _i6.RootStackRouter {
  AppRouter([_i7.GlobalKey<_i7.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    HomePageRoute.name: (routeData) {
      return _i6.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i1.HomePage());
    },
    LoginPageRoute.name: (routeData) {
      return _i6.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i2.LoginPage());
    },
    ProfilePageRoute.name: (routeData) {
      return _i6.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i3.ProfilePage(),
          transitionsBuilder: _i6.TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 300,
          reverseDurationInMilliseconds: 300,
          opaque: true,
          barrierDismissible: false);
    },
    GroupPageRoute.name: (routeData) {
      return _i6.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i4.GroupPage(),
          transitionsBuilder: _i6.TransitionsBuilders.slideRightWithFade,
          durationInMilliseconds: 300,
          reverseDurationInMilliseconds: 300,
          opaque: true,
          barrierDismissible: false);
    },
    SettingsPageRoute.name: (routeData) {
      return _i6.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i5.SettingsPage());
    }
  };

  @override
  List<_i6.RouteConfig> get routes => [
        _i6.RouteConfig(HomePageRoute.name, path: '/'),
        _i6.RouteConfig(LoginPageRoute.name, path: '/login'),
        _i6.RouteConfig(ProfilePageRoute.name, path: '/profile'),
        _i6.RouteConfig(GroupPageRoute.name, path: '/group'),
        _i6.RouteConfig(SettingsPageRoute.name, path: '/settings')
      ];
}

/// generated route for
/// [_i1.HomePage]
class HomePageRoute extends _i6.PageRouteInfo<void> {
  const HomePageRoute() : super(HomePageRoute.name, path: '/');

  static const String name = 'HomePageRoute';
}

/// generated route for
/// [_i2.LoginPage]
class LoginPageRoute extends _i6.PageRouteInfo<void> {
  const LoginPageRoute() : super(LoginPageRoute.name, path: '/login');

  static const String name = 'LoginPageRoute';
}

/// generated route for
/// [_i3.ProfilePage]
class ProfilePageRoute extends _i6.PageRouteInfo<void> {
  const ProfilePageRoute() : super(ProfilePageRoute.name, path: '/profile');

  static const String name = 'ProfilePageRoute';
}

/// generated route for
/// [_i4.GroupPage]
class GroupPageRoute extends _i6.PageRouteInfo<void> {
  const GroupPageRoute() : super(GroupPageRoute.name, path: '/group');

  static const String name = 'GroupPageRoute';
}

/// generated route for
/// [_i5.SettingsPage]
class SettingsPageRoute extends _i6.PageRouteInfo<void> {
  const SettingsPageRoute() : super(SettingsPageRoute.name, path: '/settings');

  static const String name = 'SettingsPageRoute';
}
