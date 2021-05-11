import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:livefeed/common/models/livefeed_post.dart';
import 'package:livefeed/common/widgets/interest_search_filter.dart';
import 'package:livefeed/common/widgets/keyword_search_field.dart';
import 'package:livefeed/common/widgets/location_search_control.dart';
import 'package:livefeed/home/bloc/apptab/apptab_bloc.dart';
import 'package:livefeed/home/screens/home_screen.dart';
import 'package:livefeed/theme.dart';
import 'package:livefeed/timeline_list/bloc/timeline_list_bloc.dart';
import 'package:livefeed/timeline_list/screen/ad_poster.dart';
import 'package:livefeed/timeline_list/screen/timeline_post_card.dart';

class TimelineListLayout extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TimelineListLayoutState();
}

class _TimelineListLayoutState extends State<TimelineListLayout> {
  ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = new ScrollController()..addListener(_scrollListener);
    super.initState();
  }

  void _scrollListener() {
    if (_scrollController.position.extentAfter < 200) {
      final state = context.read<TimelineListBloc>().state;
      if (state.posts.length < state.totalPosts) {
        context.read<TimelineListBloc>().add(EndOfListReached());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimelineListBloc, TimelineListState>(
      builder: (context, state) {
        List<dynamic> listItems = [
          'keywordSearchField',
          'interestSearchFilter',
          'borderedLocationSearchControl',
        ];
        for (int i = 0; i < state.posts.length; i++) {
          if (i % state.adOffset == 0 && i != 0) {
            listItems.add('adString');
          }
          listItems.add(state.posts[i]);
        }
        if (state.posts.length >= state.totalPosts)
          listItems.add('endOfListIndicator');

        return Container(
          color: LiveFeedTheme.screensBackgroundColor,
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: ListView.builder(
            controller: _scrollController,
            itemCount: listItems.length,
            itemBuilder: (context, index) {
              if (listItems[index] == 'keywordSearchField') {
                return Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: KeywordSearchField(),
                );
              } else if (listItems[index] == 'interestSearchFilter') {
                return Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: InterestSearchFilter(),
                );
              } else if (listItems[index] == 'borderedLocationSearchControl') {
                return Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: BorderedLocationSearchControl(),
                );
              }

              if (listItems[index] == 'adString') {
                return Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: AdPoster(),
                );
              } else if (listItems[index] is LiveFeedPost) {
                final postItem = listItems[index] as LiveFeedPost;
                if (postItem.isVideoAsset) {
                  return Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: TimelineVideoPostCard(
                      postItem,
                      state.activeVideoPostId == postItem.id,
                    ),
                  );
                } else {
                  return Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: TimelinePostCard(postItem),
                  );
                }
              } else {
                return TextButton(
                  onPressed: () {
                    // _scrollController
                    //     .animateTo(
                    //       0.0,
                    //       duration: Duration(seconds: 1),
                    //       curve: Curves.ease,
                    //     )
                    //     .then((value) => context
                    //         .read<TimelineListBloc>()
                    //         .add(TimelineListLoaded()));
                    context.read<ApptabBloc>().add(TabUpdated(AppTab.timeline));
                    Navigator.of(context).pushReplacement(HomeScreen.route());
                  },
                  child: Text(
                    'No more posts. Tap here to load fresh posts.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: LiveFeedTheme.theme.highlightColor,
                      fontSize: 15,
                    ),
                  ),
                );
              }
            },
          ),
        );

        // var posts = state.posts;
        // var adOffset = state.adOffset;
        // var mainColumn = Column(
        //   children: [
        //     const Padding(padding: EdgeInsets.only(top: 15)),
        //     KeywordSearchField(),
        //     const Padding(padding: EdgeInsets.only(top: 10)),
        //     InterestSearchFilter(),
        //     const Padding(padding: EdgeInsets.only(top: 20)),
        //     BorderedLocationSearchControl(),
        //   ],
        // );
        // for (int i = 0; i < posts.length; i++) {
        //   mainColumn.children
        //       .add(const Padding(padding: EdgeInsets.only(top: 15)));
        //   if (i % adOffset == 0 && i != 0) {
        //     mainColumn.children.add(AdPoster());
        //     mainColumn.children
        //         .add(const Padding(padding: EdgeInsets.only(top: 15)));
        //   }
        //
        //   if (posts[i].isVideoAsset) {
        //     mainColumn.children.add(TimelineVideoPostCard(
        //       posts[i],
        //       state.activeVideoPostId == posts[i].id,
        //     ));
        //   } else {
        //     mainColumn.children.add(TimelinePostCard(posts[i]));
        //   }
        // }
        // return SingleChildScrollView(
        //   controller: _scrollController,
        //   child: Container(
        //     color: LiveFeedTheme.screensBackgroundColor,
        //     child: Padding(
        //       padding: EdgeInsets.symmetric(horizontal: 10),
        //       child: mainColumn,
        //     ),
        //   ),
        // );
      },
    );
  }
}
