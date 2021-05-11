import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:livefeed/common/models/livefeed_post.dart';

part 'timeline_list_event.dart';

part 'timeline_list_state.dart';

class TimelineListBloc extends Bloc<TimelineListEvent, TimelineListState> {
  TimelineListBloc() : super(TimelineListState());

  @override
  Stream<TimelineListState> mapEventToState(
    TimelineListEvent event,
  ) async* {
    if (event is TimelineListLoaded) {
      yield _mapTimelineListLoadedToState(event, state);
    } else if (event is EndOfListReached) {
      yield _mapEndOfListReachedToState(event, state);
    } else if (event is VideoPlayed) {
      yield _mapVideoPlayedToState(event, state);
    } else if (event is PostSeen) {
      yield _mapPostSeenToState(event, state);
    }
  }

  TimelineListState _mapTimelineListLoadedToState(
      TimelineListLoaded event, TimelineListState state) {
    List<LiveFeedPost> posts = [];
    for (int i = 1; i <= state.take; i++) {
      if (i % 2 == 0) {
        posts.add(LiveFeedPost(
          postDate:
              DateTime.now().subtract(Duration(minutes: Random().nextInt(200))),
          userName: 'Sibabalwe Rubusana',
          postHeadline:
              'As the coronavirus death toll rises in New York, the state’s funeral directors are',
          postLocation: 'Chicago, IL 60606 (5 miles from you)',
          assetPath:
              'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
          isNetworkAsset: false,
          isVideoAsset: true,
          videoAssetThumbnailUrl: 'assets/images/shoes.png',
        ));
      } else {
        posts.add(LiveFeedPost(
          postDate:
              DateTime.now().subtract(Duration(minutes: Random().nextInt(200))),
          userName: 'Sibabalwe Rubusana',
          postHeadline:
              'As the coronavirus death toll rises in New York, the state’s funeral directors are',
          postLocation: 'Chicago, IL 60606 (5 miles from you)',
          assetPath: 'assets/images/shoes.png',
          isNetworkAsset: false,
          isVideoAsset: false,
        ));
      }
    }

    return state.copyWith(
      skip: state.skip + state.take,
      posts: posts,
    );
    // return state.copyWith(
    //   posts: [
    //     LiveFeedPost(
    //       postDate:
    //           DateTime.now().subtract(Duration(minutes: Random().nextInt(200))),
    //       userName: 'Sibabalwe Rubusana',
    //       postHeadline:
    //           'As the coronavirus death toll rises in New York, the state’s funeral directors are',
    //       postLocation: 'Chicago, IL 60606 (5 miles from you)',
    //       assetPath: 'assets/images/shoes.png',
    //       isNetworkAsset: false,
    //       isVideoAsset: false,
    //     ),
    //     LiveFeedPost(
    //       postDate:
    //           DateTime.now().subtract(Duration(minutes: Random().nextInt(200))),
    //       userName: 'Sibabalwe Rubusana',
    //       postHeadline:
    //           'As the coronavirus death toll rises in New York, the state’s funeral directors are',
    //       postLocation: 'Chicago, IL 60606 (5 miles from you)',
    //       assetPath:
    //           'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    //       isNetworkAsset: false,
    //       isVideoAsset: true,
    //       videoAssetThumbnailUrl: 'assets/images/shoes.png',
    //     ),
    //     LiveFeedPost(
    //       postDate:
    //           DateTime.now().subtract(Duration(minutes: Random().nextInt(200))),
    //       userName: 'Sibabalwe Rubusana',
    //       postHeadline:
    //           'As the coronavirus death toll rises in New York, the state’s funeral directors are',
    //       postLocation: 'Chicago, IL 60606 (5 miles from you)',
    //       assetPath: 'assets/images/shoes.png',
    //       isNetworkAsset: false,
    //       isVideoAsset: false,
    //     ),
    //     LiveFeedPost(
    //       postDate:
    //           DateTime.now().subtract(Duration(minutes: Random().nextInt(200))),
    //       userName: 'Sibabalwe Rubusana',
    //       postHeadline:
    //           'As the coronavirus death toll rises in New York, the state’s funeral directors are',
    //       postLocation: 'Chicago, IL 60606 (5 miles from you)',
    //       assetPath:
    //           'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    //       isNetworkAsset: false,
    //       isVideoAsset: true,
    //       videoAssetThumbnailUrl: 'assets/images/shoes.png',
    //     ),
    //     LiveFeedPost(
    //       postDate:
    //           DateTime.now().subtract(Duration(minutes: Random().nextInt(200))),
    //       userName: 'Sibabalwe Rubusana',
    //       postHeadline:
    //           'As the coronavirus death toll rises in New York, the state’s funeral directors are',
    //       postLocation: 'Chicago, IL 60606 (5 miles from you)',
    //       assetPath: 'assets/images/shoes.png',
    //       isNetworkAsset: false,
    //       isVideoAsset: false,
    //     ),
    //     LiveFeedPost(
    //       postDate:
    //           DateTime.now().subtract(Duration(minutes: Random().nextInt(200))),
    //       userName: 'Sibabalwe Rubusana',
    //       postHeadline:
    //           'As the coronavirus death toll rises in New York, the state’s funeral directors are',
    //       postLocation: 'Chicago, IL 60606 (5 miles from you)',
    //       assetPath:
    //           'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    //       isNetworkAsset: false,
    //       isVideoAsset: true,
    //       videoAssetThumbnailUrl: 'assets/images/shoes.png',
    //     ),
    //     LiveFeedPost(
    //       postDate:
    //           DateTime.now().subtract(Duration(minutes: Random().nextInt(200))),
    //       userName: 'Sibabalwe Rubusana',
    //       postHeadline:
    //           'As the coronavirus death toll rises in New York, the state’s funeral directors are',
    //       postLocation: 'Chicago, IL 60606 (5 miles from you)',
    //       assetPath: 'assets/images/shoes.png',
    //       isNetworkAsset: false,
    //       isVideoAsset: false,
    //     ),
    //     LiveFeedPost(
    //       postDate:
    //           DateTime.now().subtract(Duration(minutes: Random().nextInt(200))),
    //       userName: 'Sibabalwe Rubusana',
    //       postHeadline:
    //           'As the coronavirus death toll rises in New York, the state’s funeral directors are',
    //       postLocation: 'Chicago, IL 60606 (5 miles from you)',
    //       assetPath:
    //           'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    //       isNetworkAsset: false,
    //       isVideoAsset: true,
    //       videoAssetThumbnailUrl: 'assets/images/shoes.png',
    //     ),
    //   ],
    // );
  }

