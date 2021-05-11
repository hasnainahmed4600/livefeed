import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:livefeed/common/models/livefeed_post.dart';

part 'content_buyers_event.dart';
part 'content_buyers_state.dart';

class ContentBuyersBloc extends Bloc<ContentBuyersEvent, ContentBuyersState> {
  ContentBuyersBloc() : super(ContentBuyersState());

  @override
  Stream<ContentBuyersState> mapEventToState(
    ContentBuyersEvent event,
  ) async* {
    if (event is PostsListLoaded) {
      yield _mapPostsListLoadedToState(event, state);
    } else if (event is EndOfPostsReached) {
      yield _mapEndOfPostsReachedToState(event, state);
    } else if (event is VideoPlayed) {
      yield _mapVideoPlayedToState(event, state);
    }
  }

  ContentBuyersState _mapPostsListLoadedToState(
      PostsListLoaded event, ContentBuyersState state) {
    return state.copyWith(
      posts: [
        LiveFeedPost(
          postDate:
              DateTime.now().subtract(Duration(minutes: Random().nextInt(200))),
          userName: 'Sibabalwe Rubusana',
          postHeadline:
              'As the coronavirus death toll rises in New York, the state’s funeral directors are',
          postLocation: 'Chicago, IL 60606 (5 miles from you)',
          assetPath: 'assets/images/shoes.png',
          isNetworkAsset: false,
          isVideoAsset: false,
        ),
        LiveFeedPost(
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
        ),
      ],
    );
  }

  ContentBuyersState _mapEndOfPostsReachedToState(
      EndOfPostsReached event, ContentBuyersState state) {
    var tempPosts = [...state.posts];
    tempPosts.addAll(
      [
        LiveFeedPost(
          postDate:
              DateTime.now().subtract(Duration(minutes: Random().nextInt(200))),
          userName: 'Sibabalwe Rubusana',
          postHeadline:
              'As the coronavirus death toll rises in New York, the state’s funeral directors are',
          postLocation: 'Chicago, IL 60606 (5 miles from you)',
          assetPath: 'assets/images/shoes.png',
          isNetworkAsset: false,
          isVideoAsset: false,
        ),
        LiveFeedPost(
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
        ),
      ],
    );

    return state.copyWith(posts: tempPosts);
  }

  ContentBuyersState _mapVideoPlayedToState(
      VideoPlayed event, ContentBuyersState state) {
    return state.copyWith(activeVideoPostId: event.postId);
  }
}
