import 'package:flutter/material.dart';

/// The error display widget.
///
/// This widget is used to display an error message on the screen.
class ErrorDisplay extends StatelessWidget {
  final String message;

  const ErrorDisplay(
      {Key? key,
      this.message =
          "Something bad happened."})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Whoops!",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Restart the app or try again later.",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.caption,
            ),
          ),
        ],
      ),
    );
  }
}
