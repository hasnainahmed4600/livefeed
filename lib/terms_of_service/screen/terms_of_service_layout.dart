import 'package:flutter/material.dart';
import 'package:livefeed/terms_of_service/screen/terms_of_service_content.dart';
import 'package:livefeed/terms_of_service/screen/terms_of_service_header.dart';
import 'package:livefeed/theme.dart';

class TermsOfServiceLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: LiveFeedTheme.screensBackgroundColor,
      child: Column(
        children: [
          TermsOfServiceHeader(),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                color: Colors.grey[200],
                child: TermsOfServiceContent(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
