part of 'timeline_post_bloc.dart';

abstract class TimelinePostEvent extends Equatable {
  const TimelinePostEvent();

  @override
  List<Object> get props => [];
}

class PostLoaded extends TimelinePostEvent {
  const PostLoaded();
}

class MoreContributionsRequested extends TimelinePostEvent {
  const MoreContributionsRequested();
}
