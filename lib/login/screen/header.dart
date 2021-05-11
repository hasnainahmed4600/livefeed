import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  Header({
    this.height,
    this.width,
  });
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: height == null ? double.infinity : height,
          width: width == null ? double.infinity : width,
          child: FittedBox(
            fit: BoxFit.cover,
            clipBehavior: Clip.hardEdge,
            child: Image(
              image: AssetImage('assets/images/earth_exp3x.png'),
            ),
          ),
        ),
        Positioned(
          top: 24,
          left: 33,
          // child: Container(
          //   decoration: BoxDecoration(
          //       image: DecorationImage(
          //     image: AssetImage('assets/images/livefeed_logo.png'),
          //   )),
          // ),
          child: Container(
            height: 43,
            width: 133,
            child: FittedBox(
              fit: BoxFit.fill,
              child: Image(
                image: AssetImage('assets/images/livefeed_logo.png'),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
