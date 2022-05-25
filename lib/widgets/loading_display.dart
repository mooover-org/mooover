import 'package:flutter/material.dart';

/// The loading display.
///
/// This is displayed while the app is loading.
class LoadingDisplay extends StatelessWidget {
  final bool transparent;
  final double size;

  const LoadingDisplay(
      {Key? key, this.transparent = false, this.size = 35})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: transparent ? null : Theme.of(context).backgroundColor,
      child: Center(
        child: SizedBox(
          width: size,
          height: size,
          child: const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
