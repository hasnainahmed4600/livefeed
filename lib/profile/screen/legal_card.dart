import 'dart:math';

import 'package:flutter/material.dart';
import 'package:livefeed/advertising/screen/advertising_screen.dart';
import 'package:livefeed/contact_us/screen/contact_us_screen.dart';
import 'package:livefeed/feedback/screen/feedback_screen.dart';
import 'package:livefeed/press/screen/press_screen.dart';
import 'package:livefeed/theme.dart';
import 'package:livefeed/our_commitment/screen/our_commitment_screen.dart';
import 'package:livefeed/terms_of_service/screen/terms_of_service_screen.dart';
import 'package:livefeed/privacy_policy/screen/privacy_policy_screen.dart';

class LegalCard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LegalCardState();
}

class _LegalCardState extends State<LegalCard> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    if (expanded) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          border: Border.all(width: 1.0, color: Colors.grey[400]),
          color: Colors.white,
        ),
        child: Column(
          children: [
            _CardHeader(
              () {
                setState(() {
                  this.expanded = !this.expanded;
                });
              },
              this.expanded,
            ),
            Divider(
              thickness: 2.0,
              height: 0,
            ),
            ListTile(
              title: Text('Terms of service'),
              trailing: Icon(Icons.chevron_right),
              onTap: () =>
                  Navigator.of(context).push(TermsOfServiceScreen.route()),
            ),
            ListTile(
              title: Text('Privacy policy'),
              trailing: Icon(Icons.chevron_right),
              onTap: () =>
                  Navigator.of(context).push(PrivacyPolicyScreen.route()),
            ),
            ListTile(
              title: Text('Our commitment to you'),
              trailing: Icon(Icons.chevron_right),
              onTap: () =>
                  Navigator.of(context).push(OurCommitmentScreen.route()),
            ),
            ListTile(
              title: Text('Press'),
              trailing: Icon(Icons.chevron_right),
              onTap: () => Navigator.of(context).push(PressScreen.route()),
            ),
            ListTile(
              title: Text('Advertising'),
              trailing: Icon(Icons.chevron_right),
              onTap: () =>
                  Navigator.of(context).push(AdvertisingScreen.route()),
            ),
            ListTile(
              title: Text('Feedback'),
              trailing: Icon(Icons.chevron_right),
              onTap: () => Navigator.of(context).push(FeedbackScreen.route()),
            ),
            ListTile(
              title: Text('Contact us'),
              trailing: Icon(Icons.chevron_right),
              onTap: () => Navigator.of(context).push(ContactUsScreen.route()),
            ),
          ],
        ),
      );
    } else {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          border: Border.all(width: 1.0, color: Colors.grey[400]),
          color: Colors.white,
        ),
        child: Column(
          children: [
            _CardHeader(
              () {
                setState(() {
                  this.expanded = !this.expanded;
                });
              },
              this.expanded,
            ),
          ],
        ),
      );
    }
  }
}

class _CardHeader extends StatelessWidget {
  final Function onTap;
  final bool expanded;

  _CardHeader(this.onTap, this.expanded);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20),
      title: Text(
        'ABOUT',
        style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
          color: Colors.grey[800],
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: Transform.rotate(
        angle: expanded ? pi / 2 : pi / -2,
        alignment: Alignment.center,
        child: Icon(
          Icons.chevron_left,
          color: LiveFeedTheme.theme.highlightColor,
          size: 32,
        ),
      ),
      onTap: this.onTap,
    );
  }
}
