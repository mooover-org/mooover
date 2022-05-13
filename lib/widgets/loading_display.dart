import 'package:flutter/material.dart';

/// The loading display.
///
/// This is displayed while the app is loading.
class LoadingDisplay extends StatelessWidget {
  const LoadingDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
