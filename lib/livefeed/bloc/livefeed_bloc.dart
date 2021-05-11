import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:livefeed/common/models/livefeed_post.dart';

part 'livefeed_event.dart';
part 'livefeed_state.dart';

class LivefeedBloc extends Bloc<LivefeedEvent, LivefeedState> {
  LivefeedBloc() : super(LivefeedState()) {
    _newEventTimer = new Timer.periodic(Duration(seconds: 3), (timer) {
      add(NewPostsStreamedIn(
        [
          LiveFeedPost(
            postDate: DateTime.now()
                .subtract(Duration(minutes: Random().nextInt(200))),
            userName: 'FROM STREAM Sibabalwe Rubusana',
            postHeadline:
                'As the coronavirus death toll rises in New York, the state’s funeral directors are',
            postLocation: 'Chicago, Illinois 60606',
            assetPath: 'assets/images/shoes.png',
            isNetworkAsset: false,
            isVideoAsset: false,
          ),
          LiveFeedPost(
            postDate: DateTime.now()
                .subtract(Duration(minutes: Random().nextInt(200))),
            userName: 'FROM STREAM Sibabalwe Rubusana',
            postHeadline:
                'As the coronavirus death toll rises in New York, the state’s funeral directors are',
            postLocation: 'Chicago, IL 60606',
            assetPath:
                'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
            isNetworkAsset: false,
            isVideoAsset: true,
            videoAssetThumbnailUrl: 'assets/images/shoes.png',
          ),
        ],
      ));
    });
  }

  Timer _newEventTimer;

  @override
  Stream<LivefeedState> mapEventToState(
    LivefeedEvent event,
  ) async* {
    if (event is LivefeedLoaded) {
      yield _mapLivefeedLoadedToState(event, state);
    } else if (event is NewPostsStreamedIn) {
      yield _mapNewPostsStreamedInToState(event, state);
    } else if (event is EndOfLivefeedListReached) {
      yield _mapEndOfLivefeedListReachedToState(event, state);
    } else if (event is ScrolledPastTopRollInThreshold) {
      yield _mapScrolledPastRollInThresholdToState(event, state);
    } else if (event is ScrolledIntoTopRollInThreshold) {
      yield _mapScrolledIntoRollInThresholdToState(event, state);
    } else if (event is StreamedPostsInserted) {
      yield _mapStreamedPostsInsertedToState(event, state);
    } else if (event is LoadedPostsInserted) {
      yield _mapLoadedPostsInsertedToState(event, state);
    }
  }

  @override
  Future<void> close() {
    _newEventTimer.cancel();
    return super.close();
  }

  LivefeedState _mapLivefeedLoadedToState(
      LivefeedLoaded event, LivefeedState state) {
    var tempPosts = [
      LiveFeedPost(
        postDate:
            DateTime.now().subtract(Duration(minutes: Random().nextInt(200))),
        userName: 'Sibabalwe Rubusana',
        postHeadline:
            'As the coronavirus death toll rises in New York, the state’s funeral directors are',
        postLocation: 'Chicago, IL 60606',
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
        postLocation: 'Chicago, IL 60606',
        assetPath:
            'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
        isNetworkAsset: false,
        isVideoAsset: true,
        videoAssetThumbnailUrl: 'assets/images/shoes.png',
      ),
      LiveFeedPost(
        postDate:
            DateTime.now().subtract(Duration(minutes: Random().nextInt(200))),
        userName: 'Sibabalwe Rubusana',
        postHeadline:
            'As the coronavirus death toll rises in New York, the state’s funeral directors are',
        postLocation: 'Chicago, IL 60606',
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
        postLocation: 'Chicago, IL 60606',
        assetPath:
            'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
        isNetworkAsset: false,
        isVideoAsset: true,
        videoAssetThumbnailUrl: 'assets/images/shoes.png',
      ),
      LiveFeedPost(
        postDate:
            DateTime.now().subtract(Duration(minutes: Random().nextInt(200))),
        userName: 'Sibabalwe Rubusana',
        postHeadline:
            'As the coronavirus death toll rises in New York, the state’s funeral directors are',
        postLocation: 'Chicago, IL 60606',
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
        postLocation: 'Chicago, IL 60606',
        assetPath:
            'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
        isNetworkAsset: false,
        isVideoAsset: true,
        videoAssetThumbnailUrl: 'assets/images/shoes.png',
      ),
      LiveFeedPost(
        postDate:
            DateTime.now().subtract(Duration(minutes: Random().nextInt(200))),
        userName: 'Sibabalwe Rubusana',
        postHeadline:
            'As the coronavirus death toll rises in New York, the state’s funeral directors are',
        postLocation: 'Chicago, IL 60606',
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
        postLocation: 'Chicago, IL 60606',
        assetPath:
            'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
        isNetworkAsset: false,
        isVideoAsset: true,
        videoAssetThumbnailUrl: 'assets/images/shoes.png',
      ),
    ];

    tempPosts.sort((b, a) => a.postDate.compareTo(b.postDate));

    return state.copyWith(
      loadedPostsQueue: tempPosts,
    );
  }

