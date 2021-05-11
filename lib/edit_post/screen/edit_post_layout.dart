import 'package:flutter/material.dart';
import 'package:livefeed/edit_post/screen/edit_post_card.dart';
import 'package:livefeed/theme.dart';

class EditPostLayout extends StatelessWidget {
  final String initialHeadline;
  final String initialDescription;
  final String initialCategory;
  EditPostLayout(
      this.initialHeadline, this.initialDescription, this.initialCategory);
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
          child: EditPostCard(
              initialHeadline, initialDescription, initialCategory),
        ),
      ),
    );
  }
}
