import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:livefeed/theme.dart';

class LegalFooter extends StatelessWidget {
  final List<Widget> _legalNavs = <Widget>[
    _TermsOfServiceNavigator(),
    _PrivacyPolicyNavigator(),
    _OurCommitmentNavigator(),
    _PressNavigator(),
    _AdvertisingNavigator(),
    _FeedbackNavigator(),
    _ContactUsNavigator(),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.black,
      child: Column(
        children: [
          Wrap(
            spacing: 25,
            alignment: WrapAlignment.center,
            runSpacing: 5,
            children: _legalNavs,
          ),
          Text(
            '© 2017 - 2020 LIVE MEDIA INC. ALL RIGHTS RESERVED. PATENTS APPLIED FOR IN THE US AND ABROAD.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Gilroy',
              fontSize: 8,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class _TermsOfServiceNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Text(
        'Terms of service',
        style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
          color: Colors.white,
        ),
      ),
    );
  }
}

class _PrivacyPolicyNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Text(
        'Privacy policy',
        style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
          color: Colors.white,
        ),
      ),
    );
  }
}

class _OurCommitmentNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Text(
        'Our commitment to you',
        style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
          color: Colors.white,
        ),
      ),
    );
  }
}

class _PressNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Text(
        'Press',
        style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
          color: Colors.white,
        ),
      ),
    );
  }
}

class _AdvertisingNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Text(
        'Advertising',
        style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
          color: Colors.white,
        ),
      ),
    );
  }
}

class _FeedbackNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Text(
        'Feedback',
        style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
          color: Colors.white,
        ),
      ),
    );
  }
}

class _ContactUsNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Text(
        'Contact us',
        style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
          color: Colors.white,
        ),
      ),
    );
  }
}
