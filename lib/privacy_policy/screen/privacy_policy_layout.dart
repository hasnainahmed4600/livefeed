import 'package:flutter/material.dart';
import 'package:livefeed/privacy_policy/screen/privacy_policy_content.dart';
import 'package:livefeed/privacy_policy/screen/privacy_policy_header.dart';
import 'package:livefeed/theme.dart';

class PrivacyPolicyLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: LiveFeedTheme.screensBackgroundColor,
      child: Column(
        children: [
          PrivacyPolicyHeader(),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                color: Colors.grey[200],
                child: PrivacyPolicyContent(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
