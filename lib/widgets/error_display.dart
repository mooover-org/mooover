import 'package:flutter/material.dart';

/// The error display widget.
///
/// This widget is used to display an error message on the screen.
class ErrorDisplay extends StatelessWidget {
  final String message;
  final bool transparent;

  const ErrorDisplay(
      {Key? key,
      this.message = "Something bad happened.",
      this.transparent = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: transparent ? null : Theme.of(context).backgroundColor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                "Whoops!",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                "Restart the app or try again later",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.caption,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
