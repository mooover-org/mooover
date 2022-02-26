import 'package:flutter/material.dart';
import 'package:mooover/utils/services/user_session/user_session_services.dart';

class HubPage extends StatelessWidget {
  const HubPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MOOOVER!"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Welcome ${UserSessionServices().loggedUser!.givenName}!")
        ],
      ),
    );
  }
}
