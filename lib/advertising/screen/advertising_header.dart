import 'package:flutter/material.dart';
import 'package:livefeed/theme.dart';

class AdvertisingHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fitWidth,
          image: AssetImage('assets/images/earth3x.png'),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              'Advertising',
              style: LiveFeedTheme.theme.textTheme.headline1.copyWith(
                fontSize: 32,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
