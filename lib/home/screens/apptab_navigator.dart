import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:livefeed/home/bloc/apptab/apptab_bloc.dart';
import 'package:livefeed/home/bloc/notifications/notifications_bloc.dart';
import 'package:livefeed/live_feed_keys.dart';
import 'package:livefeed/theme.dart';

class AppTabNavigator extends StatefulWidget {
  final AppTab activeTab;
  final Function(AppTab) onTabSelected;

  AppTabNavigator({
    Key key,
    @required this.activeTab,
    @required this.onTabSelected,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      _AppTabNavigatorState(activeTab: activeTab, onTabSelected: onTabSelected);
}

class _AppTabNavigatorState extends State<AppTabNavigator>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  final AppTab activeTab;
  final Function(AppTab) onTabSelected;

  _AppTabNavigatorState({
    @required this.activeTab,
    @required this.onTabSelected,
  });

  @override
  void initState() {
    _tabController = new TabController(length: 4, vsync: this);
    super.initState();
  }

  Tab _mapNavigationBarItem(AppTab tab) {
    switch (tab) {
      case AppTab.profile:
        return Tab(
          icon: Text(
            'Profile',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        );
      case AppTab.addPost:
        return Tab(
          icon: Text(
            'Add Post',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        );
      case AppTab.timeline:
        return Tab(
          icon: BlocBuilder<NotificationsBloc, NotificationsState>(
            buildWhen: (previous, current) =>
                previous.totalNewPosts != current.totalNewPosts &&
                current.totalNewPosts <= 102,
            builder: (context, state) {
              if (state.totalNewPosts == 0) {
                return Text(
                  'Timeline',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                );
              } else {
                var badgeText = state.totalNewPosts > 99
                    ? '99+'
                    : state.totalNewPosts.toString();

                // if (state.totalNewPosts < 9) {
                //   badgeText = '${state.totalNewPosts.toString()}  ';
                // } else if (state.totalNewPosts > 9 &&
                //     state.totalNewPosts < 99) {
                //   badgeText = '${state.totalNewPosts.toString()} ';
                // } else if (state.totalNewPosts > 99) {
                //   badgeText = '99+';
                // }

                return Badge(
                  badgeContent: Container(
                    width: 12,
                    height: 12,
                    child: FittedBox(
                      child: Text(
                        badgeText,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  toAnimate: false,
                  badgeColor: LiveFeedTheme.theme.accentColor,
                  position: BadgePosition.topEnd(top: -15),
                  child: Text(
                    'Timeline',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                );
              }

              // return Row(
              //   children: [
              //     Icon(
              //       Icons.circle,
              //       color: LiveFeedTheme.theme.accentColor,
              //       size: 13,
              //     ),
              //     const Padding(
              //       padding: EdgeInsets.only(left: 5),
              //     ),
              //     Text(
              //       'Timeline',
              //       style: TextStyle(
              //         fontWeight: FontWeight.bold,
              //         color: Colors.black,
              //       ),
              //     ),
              //   ],
              // );
            },
          ),
        );
      case AppTab.liveFeed:
        return Tab(
          icon: Text(
            'LiveFEED',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        );
      default:
        return Tab(
          icon: Text(
            'Profile',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApptabBloc, AppTab>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        _tabController.index = AppTab.values.indexOf(state);
        return TabBar(
          // type: BottomNavigationBarType.fixed,
          // showSelectedLabels: false,
          // showUnselectedLabels: false,
          key: LiveFeedKeys.homeTabs,
          controller: _tabController,
          // currentIndex: AppTab.values.indexOf(activeTab),
          onTap: (index) {
            onTabSelected(AppTab.values[index]);
          },
          labelPadding: EdgeInsets.symmetric(horizontal: 10),
          indicatorColor: LiveFeedTheme.theme.accentColor,
          indicatorPadding: EdgeInsets.only(left: 20, right: 20),
          indicatorWeight: 8,
          indicatorSize: TabBarIndicatorSize.tab,
          isScrollable: false,
          tabs: AppTab.values.map((tab) {
            return _mapNavigationBarItem(tab);
          }).toList(),
          // items: AppTab.values.map((tab) {
          //   return _mapNavigationBarItem(tab);
          // }).toList(),
        );
      },
    );
  }
}
