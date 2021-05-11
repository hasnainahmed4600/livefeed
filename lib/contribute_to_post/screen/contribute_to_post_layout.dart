import 'package:flutter/material.dart';
import 'package:livefeed/contribute_to_post/screen/contribute_to_post_card.dart';
import 'package:livefeed/theme.dart';

class ContributeToPostLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        color: LiveFeedTheme.screensBackgroundColor,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          child: ContributeToPostCard(),
        ),
      ),
    );
  }
}