  LivefeedState _mapEndOfLivefeedListReachedToState(
      EndOfLivefeedListReached event, LivefeedState state) {
    var tempPosts = [...state.loadedPostsQueue];

    tempPosts.sort((b, a) => a.postDate.compareTo(b.postDate));

    tempPosts.addAll(
      [
        LiveFeedPost(
          postDate:
              DateTime.now().subtract(Duration(minutes: Random().nextInt(200))),
          userName: 'Sibabalwe Rubusana',
          postHeadline:
              'As the coronavirus death toll rises in New York, the state’s funeral directors are',
          postLocation: 'Chicago, IL 60606',
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
          postLocation: 'Chicago, IL 60606',
          assetPath:
              'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
          isNetworkAsset: false,
          isVideoAsset: true,
          videoAssetThumbnailUrl: 'assets/images/shoes.png',
        ),
        LiveFeedPost(
          postDate:
              DateTime.now().subtract(Duration(minutes: Random().nextInt(200))),
          userName: 'Sibabalwe Rubusana',
          postHeadline:
              'As the coronavirus death toll rises in New York, the state’s funeral directors are',
          postLocation: 'Chicago, IL 60606',
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
          postLocation: 'Chicago, IL 60606',
          assetPath:
              'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
          isNetworkAsset: false,
          isVideoAsset: true,
          videoAssetThumbnailUrl: 'assets/images/shoes.png',
        ),
      ],
    );

    return state.copyWith(
      loadedPostsQueue: tempPosts,
      // unrenderedPostsAvailable: !state.withinRollInThreshold,
    );
  }

  LivefeedState _mapScrolledPastRollInThresholdToState(
      ScrolledPastTopRollInThreshold event, LivefeedState state) {
    return state.copyWith(
      withinTopRollInThreshold: false,
    );
  }

  LivefeedState _mapScrolledIntoRollInThresholdToState(
      ScrolledIntoTopRollInThreshold event, LivefeedState state) {
    return state.copyWith(withinTopRollInThreshold: true);
  }

  LivefeedState _mapNewPostsStreamedInToState(
      NewPostsStreamedIn event, LivefeedState state) {
    var tempPosts = [
      ...event.posts,
      ...state.streamedPostsQueue,
    ];

    var eventPostIds = event.posts.map((e) => e.id).toList();
    var statePostIds = state.existingPosts.map((e) => e.id).toList();

    tempPosts.sort((b, a) => a.postDate.compareTo(b.postDate));

    return state.copyWith(
      streamedPostsQueue: tempPosts,
      unrenderedTopPostsAvailable: !state.withinTopRollInThreshold,
    );
  }

  LivefeedState _mapStreamedPostsInsertedToState(
      StreamedPostsInserted event, LivefeedState state) {
    var tempPosts = [
      ...state.streamedPostsQueue,
      ...state.existingPosts,
    ];

    tempPosts.sort((b, a) => a.postDate.compareTo(b.postDate));

    return state.copyWith(
      existingPosts: tempPosts,
      unrenderedTopPostsAvailable: false,
      streamedPostsQueue: const [],
    );
  }

  LivefeedState _mapLoadedPostsInsertedToState(
      LoadedPostsInserted event, LivefeedState state) {
    var tempPosts = [
      ...state.loadedPostsQueue,
      ...state.existingPosts,
    ];

    tempPosts.sort((b, a) => a.postDate.compareTo(b.postDate));

    return state.copyWith(
      existingPosts: tempPosts,
      loadedPostsQueue: const [],
    );
  }
}
