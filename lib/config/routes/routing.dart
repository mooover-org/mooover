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
  AutoRoute(page: ProfilePage, path: "/profile"),
  AutoRoute(page: GroupPage, path: "/group"),
  AutoRoute(page: SettingsPage, path: "/settings"),
])
class $AppRouter {}

class AppRouteObserver extends Mock implements AutoRouteObserver {}
