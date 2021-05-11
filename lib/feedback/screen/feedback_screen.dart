import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:livefeed/common/widgets/livefeed_app_bar.dart';
import 'package:livefeed/feedback/bloc/feedback_form_bloc.dart';
import 'package:livefeed/feedback/screen/feedback_layout.dart';
import 'package:livefeed/home/screens/home_screen.dart';
import 'package:livefeed/how_it_works/screen/how_it_works_screen.dart';
import 'package:livefeed/marketplace/screens/marketplace_screen.dart';
import 'package:livefeed/theme.dart';

class FeedbackScreen extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => FeedbackScreen());
  }

  @override
  Widget build(BuildContext context) {
    final appBar = LivefeedAppBar(
      context: context,
      onLogoTapped: () => Navigator.of(context).pop(),
      onHowItWorksTapped: () => Navigator.of(context).pushReplacement(
        HowItWorksScreen.route(previousRoute: FeedbackScreen.route()),
      ),
      onMarketplaceTapped: () =>
          Navigator.of(context).pushReplacement(MarketplaceScreen.route(
        previousRoute: FeedbackScreen.route(),
      )),
    );
    return Scaffold(
      appBar: appBar.build(),
      body: BlocProvider(
        create: (context) {
          return FeedbackFormBloc();
        },
        child: FeedbackLayout(),
      ),
    );
  }
}
