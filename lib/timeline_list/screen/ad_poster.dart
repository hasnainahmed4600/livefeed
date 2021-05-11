import 'package:flutter/material.dart';

class AdPoster extends StatelessWidget {
  AdPoster({
    this.imagePath = 'assets/images/ad_poster.png',
  });
  final String imagePath;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 40,
      child: FittedBox(
        fit: BoxFit.fill,
        child: Image(
          image: AssetImage(imagePath),
        ),
      ),
    );
  }
}
