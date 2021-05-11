part of 'timeline_list_bloc.dart';

abstract class TimelineListEvent extends Equatable {
  const TimelineListEvent();

  @override
  List<Object> get props => [];
}

class TimelineListLoaded extends TimelineListEvent {
  const TimelineListLoaded();
}

class EndOfListReached extends TimelineListEvent {
  const EndOfListReached();
}

class VideoPlayed extends TimelineListEvent {
  const VideoPlayed(this.postId);
  final String postId;

  @override
  List<Object> get props => [postId];
}

class PostSeen extends TimelineListEvent {
  const PostSeen(this.postId);
  final String postId;

  @override
  List<Object> get props => [postId];
}
