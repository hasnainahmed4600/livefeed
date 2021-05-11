part of 'livefeed_bloc.dart';

class LivefeedState extends Equatable {
  const LivefeedState({
    this.existingPosts = const [],
    this.streamedPostsQueue = const [],
    this.loadedPostsQueue = const [],
    this.withinTopRollInThreshold = true,
    this.unrenderedTopPostsAvailable = false,
    this.loadingError,
  });

  final List<LiveFeedPost> existingPosts;
  final List<LiveFeedPost> streamedPostsQueue;
  final List<LiveFeedPost> loadedPostsQueue;
  final bool withinTopRollInThreshold;
  final bool unrenderedTopPostsAvailable;
  final String loadingError;

  LivefeedState copyWith({
    List<LiveFeedPost> existingPosts,
    List<LiveFeedPost> streamedPostsQueue,
    List<LiveFeedPost> loadedPostsQueue,
    bool withinTopRollInThreshold,
    bool unrenderedTopPostsAvailable,
    String loadingError,
  }) {
    return LivefeedState(
      existingPosts: existingPosts ?? this.existingPosts,
      streamedPostsQueue: streamedPostsQueue ?? this.streamedPostsQueue,
      loadedPostsQueue: loadedPostsQueue ?? this.loadedPostsQueue,
      withinTopRollInThreshold:
          withinTopRollInThreshold ?? this.withinTopRollInThreshold,
      unrenderedTopPostsAvailable:
          unrenderedTopPostsAvailable ?? this.unrenderedTopPostsAvailable,
      loadingError: loadingError ?? this.loadingError,
    );
  }

  @override
  List<Object> get props => [
        existingPosts,
        streamedPostsQueue,
        loadedPostsQueue,
        withinTopRollInThreshold,
        unrenderedTopPostsAvailable,
        loadingError,
      ];
}
