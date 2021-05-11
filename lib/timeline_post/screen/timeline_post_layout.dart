import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:livefeed/contribute_to_post/screen/contribute_to_post_screen.dart';
import 'package:livefeed/home/screens/home_screen.dart';
import 'package:livefeed/timeline_list/bloc/timeline_list_bloc.dart';
import 'package:livefeed/timeline_post/bloc/timeline_post_bloc.dart';
import 'package:livefeed/timeline_post/models/post_comment.dart';
import 'package:livefeed/timeline_post/screen/post_comments.dart';
import 'package:livefeed/timeline_post/screen/post_detail_card.dart';
import 'package:livefeed/theme.dart';
import 'package:fdottedline/fdottedline.dart';
import 'package:livefeed/timeline_post/screen/recommendations_panel.dart';
import 'package:livefeed/timeline_list/screen/ad_poster.dart';

class TimelinePostLayout extends StatelessWidget {
  // final List<PostComment> comments = const [];

  final List<PostComment> comments = [
    PostComment(
      userName: 'Sibabalwe Rubusana',
      imagePath: 'assets/images/sibabalwe.png',
      message:
          'Texas, Alabama, Maine and Tennessee are allowing stay-at-home orders to expire.',
      postDate: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day - 1),
      postLocation: 'Chicago, IL 60606 (5 miles from you)',
    ),
    PostComment(
      userName: 'Abayo Landu',
      imagePath: 'assets/images/landu.png',
      message:
          'Texas, Alabama, Maine and Tennessee are allowing stay-at-home orders to expire.',
      postDate: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day - 1),
      postLocation: 'Chicago, IL 60606 (5 miles from you)',
    ),
    PostComment(
      userName: 'Sibabalwe Rubusana',
      imagePath: 'assets/images/sibabalwe.png',
      message:
          'Texas, Alabama, Maine and Tennessee are allowing stay-at-home orders to expire.',
      postDate: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day - 1),
      postLocation: 'Chicago, IL 60606 (5 miles from you)',
    ),
    PostComment(
      userName: 'Abayo Landu',
      imagePath: 'assets/images/landu.png',
      message:
          'Texas, Alabama, Maine and Tennessee are allowing stay-at-home orders to expire.',
      postDate: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day - 1),
      postLocation: 'Chicago, IL 60606 (5 miles from you)',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimelinePostBloc, TimelinePostState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Container(
            color: LiveFeedTheme.screensBackgroundColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _BackButton(),
                PostDetailCard(),
                if (state.contributions.isNotEmpty) _ContributeButton(),
                if (state.contributions.isNotEmpty) PostComments(state.contributions),
                if (state.contributions.isEmpty) _NoContributionsPanel(),
                RecommendationsPanel(),
                const Padding(padding: EdgeInsets.only(top: 20)),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _BackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 10,
      ),
      child: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: Row(
          children: [
            Icon(
              Icons.chevron_left,
              color: LiveFeedTheme.theme.accentColor,
            ),
            const Padding(padding: EdgeInsets.only(left: 5)),
            Text(
              'BACK',
              style: TextStyle(
                color: LiveFeedTheme.theme.accentColor,
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NoContributionsPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: GestureDetector(
        onTap: () => Navigator.of(context).push(ContributeToPostScreen.route()),
        behavior: HitTestBehavior.opaque,
        child: Column(
          children: [
            Icon(
              Icons.warning_rounded,
              color: Colors.grey,
            ),
            Text(
              'No Contributions',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            Text(
              'You can contribute here',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: LiveFeedTheme.theme.highlightColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ContributeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 10,
          ),
          child: GestureDetector(
            onTap: () =>
                Navigator.of(context).push(ContributeToPostScreen.route()),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.edit,
                  color: LiveFeedTheme.theme.highlightColor,
                ),
                const Padding(padding: EdgeInsets.only(left: 5)),
                Text(
                  'CONTRIBUTE TO THIS POST',
                  style: TextStyle(
                    color: LiveFeedTheme.theme.highlightColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: 35,
          child: FDottedLine(
            height: MediaQuery.of(context).size.height,
            strokeWidth: 2,
            dottedLength: 10,
            color: Colors.grey[400],
          ),
        ),
      ],
    );
  }
}
