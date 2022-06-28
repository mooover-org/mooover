import 'package:flutter/material.dart';
import 'package:mooover/pages/login/components/login_form.dart';

/// The login page.
///
/// Page used for logging in, password resetting and other related
/// activities.
class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Hello!"),
        centerTitle: true,
      ),
      body: const LoginForm(),
    );
  }
}
