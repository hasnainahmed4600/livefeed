import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:livefeed/common/models/livefeed_post.dart';
import 'package:livefeed/livefeed/bloc/livefeed_bloc.dart';
import 'package:livefeed/theme.dart';
import 'package:livefeed/timeline_post/screen/timeline_post_screen.dart';

class LivefeedList extends StatelessWidget {
  LivefeedList(this.scrollController);

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LivefeedBloc, LivefeedState>(
      listener: (context, state) {
        if (state.withinTopRollInThreshold &&
            state.streamedPostsQueue.length > 0) {
          context.read<LivefeedBloc>().add(StreamedPostsInserted());
        }
        if (state.loadedPostsQueue.length > 0) {
          context.read<LivefeedBloc>().add(LoadedPostsInserted());
        }
      },
      child: BlocBuilder<LivefeedBloc, LivefeedState>(
        builder: (context, builderState) {
          return ListView.builder(
            controller: scrollController,
            itemCount: builderState.existingPosts.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(top: 15),
                child: _LivefeedListItem(builderState.existingPosts[index]),
              );
            },
          );
          // var columnChildren = <Widget>[];
          //
          // builderState.existingPosts.forEach((post) {
          //   columnChildren.add(_LivefeedListItem(post));
          //   columnChildren
          //       .add(const Padding(padding: EdgeInsets.only(top: 15)));
          // });
          //
          // return Column(
          //   children: [
          //     const Padding(padding: EdgeInsets.only(top: 15)),
          //     ...columnChildren,
          //   ],
          // );
        },
      ),
    );
  }
}

class _LivefeedListItem extends StatelessWidget {
  _LivefeedListItem(
    this.post,
  );

  final LiveFeedPost post;

  @override
  Widget build(BuildContext context) {
    final postedOn = post.postDate;
    var timeAgo = '';
    if (DateTime.now().difference(postedOn).inMinutes <= 5) {
      timeAgo = 'Just now';
    } else if (DateTime.now().difference(postedOn).inMinutes <= 59) {
      timeAgo = '${DateTime.now().difference(postedOn).inMinutes} minutes ago';
    } else if (DateTime.now().difference(postedOn).inHours < 24) {
      if (DateTime.now().difference(postedOn).inHours > 1)
        timeAgo = '${DateTime.now().difference(postedOn).inHours} hours ago';
      else
        timeAgo = '${DateTime.now().difference(postedOn).inHours} hour ago';
    } else if (DateTime.now().difference(postedOn).inHours > 24 &&
        DateTime.now().difference(postedOn).inHours < 730.001) {
      if (DateTime.now().difference(postedOn).inDays > 1)
        timeAgo = '${DateTime.now().difference(postedOn).inDays} days ago';
      else
        timeAgo = '${DateTime.now().difference(postedOn).inDays} day ago';
    } else {
      if (DateTime.now().difference(postedOn).inDays / 30 > 1)
        timeAgo =
            '${DateTime.now().difference(postedOn).inDays / 30} months ago';
      else
        timeAgo =
            '${DateTime.now().difference(postedOn).inDays / 30} month ago';
    }

    return Padding(
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
                      image: AssetImage(
                        post.isVideoAsset
                            ? post.videoAssetThumbnailUrl
                            : post.assetPath,
                      ),
                    ),
                  ),
                  child: post.isVideoAsset
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
                  title: Column(
                    // spacing: 15,
                    // runSpacing: 5,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 25,
                        child: FlatButton(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                            side: BorderSide(
                              width: 1,
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {},
                          child: Wrap(
                            // crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Icon(
                                Icons.location_pin,
                                size: 15,
                                color: Colors.white,
                              ),
                              Text(
                                post.postLocation,
                                style: LiveFeedTheme.theme.textTheme.bodyText1
                                    .copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(top: 5)),
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
                    padding: EdgeInsets.only(top: 5),
                    child: GestureDetector(
                      onTap: () => Navigator.of(context)
                          .push(TimelinePostScreen.route()),
                      child: RichText(
                        text: TextSpan(
                          text: post.postHeadline,
                          style:
                              LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
                            color: Colors.white,
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
    );
  }
}
