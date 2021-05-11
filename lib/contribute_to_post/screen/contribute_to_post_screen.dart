import 'package:flutter/material.dart';
import 'package:livefeed/common/widgets/livefeed_app_bar.dart';
import 'package:livefeed/contribute_to_post/screen/contribute_to_post_layout.dart';
import 'package:livefeed/home/bloc/apptab/apptab_bloc.dart';
import 'package:livefeed/home/screens/home_screen.dart';
import 'package:livefeed/how_it_works/screen/how_it_works_screen.dart';
import 'package:livefeed/marketplace/screens/marketplace_screen.dart';
import 'package:livefeed/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContributeToPostScreen extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => ContributeToPostScreen());
  }

  @override
  Widget build(BuildContext context) {
    final appBar = LivefeedAppBar(
      context: context,
      onLogoTapped: () {
        context.read<ApptabBloc>().add(TabUpdated(AppTab.timeline));
        Navigator.of(context).pushReplacement(HomeScreen.route());
      },
      onMarketplaceTapped: () => Navigator.of(context).pushReplacement(
        MarketplaceScreen.route(
          previousRoute: ContributeToPostScreen.route(),
        ),
      ),
      onHowItWorksTapped: () => Navigator.of(context).pushReplacement(
        HowItWorksScreen.route(
          previousRoute: ContributeToPostScreen.route(),
        ),
      ),
    ).build();

    return Scaffold(
      appBar: appBar,
      // appBar: AppBar(
      //   leadingWidth: 210,
      //   leading: Padding(
      //     padding: EdgeInsets.only(
      //       left: 10,
      //     ),
      //     child: Container(
      //       child: FittedBox(
      //         fit: BoxFit.fitWidth,
      //         child: Image(
      //           image: AssetImage('assets/images/livefeed_logo3x.png'),
      //         ),
      //       ),
      //     ),
      //   ),
      //   toolbarHeight: 55,
      //   elevation: 0.0,
      //   actions: [
      //     Column(
      //       crossAxisAlignment: CrossAxisAlignment.center,
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         Text(
      //           'HOW IT WORKS',
      //           style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
      //             fontWeight: FontWeight.bold,
      //             fontSize: 13,
      //           ),
      //         ),
      //       ],
      //     ),
      //     const Padding(padding: EdgeInsets.all(5.0)),
      //     Padding(
      //       padding: EdgeInsets.only(right: 10),
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.center,
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         children: [
      //           GestureDetector(
      //             onTap: () => Navigator.of(context)
      //                 .pushReplacement(MarketplaceScreen.route()),
      //             child: Text(
      //               'MARKETPLACE',
      //               style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
      //                 fontWeight: FontWeight.bold,
      //                 fontSize: 13,
      //               ),
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //   ],
      // ),
      backgroundColor: LiveFeedTheme.screensBackgroundColor,
      body: ContributeToPostLayout(),
    );
  }
}
