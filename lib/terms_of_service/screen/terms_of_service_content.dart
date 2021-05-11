import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:livefeed/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class TermsOfServiceContent extends StatelessWidget {
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
              'Welcome to LiveFEED! We’re glad you joined us on a mission to revolutionize the world of information.\n',
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
                          'Please read these Terms of Service (“Terms”, “Terms of Service”, “TOS”) carefully before using the '),
                  TextSpan(
                    text: 'https://www.getlivefeed.com ',
                    style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
                      color: LiveFeedTheme.theme.highlightColor,
                      fontWeight: FontWeight.w600,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => launch('https://www.getlivefeed.com/'),
                  ),
                  TextSpan(
                      text:
                          'and our affiliated websites (the “Service”) operated by Live Media Inc (“Live,” “Live Media,” “LiveFEED,” “Our Company,” “Us”, “We”, or “Our”).\n'),
                ],
              ),
            ),
            Text(
              'General Rules',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                height: 1.5,
                fontSize: 15,
              ),
            ),
            Text(
              'Your access to and use of the Service is conditioned on your acceptance of and compliance with these Terms. These Terms apply to all visitors, users and others who access or use the Service.\n',
              style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
                fontWeight: FontWeight.w500,
                height: 1.5,
                fontSize: 15,
              ),
            ),
            Text(
              'By accessing or using the Service you agree to be bound by these Terms. If you disagree with any part of the terms then you may not access the Service.\n',
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
                          'If any of the terms and conditions of these Terms of Service, or any future changes, are unacceptable to you, you may (i) cancel your account by sending an e-mail to: '),
                  TextSpan(
                    text: 'info@livemedia.live ',
                    style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
                      color: LiveFeedTheme.theme.highlightColor,
                      fontWeight: FontWeight.w600,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => launch('mailto:info@livemedia.live'),
                  ),
                  TextSpan(
                      text:
                          'and/or (ii) discontinue your use of our Service. Your continued use of the Service now, or following the posting of these Terms of Service, will indicate acceptance by you of such Terms of Service, changes, or modifications.\n'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
