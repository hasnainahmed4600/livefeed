part of 'content_buyers_bloc.dart';

abstract class ContentBuyersEvent extends Equatable {
  const ContentBuyersEvent();

  @override
  List<Object> get props => [];
}

class PostsListLoaded extends ContentBuyersEvent {
  const PostsListLoaded();
}

class EndOfPostsReached extends ContentBuyersEvent {
  const EndOfPostsReached();
}

class VideoPlayed extends ContentBuyersEvent {
  const VideoPlayed(this.postId);
  final String postId;

  @override
  List<Object> get props => [postId];
}
