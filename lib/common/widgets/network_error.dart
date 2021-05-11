import 'package:flutter/material.dart';

class NetworkError extends StatelessWidget {
  const NetworkError(this.error, this.onPressed);

  final String error;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(error),
        TextButton(
          onPressed: this.onPressed,
          child: Text('Reload'),
        ),
      ],
    );
  }
}
