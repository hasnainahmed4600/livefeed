import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:livefeed/common/widgets/livefeed_app_bar.dart';
import 'package:livefeed/content_creators/screen/content_creators_screen.dart';
import 'package:livefeed/how_it_works/screen/how_it_works_screen.dart';
import 'package:livefeed/marketplace/bloc/marketplace_tab_bloc.dart';
import 'package:livefeed/marketplace/screens/marketplacetab_navigator.dart';
import 'package:livefeed/theme.dart';
import 'package:livefeed/content_buyers/screen/content_buyers_screen.dart';
import 'package:livefeed/home/screens/home_screen.dart';
import 'package:livefeed/home/bloc/apptab/apptab_bloc.dart';

class MarketplaceScreen extends StatelessWidget {
  MarketplaceScreen({
    @required this.previousRoute,
  }) : assert(previousRoute != null);

  final Route previousRoute;

  static Route route({Route previousRoute}) {
    return MaterialPageRoute<void>(
        builder: (_) => MarketplaceScreen(
              previousRoute: previousRoute,
            ));
  }

  Widget _tempMapBody(MarketplaceTab tab) {
    switch (tab) {
      case MarketplaceTab.content_buyers:
        return ContentBuyersScreen();
      case MarketplaceTab.content_creators:
        return ContentCreatorsScreen();
      // case MarketplaceTab.how_it_works:
      //   return Center(
      //     child: Text('How it works!'),
      //   );
      default:
        return Center(
          child: Text('Content buyers'),
        );
    }
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
      onHowItWorksTapped: () => Navigator.of(context).pushReplacement(
        HowItWorksScreen.route(
          previousRoute: MarketplaceScreen.route(previousRoute: previousRoute),
        ),
      ),
      marketplaceActive: true,
    ).build();

    return new WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: BlocBuilder<MarketplaceTabBloc, MarketplaceTab>(
        builder: (context, activeTab) {
          return Scaffold(
            backgroundColor: LiveFeedTheme.screensBackgroundColor,
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
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         GestureDetector(
            //           onTap: () => Navigator.of(context)
            //               .pushReplacement(HowItWorksScreen.route()),
            //           child: Text(
            //             'HOW IT WORKS',
            //             style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
            //               fontWeight: FontWeight.bold,
            //               fontSize: 13,
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //     const Padding(padding: EdgeInsets.all(5.0)),
            //     Padding(
            //       padding: EdgeInsets.only(right: 14),
            //       child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.center,
            //         mainAxisAlignment: MainAxisAlignment.start,
            //         children: [
            //           Container(
            //             width: 100,
            //             height: 8,
            //             color: LiveFeedTheme.theme.accentColor,
            //           ),
            //           const Padding(padding: EdgeInsets.only(top: 10)),
            //           GestureDetector(
            //             // onTap: () => Navigator.of(context)
            //             //     .pushReplacement(ContentBuyersScreen.route()),
            //             child: Text(
            //               'MARKETPLACE',
            //               style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
            //                 fontWeight: FontWeight.bold,
            //                 color: LiveFeedTheme.theme.accentColor,
            //                 fontSize: 13,
            //               ),
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ],
            // ),
            body: Column(
              children: [
                Container(
                  height: 180,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fitWidth,
                      image: AssetImage('assets/images/earth3x.png'),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: Text(
                          'LIVEFEED MARKETPLACE',
                          style:
                              LiveFeedTheme.theme.textTheme.headline1.copyWith(
                            fontSize: 35,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: Text(
                          'is where you can acquire & offer content',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(top: 30)),
                      MarketplaceTabNavigator(
                        activeTab: activeTab,
                        onTabSelected: (tab) =>
                            BlocProvider.of<MarketplaceTabBloc>(context)
                                .add(MarketplaceTabUpdated(tab)),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: _tempMapBody(activeTab),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
