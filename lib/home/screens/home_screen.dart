import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:livefeed/add_post/screen/add_post_screen.dart';
import 'package:livefeed/common/widgets/livefeed_app_bar.dart';
import 'package:livefeed/home/bloc/apptab/apptab_bloc.dart';
import 'package:livefeed/home/bloc/notifications/notifications_bloc.dart';
import 'package:livefeed/home/screens/apptab_navigator.dart';
import 'package:livefeed/how_it_works/screen/how_it_works_screen.dart';
import 'package:livefeed/livefeed/screen/livefeed_screen.dart';
import 'package:livefeed/profile/screen/profile_screen.dart';
import 'package:livefeed/theme.dart';
import 'package:livefeed/timeline_list/screen/timeline_list_screen.dart';
import 'package:livefeed/marketplace/screens/marketplace_screen.dart';

class HomeScreen extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomeScreen());
  }

  Widget _tempMapBody(AppTab tab) {
    switch (tab) {
      case AppTab.profile:
        return ProfileScreen();
      case AppTab.addPost:
        return AddPostScreen();
      case AppTab.timeline:
        return TimelineListScreen();
      case AppTab.liveFeed:
        return LivefeedScreen();
      default:
        return Center(
          child: Text('LiveFEED Screen'),
        );
    }
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
          previousRoute: HomeScreen.route(),
        ),
      ),
      onHowItWorksTapped: () => Navigator.of(context).pushReplacement(
        HowItWorksScreen.route(
          previousRoute: HomeScreen.route(),
        ),
      ),
    ).build();

    return BlocProvider<NotificationsBloc>(
      create: (BuildContext context) {
        return NotificationsBloc()..add(NewPostsReceived(2));
      },
      child: BlocBuilder<ApptabBloc, AppTab>(
        builder: (context, activeTab) {
          return Scaffold(
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
            //               style:
            //                   LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
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
            body: _tempMapBody(activeTab),
            bottomNavigationBar: AppTabNavigator(
              activeTab: activeTab,
              onTabSelected: (tab) =>
                  BlocProvider.of<ApptabBloc>(context).add(TabUpdated(tab)),
            ),
          );
        },
      ),
    );
  }
}
