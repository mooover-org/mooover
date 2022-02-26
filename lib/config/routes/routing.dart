import 'package:auto_route/auto_route.dart';
import 'package:mockito/mockito.dart';
import 'package:mooover/pages/hub_page.dart';
import 'package:mooover/pages/login_page.dart';

@AdaptiveAutoRouter(routes: <AutoRoute>[
  AutoRoute(page: LoginPage, initial: true),
  AutoRoute(page: HubPage),
])
class $AppRouter {}

class AppRouteObserver extends Mock implements AutoRouteObserver {
}
