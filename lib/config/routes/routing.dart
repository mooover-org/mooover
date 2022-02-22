import 'package:auto_route/annotations.dart';
import 'package:mooover/screens/sign_in_screen.dart';

@AdaptiveAutoRouter(routes: <AutoRoute>[
  AutoRoute(page: SignInScreen, initial: true),
])
class $AppRouter {}