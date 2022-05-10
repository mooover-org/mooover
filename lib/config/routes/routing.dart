import 'package:auto_route/auto_route.dart';
import 'package:mockito/mockito.dart';
import 'package:mooover/pages/home/home_page.dart';
import 'package:mooover/pages/login/login_page.dart';
import 'package:mooover/pages/user_profile/user_profile_page.dart';

@AdaptiveAutoRouter(routes: <AutoRoute>[
  AutoRoute(page: HomePage, path: "/", initial: true),
  AutoRoute(page: LoginPage, path: "/login"),
  AutoRoute(page: UserProfilePage, path: "/user_profile"),
])
class $AppRouter {}

class AppRouteObserver extends Mock implements AutoRouteObserver {
}
