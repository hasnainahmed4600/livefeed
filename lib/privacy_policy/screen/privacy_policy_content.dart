import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:livefeed/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class PrivacyPolicyContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        children: [
          _CommitmentBody(),
        ],
      ),
    );
  }
}

class _CommitmentBody extends StatelessWidget {
  Widget _buildItem(String textBody) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.check,
          color: LiveFeedTheme.theme.accentColor,
        ),
        const Padding(padding: EdgeInsets.only(left: 10)),
        Expanded(
          child: Text(textBody, style: TextStyle(fontWeight: FontWeight.w500)),
        ),
      ],
    );
  }

  Widget _buildRichTextItem(List<TextSpan> textBody) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.check,
          color: LiveFeedTheme.theme.accentColor,
        ),
        const Padding(padding: EdgeInsets.only(left: 10)),
        Expanded(
          child: RichText(
            text: TextSpan(
                style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
                  fontWeight: FontWeight.w500,
                ),
                children: textBody),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(width: 1.0, color: Colors.grey[400]),
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Live Media Inc (“Live,” “Live Media,” “LiveFEED,” “Our Company,” “Us”, “We”, or “Our”) operates the www.GetLiveFeed.com and its affiliated websites (the “Service”). This Privacy Policy informs you of our policies regarding the collection, use, and disclosure of Personal Information when you use our Service.\n',
              style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
                fontWeight: FontWeight.w500,
                height: 1.5,
                fontSize: 15,
              ),
            ),
            Text(
              'We will not use or share your information with anyone except as described in this Privacy Policy.\n',
              style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
                fontWeight: FontWeight.w500,
                height: 1.5,
                fontSize: 15,
              ),
            ),
            RichText(
              text: TextSpan(
                style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
                  fontWeight: FontWeight.w500,
                  height: 1.5,
                  fontSize: 15,
                ),
                children: <TextSpan>[
                  TextSpan(
                      text:
                          'We use your Personal Information for providing and improving our Service. By using the Service, you agree to the collection and use of information in accordance with this policy. Unless otherwise defined in this Privacy Policy, terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, accessible at '),
                  TextSpan(
                    text: 'www.getlivefeed.com/tos/\n',
                    style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
                      color: LiveFeedTheme.theme.highlightColor,
                      fontWeight: FontWeight.w600,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap =
                          () => launch('https://www.getlivefeed.com/tos/'),
                  ),
                ],
              ),
            ),
            Text(
              'Information Collection and Use',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                height: 1.5,
                fontSize: 15,
              ),
            ),
            Text(
              'Our Company collects the following data:\n',
              style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
                fontWeight: FontWeight.w500,
                height: 1.5,
                fontSize: 15,
              ),
            ),
            Text(
              'Personal identification information (Name, email address, phone number, location, etc.)\nUser-Generated Content, where applicable. We offer you the ability to post content that other users can read (i.e. posts or comments). Anyone can read, collect and use any personal information that accompanies your posts. We do not have to publish any of your content. If the law requires us to take it down, remove or edit your personal information, we will comply to the required extent.',
              style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
                fontWeight: FontWeight.w500,
                height: 1.5,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
