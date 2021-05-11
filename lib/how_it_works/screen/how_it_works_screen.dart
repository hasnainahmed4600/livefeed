import 'package:flutter/material.dart';
import 'package:livefeed/common/widgets/livefeed_app_bar.dart';
import 'package:livefeed/home/screens/home_screen.dart';
import 'package:livefeed/how_it_works/screen/how_it_works_layout.dart';
import 'package:livefeed/marketplace/screens/marketplace_screen.dart';
import 'package:livefeed/theme.dart';
import 'package:livefeed/home/bloc/apptab/apptab_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:livefeed/how_it_works/bloc/how_it_works_bloc.dart';

class HowItWorksScreen extends StatelessWidget {
  HowItWorksScreen({
    @required this.previousRoute,
  }) : assert(previousRoute != null);

  final Route previousRoute;

  static Route route({Route previousRoute}) {
    return MaterialPageRoute<void>(
        builder: (_) => HowItWorksScreen(
              previousRoute: previousRoute,
            ));
  }

  _onWillPop(BuildContext context) {
    if (previousRoute == HomeScreen.route())
      context.read<ApptabBloc>().add(TabUpdated(AppTab.timeline));
    Navigator.of(context).pushReplacement(previousRoute);
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
          previousRoute: HowItWorksScreen.route(previousRoute: previousRoute),
        ),
      ),
      howItWorksActive: true,
    ).build();

    return new WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Scaffold(
        appBar: appBar,
        // appBar: AppBar(
        //   leadingWidth: 210,
        //   leading: Padding(
        //     padding: EdgeInsets.only(
        //       left: 10,
        //     ),
        //     child: GestureDetector(
        //       onTap: () {
        //         context.read<ApptabBloc>().add(TabUpdated(AppTab.timeline));
        //         Navigator.of(context).pushReplacement(HomeScreen.route());
        //       },
        //       child: Container(
        //         child: FittedBox(
        //           fit: BoxFit.fitWidth,
        //           child: Image(
        //             image: AssetImage('assets/images/livefeed_logo3x.png'),
        //           ),
        //         ),
        //       ),
        //     ),
        //   ),
        //   toolbarHeight: 55,
        //   elevation: 0.0,
        //   actions: [
        //     Column(
        //       crossAxisAlignment: CrossAxisAlignment.center,
        //       mainAxisAlignment: MainAxisAlignment.start,
        //       children: [
        //         Container(
        //           width: 110,
        //           height: 8,
        //           color: LiveFeedTheme.theme.accentColor,
        //         ),
        //         const Padding(padding: EdgeInsets.only(top: 11)),
        //         Text(
        //           'HOW IT WORKS',
        //           style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
        //             fontWeight: FontWeight.bold,
        //             color: LiveFeedTheme.theme.accentColor,
        //             fontSize: 13,
        //           ),
        //         ),
        //       ],
        //     ),
        //     const Padding(padding: EdgeInsets.all(5.0)),
        //     Padding(
        //       padding: EdgeInsets.only(right: 14),
        //       child: Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
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
        body: BlocProvider(
          create: (context) {
            return HowItWorksBloc();
          },
          child: HowItWorksLayout(),
        ),
      ),
    );
  }
}
