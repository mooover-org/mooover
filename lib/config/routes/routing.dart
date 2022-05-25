import 'package:auto_route/auto_route.dart';
import 'package:mockito/mockito.dart';
import 'package:mooover/pages/group/group_page.dart';
import 'package:mooover/pages/home/home_page.dart';
import 'package:mooover/pages/login/login_page.dart';
import 'package:mooover/pages/profile/profile_page.dart';
import 'package:mooover/pages/settings/settings_page.dart';

@AdaptiveAutoRouter(routes: <AutoRoute>[
  AutoRoute(page: HomePage, path: "/", initial: true),
  AutoRoute(page: LoginPage, path: "/login"),
  CustomRoute(
      page: ProfilePage,
      path: "/profile",
      transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
      durationInMilliseconds: 200,
      reverseDurationInMilliseconds: 200),
  CustomRoute(
      page: GroupPage,
      path: "/group",
      transitionsBuilder: TransitionsBuilders.slideRightWithFade,
      durationInMilliseconds: 200,
      reverseDurationInMilliseconds: 200),
  AutoRoute(page: SettingsPage, path: "/settings"),
])
class $AppRouter {}

class AppRouteObserver extends Mock implements AutoRouteObserver {}
