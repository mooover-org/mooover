import 'package:auto_route/auto_route.dart';
import 'package:mockito/mockito.dart';
import 'package:mooover/pages/sign_in_page.dart';

@AdaptiveAutoRouter(routes: <AutoRoute>[
  AutoRoute(page: SignInPage, initial: true),
])
class $AppRouter {}

class AppRouteObserver extends Mock implements AutoRouteObserver {
}
