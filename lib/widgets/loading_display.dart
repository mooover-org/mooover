import 'package:flutter/material.dart';

/// The loading display.
///
/// This is displayed while the app is loading.
class LoadingDisplay extends StatelessWidget {
  final String? message;
  final bool transparent;
  final double indicatorSize;

  const LoadingDisplay({
    Key? key,
    this.message,
    this.transparent = true,
    this.indicatorSize = 35,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: transparent ? null : Theme.of(context).backgroundColor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: indicatorSize,
              height: indicatorSize,
              child: const CircularProgressIndicator(),
            ),
            message != null
                ? Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      message!,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.caption,
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
