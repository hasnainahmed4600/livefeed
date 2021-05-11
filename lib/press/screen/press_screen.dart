import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:livefeed/common/widgets/livefeed_app_bar.dart';
import 'package:livefeed/how_it_works/screen/how_it_works_screen.dart';
import 'package:livefeed/marketplace/screens/marketplace_screen.dart';
import 'package:livefeed/press/bloc/press_list_bloc.dart';
import 'package:livefeed/press/screen/press_layout.dart';

class PressScreen extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => PressScreen());
  }

  @override
  Widget build(BuildContext context) {
    final appBar = LivefeedAppBar(
      context: context,
      onLogoTapped: () => Navigator.of(context).pop(),
      onHowItWorksTapped: () =>
          Navigator.of(context).pushReplacement(HowItWorksScreen.route(
        previousRoute: PressScreen.route(),
      )),
      onMarketplaceTapped: () =>
          Navigator.of(context).pushReplacement(MarketplaceScreen.route(
        previousRoute: PressScreen.route(),
      )),
    );
    return Scaffold(
      appBar: appBar.build(),
      body: BlocProvider(
        create: (context) {
          return PressListBloc()..add(PressListLoaded());
        },
        child: PressLayout(),
      ),
    );
  }
}
