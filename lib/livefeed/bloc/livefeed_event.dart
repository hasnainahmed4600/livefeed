part of 'livefeed_bloc.dart';

abstract class LivefeedEvent extends Equatable {
  const LivefeedEvent();

  @override
  List<Object> get props => [];
}

class LivefeedLoaded extends LivefeedEvent {
  const LivefeedLoaded();
}

class ScrolledPastTopRollInThreshold extends LivefeedEvent {
  const ScrolledPastTopRollInThreshold();
}

class ScrolledIntoTopRollInThreshold extends LivefeedEvent {
  const ScrolledIntoTopRollInThreshold();
}

class EndOfLivefeedListReached extends LivefeedEvent {
  const EndOfLivefeedListReached();
}

class NewPostsStreamedIn extends LivefeedEvent {
  const NewPostsStreamedIn(this.posts);
  final List<LiveFeedPost> posts;

  @override
  List<Object> get props => [posts];
}

class StreamedPostsInserted extends LivefeedEvent {
  const StreamedPostsInserted();
}

class LoadedPostsInserted extends LivefeedEvent {
  const LoadedPostsInserted();
}
