// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i7;
import 'package:flutter/material.dart' as _i8;
import 'package:mooover/pages/greetings/greetings_page.dart' as _i1;
import 'package:mooover/pages/group/group_page.dart' as _i5;
import 'package:mooover/pages/home/home_page.dart' as _i2;
import 'package:mooover/pages/login/login_page.dart' as _i3;
import 'package:mooover/pages/profile/profile_page.dart' as _i4;
import 'package:mooover/pages/settings/settings_page.dart' as _i6;

class AppRouter extends _i7.RootStackRouter {
  AppRouter([_i8.GlobalKey<_i8.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i7.PageFactory> pagesMap = {
    GreetingsPageRoute.name: (routeData) {
      return _i7.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i1.GreetingsPage());
    },
    HomePageRoute.name: (routeData) {
      return _i7.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i2.HomePage());
    },
    LoginPageRoute.name: (routeData) {
      return _i7.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i3.LoginPage());
    },
    ProfilePageRoute.name: (routeData) {
      return _i7.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i4.ProfilePage(),
          transitionsBuilder: _i7.TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 200,
          reverseDurationInMilliseconds: 200,
          opaque: true,
          barrierDismissible: false);
    },
    GroupPageRoute.name: (routeData) {
      return _i7.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i5.GroupPage(),
          transitionsBuilder: _i7.TransitionsBuilders.slideRightWithFade,
          durationInMilliseconds: 200,
          reverseDurationInMilliseconds: 200,
          opaque: true,
          barrierDismissible: false);
    },
    SettingsPageRoute.name: (routeData) {
      return _i7.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i6.SettingsPage(),
          transitionsBuilder: _i7.TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 200,
          reverseDurationInMilliseconds: 200,
          opaque: true,
          barrierDismissible: false);
    }
  };

  @override
  List<_i7.RouteConfig> get routes => [
        _i7.RouteConfig('/#redirect',
            path: '/', redirectTo: '/greetings', fullMatch: true),
        _i7.RouteConfig(GreetingsPageRoute.name, path: '/greetings'),
        _i7.RouteConfig(HomePageRoute.name, path: '/home'),
        _i7.RouteConfig(LoginPageRoute.name, path: '/login'),
        _i7.RouteConfig(ProfilePageRoute.name, path: '/profile'),
        _i7.RouteConfig(GroupPageRoute.name, path: '/group'),
        _i7.RouteConfig(SettingsPageRoute.name, path: '/settings')
      ];
}

/// generated route for
/// [_i1.GreetingsPage]
class GreetingsPageRoute extends _i7.PageRouteInfo<void> {
  const GreetingsPageRoute()
      : super(GreetingsPageRoute.name, path: '/greetings');

  static const String name = 'GreetingsPageRoute';
}

/// generated route for
/// [_i2.HomePage]
class HomePageRoute extends _i7.PageRouteInfo<void> {
  const HomePageRoute() : super(HomePageRoute.name, path: '/home');

  static const String name = 'HomePageRoute';
}

/// generated route for
/// [_i3.LoginPage]
class LoginPageRoute extends _i7.PageRouteInfo<void> {
  const LoginPageRoute() : super(LoginPageRoute.name, path: '/login');

  static const String name = 'LoginPageRoute';
}

/// generated route for
/// [_i4.ProfilePage]
class ProfilePageRoute extends _i7.PageRouteInfo<void> {
  const ProfilePageRoute() : super(ProfilePageRoute.name, path: '/profile');

  static const String name = 'ProfilePageRoute';
}

/// generated route for
/// [_i5.GroupPage]
class GroupPageRoute extends _i7.PageRouteInfo<void> {
  const GroupPageRoute() : super(GroupPageRoute.name, path: '/group');

  static const String name = 'GroupPageRoute';
}

/// generated route for
/// [_i6.SettingsPage]
class SettingsPageRoute extends _i7.PageRouteInfo<void> {
  const SettingsPageRoute() : super(SettingsPageRoute.name, path: '/settings');

  static const String name = 'SettingsPageRoute';
}
