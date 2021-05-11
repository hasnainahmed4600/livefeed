import 'package:flutter/material.dart';
import 'package:livefeed/common/widgets/livefeed_app_bar.dart';
import 'package:livefeed/home/screens/home_screen.dart';
import 'package:livefeed/marketplace/screens/marketplace_screen.dart';
import 'package:livefeed/privacy_policy/screen/privacy_policy_layout.dart';
import 'package:livefeed/terms_of_service/screen/terms_of_service_layout.dart';
import 'package:livefeed/theme.dart';
import 'package:livefeed/our_commitment/screen/our_commitment_layout.dart';
import 'package:livefeed/how_it_works/screen/how_it_works_screen.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => PrivacyPolicyScreen());
  }

  @override
  Widget build(BuildContext context) {
    final appBar = LivefeedAppBar(
      context: context,
      onLogoTapped: () => Navigator.of(context).pop(),
      onHowItWorksTapped: () =>
          Navigator.of(context).pushReplacement(HowItWorksScreen.route(
        previousRoute: PrivacyPolicyScreen.route(),
      )),
      onMarketplaceTapped: () =>
          Navigator.of(context).pushReplacement(MarketplaceScreen.route(
        previousRoute: PrivacyPolicyScreen.route(),
      )),
    );
    return Scaffold(
      appBar: appBar.build(),
      body: PrivacyPolicyLayout(),
    );
  }
}
