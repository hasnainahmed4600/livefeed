import 'package:flutter/material.dart';
import 'package:livefeed/press/screen/press_content.dart';
import 'package:livefeed/press/screen/press_header.dart';
import 'package:livefeed/theme.dart';

class PressLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: LiveFeedTheme.screensBackgroundColor,
      child: Column(
        children: [
          PressHeader(),
          Expanded(
            child: PressContent(),
          ),
        ],
      ),
    );
  }
}
