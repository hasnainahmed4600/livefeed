import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:livefeed/home/bloc/apptab/apptab_bloc.dart';
import 'package:livefeed/theme.dart';
import 'package:livefeed/timeline_post/screen/timeline_post_screen.dart';
import 'package:intl/intl.dart';

class PostsCard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PostCardsState();
}

class _PostCardsState extends State<PostsCard> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    if (expanded) {
      // return Container(
      //   decoration: BoxDecoration(
      //     borderRadius: BorderRadius.circular(4.0),
      //     border: Border.all(width: 1.0, color: Colors.grey[400]),
      //     color: Colors.white,
      //   ),
      //   child: Column(
      //     children: [
      //       _CardHeader(
      //         () {
      //           setState(() {
      //             this.expanded = !this.expanded;
      //           });
      //         },
      //         this.expanded,
      //       ),
      //       Divider(
      //         thickness: 2,
      //         height: 0,
      //       ),
      //       _PostsList(),
      //     ],
      //   ),
      // );
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          border: Border.all(width: 1.0, color: Colors.grey[400]),
          color: Colors.white,
        ),
        child: Column(
          children: [
            _CardHeader(
              () {
                setState(() {
                  this.expanded = !this.expanded;
                });
              },
              this.expanded,
            ),
            Divider(
              thickness: 2,
              height: 0,
            ),
            _PostList(),
          ],
        ),
      );
    } else {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          border: Border.all(width: 1.0, color: Colors.grey[400]),
          color: Colors.white,
        ),
        child: Column(
          children: [
            _CardHeader(
              () {
                setState(() {
                  this.expanded = !this.expanded;
                });
              },
              this.expanded,
            )
          ],
        ),
      );
    }
  }
}

class _CardHeader extends StatelessWidget {
  final Function onTap;
  final bool expanded;

  _CardHeader(this.onTap, this.expanded);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20),
      title: Text(
        'MY POSTS',
        style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
          color: Colors.grey[800],
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: Transform.rotate(
        angle: expanded ? pi / 2 : pi / -2,
        alignment: Alignment.center,
        child: Icon(
          Icons.chevron_left,
          color: LiveFeedTheme.theme.highlightColor,
          size: 32,
        ),
      ),
      onTap: this.onTap,
    );
  }
}

class _PostsList extends StatelessWidget {
  final Map posts = {
    'postId1': 'Post name 1',
    'postId2': 'Post name 2',
  };

  @override
  Widget build(BuildContext context) {
    return _PostsEmptyBody();
  }
}

class _PostsEmptyBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 25),
      child: Column(
        children: [
          Container(
            width: 38,
            height: 38,
            child: FittedBox(
              fit: BoxFit.fill,
              child: Image(
                image: AssetImage('assets/images/shocked.png'),
              ),
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 25)),
          Text(
            'Ugh.. It\'s so empty!',
            style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 20)),
          BlocBuilder<ApptabBloc, AppTab>(
            builder: (context, state) {
              return FlatButton(
                onPressed: () {
                  context.read<ApptabBloc>().add(TabUpdated(AppTab.addPost));
                },
                child: Text(
                  'ADD POST',
                  style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                color: LiveFeedTheme.theme.buttonColor,
              );
            },
          ),
        ],
      ),
    );
  }
}

class _PostList extends StatefulWidget {
  _PostList({
    DateTime postDate,
  }) : _postDate = postDate ??
            DateTime(DateTime.now().year, DateTime.now().month,
                DateTime.now().day - 1);
  final DateTime _postDate;

  @override
  State<StatefulWidget> createState() => _PostListState(postDate: _postDate);
}

class _PostListState extends State<_PostList> {
  _PostListState({
    DateTime postDate,
  }) : _postDate = postDate ??
            DateTime(DateTime.now().year, DateTime.now().month,
                DateTime.now().day - 1);
  final DateTime _postDate;
  List<Widget> posts = <Widget>[];

  @override
  void initState() {
    posts = <Widget>[
      _PostListItem(
        _postDate,
        'SPORTS',
        'assets/images/shoes.png',
        'New video shows Chicago officer shooting subway rider in back',
      ),
      _PostListItem(
        _postDate,
        'MASTER CLASS',
        'assets/images/shoes.png',
        'New video shows Chicago officer shooting subway rider in back',
      ),
      _PostListItem(
        _postDate,
        'POLITICS',
        'assets/images/shoes.png',
        'New video shows Chicago officer shooting subway rider in back',
        isVideo: true,
      ),
    ];
    super.initState();
  }

  void seeMore() {
    setState(() {
      posts.add(_PostListItem(
        _postDate,
        'SPORTS',
        'assets/images/shoes.png',
        'New video shows Chicago officer shooting subway rider in back',
      ));
      posts.add(_PostListItem(
        _postDate,
        'MASTER CLASS',
        'assets/images/shoes.png',
        'New video shows Chicago officer shooting subway rider in back',
      ));
      posts.add(_PostListItem(
        _postDate,
        'POLITICS',
        'assets/images/shoes.png',
        'New video shows Chicago officer shooting subway rider in back',
        isVideo: true,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    var mainColumn = Column(
      children: [
        const Padding(padding: EdgeInsets.only(top: 15)),
      ],
    );
    posts.forEach((post) {
      mainColumn.children.add(post);
      mainColumn.children.add(const Padding(padding: EdgeInsets.only(top: 15)));
    });
    mainColumn.children.add(
      GestureDetector(
        onTap: () => seeMore(),
        child: Text(
          'See more',
          style: TextStyle(
            color: LiveFeedTheme.theme.accentColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
    mainColumn.children.add(const Padding(
      padding: EdgeInsets.only(top: 15),
    ));
    return mainColumn;
  }
}

class _PostListItem extends StatelessWidget {
  _PostListItem(
    this.postedOn,
    this.category,
    this.imagePath,
    this.headline, {
    this.isVideo = false,
  });

  final DateTime postedOn;
  final String category;
  final String imagePath;
  final String headline;
  final bool isVideo;

  @override
  Widget build(BuildContext context) {
    var timeAgo =
        '${DateFormat.d().format(postedOn)} ${DateFormat.MMMM().format(postedOn)}';
    return GestureDetector(
      onTap: () => Navigator.of(context).push(TimelinePostScreen.route()),
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                        fit: BoxFit.fitHeight,
                        image: AssetImage(imagePath),
                      ),
                    ),
                    child: isVideo
                        ? Icon(
                            Icons.play_arrow_rounded,
                            color: Colors.white,
                            size: MediaQuery.of(context).size.width / 5,
                          )
                        : null,
                  ),
                ),
                const Padding(padding: EdgeInsets.only(left: 10)),
                Expanded(
                  child: ListTile(
                    contentPadding: EdgeInsets.all(0),
                    visualDensity: VisualDensity.standard,
                    title: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          category,
                          style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
                            color: LiveFeedTheme.theme.highlightColor,
                          ),
                        ),
                        Text(
                          timeAgo,
                          style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    subtitle: Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: RichText(
                        text: TextSpan(
                          text: headline,
                          style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: ' See more...',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.only(top: 15)),
            Divider(
              color: Colors.grey,
              thickness: 1,
              height: 1,
            ),
          ],
        ),
      ),
    );
  }
}
