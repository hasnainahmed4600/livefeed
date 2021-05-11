import 'package:flutter/material.dart';
import 'package:livefeed/our_commitment/screen/our_commitment_content.dart';
import 'package:livefeed/our_commitment/screen/our_commitment_header.dart';
import 'package:livefeed/theme.dart';

class OurCommitmentLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: LiveFeedTheme.screensBackgroundColor,
      child: Column(
        children: [
          OurCommitmentHeader(),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                color: Colors.grey[200],
                child: OurCommitmentContent(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