  TimelineListState _mapEndOfListReachedToState(
      EndOfListReached event, TimelineListState state) {
    var tempPosts = [...state.posts];
    for (int i = 1;
        i <=
            (state.totalPosts - state.posts.length >= state.take
                ? state.take
                : state.totalPosts - state.posts.length);
        i++) {
      tempPosts.add(LiveFeedPost(
        postDate:
            DateTime.now().subtract(Duration(minutes: Random().nextInt(200))),
        userName: 'Sibabalwe Rubusana',
        postHeadline:
            'As the coronavirus death toll rises in New York, the state’s funeral directors are',
        postLocation: 'Chicago, IL 60606 (5 miles from you)',
        assetPath: 'assets/images/shoes.png',
        isNetworkAsset: false,
        isVideoAsset: false,
      ));
    }
    // tempPosts.addAll(
    //   [
    //     LiveFeedPost(
    //       postDate:
    //           DateTime.now().subtract(Duration(minutes: Random().nextInt(200))),
    //       userName: 'Sibabalwe Rubusana',
    //       postHeadline:
    //           'As the coronavirus death toll rises in New York, the state’s funeral directors are',
    //       postLocation: 'Chicago, IL 60606 (5 miles from you)',
    //       assetPath: 'assets/images/shoes.png',
    //       isNetworkAsset: false,
    //       isVideoAsset: false,
    //     ),
    //     // LiveFeedPost(
    //     //   id: '1',
    //     //   postDate: DateTime.now().subtract(Duration(minutes: 56)),
    //     //   userName: 'Sibabalwe Rubusana',
    //     //   postHeadline:
    //     //       'As the coronavirus death toll rises in New York, the state’s funeral directors are',
    //     //   postLocation: 'Chicago, IL 60606 (5 miles from you)',
    //     //   assetPath:
    //     //       'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    //     //   isNetworkAsset: false,
    //     //   isVideoAsset: true,
    //     // ),
    //   ],
    // );

    return state.copyWith(
      skip: state.skip + state.take,
      posts: tempPosts,
    );
  }

  TimelineListState _mapVideoPlayedToState(
      VideoPlayed event, TimelineListState state) {
    return state.copyWith(activeVideoPostId: event.postId);
  }

  TimelineListState _mapPostSeenToState(
      PostSeen event, TimelineListState state) {
    final tempPosts = [...state.posts].map((post) {
      if (post.id == event.postId) {
        return post.copyWith(seen: true);
      } else {
        return post;
      }
    }).toList();

    return state.copyWith(posts: tempPosts);
  }
}
