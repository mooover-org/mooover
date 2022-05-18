import 'package:flutter/material.dart';

class Panel extends StatelessWidget {
  final Widget? child;

  const Panel({this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: Theme.of(context).cardTheme.margin,
      shape: Theme.of(context).cardTheme.shape,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: child,
      ),
      elevation: Theme.of(context).cardTheme.elevation,
    );
  }
}
