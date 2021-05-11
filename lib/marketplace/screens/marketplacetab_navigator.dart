import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:livefeed/live_feed_keys.dart';
import 'package:livefeed/marketplace/bloc/marketplace_tab_bloc.dart';

class MarketplaceTabNavigator extends StatefulWidget {
  final MarketplaceTab activeTab;
  final Function(MarketplaceTab) onTabSelected;
  MarketplaceTabNavigator({
    Key key,
    @required this.activeTab,
    @required this.onTabSelected,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() => _MarketplaceTabNavigatorState(
      activeTab: activeTab, onTabSelected: onTabSelected);
}

class _MarketplaceTabNavigatorState extends State<MarketplaceTabNavigator>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  final MarketplaceTab activeTab;
  final Function(MarketplaceTab) onTabSelected;

  _MarketplaceTabNavigatorState({
    @required this.activeTab,
    @required this.onTabSelected,
  });

  @override
  void initState() {
    _tabController = new TabController(length: 2, vsync: this);
    super.initState();
  }

  Tab _mapNavigationBarItem(MarketplaceTab tab) {
    switch (tab) {
      case MarketplaceTab.content_buyers:
        return Tab(
          icon: Text(
            'Browse content',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        );
      case MarketplaceTab.content_creators:
        return Tab(
          icon: Text(
            'Content creators',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        );
      // case MarketplaceTab.how_it_works:
      //   return Tab(
      //     icon: Text(
      //       'How it works',
      //       textAlign: TextAlign.center,
      //       style: TextStyle(
      //         fontFamily: 'Montserrat',
      //         fontWeight: FontWeight.bold,
      //         color: Colors.white,
      //       ),
      //     ),
      //   );
      default:
        return Tab(
          icon: Text(
            'Browse content',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MarketplaceTabBloc, MarketplaceTab>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        _tabController.index = MarketplaceTab.values.indexOf(state);
        return TabBar(
          // type: BottomNavigationBarType.fixed,
          // showSelectedLabels: false,
          // showUnselectedLabels: false,
          key: LiveFeedKeys.homeTabs,
          controller: _tabController,
          // currentIndex: MarketplaceTab.values.indexOf(activeTab),
          onTap: (index) {
            onTabSelected(MarketplaceTab.values[index]);
          },
          indicatorColor: Colors.white,
          indicatorPadding: EdgeInsets.only(left: 20, right: 20),
          indicatorWeight: 2,
          indicatorSize: TabBarIndicatorSize.tab,
          isScrollable: false,
          tabs: MarketplaceTab.values.map((tab) {
            return _mapNavigationBarItem(tab);
          }).toList(),
          // items: MarketplaceTab.values.map((tab) {
          //   return _mapNavigationBarItem(tab);
          // }).toList(),
        );
      },
    );
  }
}
