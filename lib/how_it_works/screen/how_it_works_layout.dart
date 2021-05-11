import 'package:flutter/material.dart';
import 'package:livefeed/how_it_works/screen/how_it_works_content.dart';
import 'package:livefeed/how_it_works/screen/how_it_works_header.dart';
import 'package:livefeed/theme.dart';

class HowItWorksLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: LiveFeedTheme.screensBackgroundColor,
      child: Column(
        children: [
          HowItWorksHeader(),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                color: Colors.grey[200],
                child: HowItWorksContent(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
