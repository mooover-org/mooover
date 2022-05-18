import 'package:flutter/material.dart';

/// The loading display.
///
/// This is displayed while the app is loading.
class LoadingDisplay extends StatelessWidget {
  final bool transparent;

  const LoadingDisplay({Key? key, this.transparent = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: transparent ? null : Theme.of(context).backgroundColor,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
