import 'package:flutter/material.dart';

class SignupHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 140,
          width: double.infinity,
          child: FittedBox(
            fit: BoxFit.cover,
            clipBehavior: Clip.hardEdge,
            child: Image(
              image: AssetImage('assets/images/earth_exp3x.png'),
            ),
          ),
        ),
        Positioned(
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              height: 46,
              width: 133,
              child: FittedBox(
                fit: BoxFit.fill,
                child: Image(
                  image: AssetImage('assets/images/livefeed_logo.png'),
                ),
              ),
            ),
          ),
          top: 24,
          left: 33,
        ),
      ],
    );
  }
}
