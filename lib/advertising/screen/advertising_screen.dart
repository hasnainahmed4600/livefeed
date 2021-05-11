import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:livefeed/advertising/bloc/current_ads/current_ads_bloc.dart';
import 'package:livefeed/common/widgets/livefeed_app_bar.dart';
import 'package:livefeed/home/screens/home_screen.dart';
import 'package:livefeed/how_it_works/screen/how_it_works_screen.dart';
import 'package:livefeed/marketplace/screens/marketplace_screen.dart';
import 'package:livefeed/advertising/screen/advertising_layout.dart';
import 'package:livefeed/theme.dart';
import 'package:livefeed/advertising/bloc/ad_form/ad_form_bloc.dart';

class AdvertisingScreen extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => AdvertisingScreen());
  }

  @override
  Widget build(BuildContext context) {
    final appBar = LivefeedAppBar(
      context: context,
      onLogoTapped: () => Navigator.of(context).pop(),
      onHowItWorksTapped: () => Navigator.of(context).pushReplacement(
        HowItWorksScreen.route(previousRoute: AdvertisingScreen.route()),
      ),
      onMarketplaceTapped: () =>
          Navigator.of(context).pushReplacement(MarketplaceScreen.route(
        previousRoute: AdvertisingScreen.route(),
      )),
    );
    return Scaffold(
      appBar: appBar.build(),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) {
              return CurrentAdsBloc()..add(AdsLoaded());
            },
          ),
          BlocProvider(
            create: (context) {
              return AdFormBloc();
            },
          ),
        ],
        child: AdvertisingLayout(),
      ),
    );
  }
}
