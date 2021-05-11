import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:livefeed/common/models/livefeed_post.dart';
import 'package:livefeed/common/widgets/interest_search_filter.dart';
import 'package:livefeed/common/widgets/keyword_search_field.dart';
import 'package:livefeed/contact_us/models/contact_us_type_field.dart';
import 'package:livefeed/contact_us/screen/contact_us_screen.dart';
import 'package:livefeed/content_buyers/bloc/content_buyers_bloc.dart';
import 'package:livefeed/content_buyers/screen/content_buyers_post_card.dart';
import 'package:livefeed/content_buyers/screen/content_search_input.dart';
import 'package:livefeed/common/widgets/location_search_control.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:livefeed/theme.dart';

class ContentBuyersLayout extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ContentBuyersLayoutState();
}

class _ContentBuyersLayoutState extends State<ContentBuyersLayout> {
  ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = new ScrollController()..addListener(_scrollListener);
    super.initState();
  }

  void _scrollListener() {
    if (_scrollController.position.extentAfter < 200) {
      context.read<ContentBuyersBloc>().add(EndOfPostsReached());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContentBuyersBloc, ContentBuyersState>(
      builder: (context, state) {
        List<dynamic> listItems = [
          'keywordSearchField',
          'interestSearchFilter',
          'borderedLocationSearchControl'
        ];
        state.posts.forEach((post) {
          listItems.add(post);
        });
        return Container(
          color: LiveFeedTheme.screensBackgroundColor,
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: ListView.builder(
            controller: _scrollController,
            itemCount: listItems.length,
            itemBuilder: (context, index) {
              if (listItems[index] == 'keywordSearchField') {
                return Padding(
                  padding: EdgeInsets.only(top: 10),
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
              } else {
                final post = listItems[index] as LiveFeedPost;
                if (post.isVideoAsset) {
                  return Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: ContentBuyersVideoPostCard(
                      post,
                      post.id == state.activeVideoPostId,
                    ),
                  );
                } else {
                  return Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: ContentBuyersPostCard(post),
                  );
                }
              }
            },
          ),
        );

        // var contentItems = <Widget>[];
        // state.posts.forEach((post) {
        //   if (post.isVideoAsset) {
        //     contentItems.add(ContentBuyersVideoPostCard(
        //       post,
        //       post.id == state.activeVideoPostId,
        //     ));
        //   } else {
        //     contentItems.add(ContentBuyersPostCard(post));
        //   }
        //   contentItems.add(const Padding(padding: EdgeInsets.only(top: 20)));
        // });
        //
        // return SingleChildScrollView(
        //   controller: _scrollController,
        //   child: Padding(
        //     padding: EdgeInsets.symmetric(
        //       horizontal: 10,
        //       vertical: 10,
        //     ),
        //     child: Column(
        //       children: [
        //         // const Padding(padding: EdgeInsets.only(top: 10)),
        //         // MarketingHeader(),
        //         const Padding(padding: EdgeInsets.only(top: 10)),
        //         // ContentSearchInput(),
        //         KeywordSearchField(),
        //         const Padding(padding: EdgeInsets.only(top: 10)),
        //         InterestSearchFilter(),
        //         const Padding(padding: EdgeInsets.only(top: 20)),
        //         BorderedLocationSearchControl(),
        //         const Padding(padding: EdgeInsets.only(top: 20)),
        //         ...contentItems,
        //       ],
        //     ),
        //   ),
        // );
      },
    );
  }
}
