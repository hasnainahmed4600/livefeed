import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:livefeed/theme.dart';
import 'package:fdottedline/fdottedline.dart';
import 'package:intl/intl.dart';
import 'package:livefeed/timeline_post/bloc/timeline_post_bloc.dart';
import 'package:livefeed/timeline_post/models/post_comment.dart';
import 'package:livefeed/timeline_post/screen/timeline_post_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostComments extends StatelessWidget {
  final List<PostComment> comments;

  PostComments(this.comments);

  @override
  Widget build(BuildContext context) {
    var commentWidgets = <Widget>[];

    for (int i = 0; i < comments.length; i++) {
      if (i == comments.length - 1) {
        commentWidgets.add(
          _CommentListItem(
            comments[i],
            isLast: true,
          ),
        );
      } else {
        commentWidgets.add(_CommentListItem(comments[i]));
      }
    }
    return BlocBuilder<TimelinePostBloc, TimelinePostState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ...commentWidgets,
            if (state.contributions.length < state.totalContributions)
              TextButton(
                onPressed: () => context
                    .read<TimelinePostBloc>()
                    .add(MoreContributionsRequested()),
                child: Text(
                  'See more contributions',
                  style: TextStyle(
                    color: LiveFeedTheme.theme.highlightColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

class _CommentListItem extends StatelessWidget {
  final PostComment postComment;
  final bool isLast;

  _CommentListItem(
    this.postComment, {
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 35,
          child: FDottedLine(
            height: isLast
                ? MediaQuery.of(context).size.height / 4.5
                : MediaQuery.of(context).size.height,
            strokeWidth: 2,
            dottedLength: 10,
            color: Colors.grey[400],
          ),
        ),
        if (isLast)
          Positioned(
            left: 35,
            bottom: 35,
            child: FDottedLine(
              width: 30,
              strokeWidth: 2,
              dottedLength: 7,
              color: Colors.grey[400],
            ),
          ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: LiveFeedTheme.theme.accentColor,
                ),
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      border: Border.all(width: 2.0, color: Colors.white),
                    ),
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(left: 11)),
              _CommentCard(
                postUserName: postComment.userName,
                userImagePath: postComment.imagePath,
                isNetworkImage: postComment.networkImage,
                postDate: postComment.postDate,
                postLocation: postComment.postLocation,
                comment: postComment.message,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CommentCard extends StatelessWidget {
  _CommentCard({
    this.postUserName = 'Sibabalwe Rubusana',
    this.userImagePath = 'assets/images/sibabalwe.png',
    this.isNetworkImage = false,
    DateTime postDate,
    this.postLocation = 'Chicago, IL 60606 (5 miles from you)',
    this.comment =
        'Texas, Alabama, Maine and Tennessee are allowing stay-at-home orders to expire.',
  }) : _postDate = postDate ??
            DateTime(DateTime.now().year, DateTime.now().month,
                DateTime.now().day - 1);
  final String postUserName;
  final String userImagePath;
  final bool isNetworkImage;
  final DateTime _postDate;
  final String postLocation;
  final String comment;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(TimelinePostScreen.route()),
      child: Container(
        width: MediaQuery.of(context).size.width / 1.2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          border: Border.all(width: 1.0, color: Colors.grey[400]),
          color: Colors.white,
        ),
        child: Column(
          children: [
            _CardHeader(
              postUserName,
              userImagePath,
              isNetworkImage,
              postLocation,
            ),
            _CardBody(
              comment,
              _postDate,
            )
          ],
        ),
      ),
    );
  }
}

class _CardHeader extends StatelessWidget {
  final String userName;
  final String userImagePath;
  final bool isNetworkImage;
  final String postLocation;

  _CardHeader(
    this.userName,
    this.userImagePath,
    this.isNetworkImage,
    this.postLocation,
  );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage(userImagePath),
          ),
          title: Text(
            userName,
            style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: RichText(
            text: TextSpan(
              style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
                fontWeight: FontWeight.w700,
                color: LiveFeedTheme.theme.highlightColor,
                fontSize: 12,
              ),
              children: <InlineSpan>[
                WidgetSpan(
                  child: Icon(
                    Icons.location_pin,
                    color: LiveFeedTheme.theme.highlightColor,
                    size: 15,
                  ),
                ),
                TextSpan(
                  text: postLocation,
                ),
              ],
            ),
          ),
          onTap: () {},
        ),
      ],
    );
  }
}

class _CardBody extends StatelessWidget {
  final String commentBody;
  final DateTime postDate;

  _CardBody(this.commentBody, this.postDate);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '"$commentBody"',
            style: TextStyle(
              fontStyle: FontStyle.italic,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 3)),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'See more...',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.italic,
                  color: LiveFeedTheme.theme.highlightColor,
                ),
              ),
            ],
          ),
          const Padding(padding: EdgeInsets.only(top: 10)),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                '${DateFormat.jm().format(postDate)} | ${DateFormat.d().format(postDate)} ${DateFormat.MMMM().format(postDate)} ${DateFormat.y().format(postDate)}',
                style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const Padding(padding: EdgeInsets.only(top: 10)),
        ],
      ),
    );
  }
}
