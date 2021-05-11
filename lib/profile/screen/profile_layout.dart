import 'package:flutter/material.dart';
import 'package:livefeed/profile/screen/details_card.dart';
import 'package:livefeed/profile/screen/interests_card.dart';
import 'package:livefeed/profile/screen/legal_card.dart';
import 'package:livefeed/profile/screen/posts_card.dart';
import 'package:livefeed/theme.dart';

class ProfileLayout extends StatelessWidget {
  final ScrollController _scrollController = new ScrollController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Container(
        color: LiveFeedTheme.screensBackgroundColor,
        child: Column(
          children: [
            const Padding(padding: EdgeInsets.only(top: 15)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: DetailsCard(),
            ),
            const Padding(padding: EdgeInsets.only(top: 20)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: InterestCard(
                  // onInterestSearchFocused: () => _scrollController.animateTo(
                  //   _scrollController.position.extentAfter + 30.0,
                  //   duration: Duration(seconds: 1),
                  //   curve: Curves.ease,
                  // ),
                  ),
            ),
            const Padding(padding: EdgeInsets.only(top: 20)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: PostsCard(),
            ),
            const Padding(padding: EdgeInsets.only(top: 20)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: LegalCard(),
            ),
            const Padding(padding: EdgeInsets.only(top: 15)),
            // const Padding(padding: EdgeInsets.only(top: 20)),
            // LegalFooter(),
          ],
        ),
      ),
    );
  }
}
