part of 'content_buyers_bloc.dart';

class ContentBuyersState extends Equatable {
  const ContentBuyersState({
    this.posts = const [],
    this.activeVideoPostId,
    this.loadingError,
  });

  final List<LiveFeedPost> posts;
  final String activeVideoPostId;
  final String loadingError;

  ContentBuyersState copyWith({
    List<LiveFeedPost> posts,
    String activeVideoPostId,
    String loadingError,
  }) {
    return ContentBuyersState(
      posts: posts ?? this.posts,
      activeVideoPostId: activeVideoPostId ?? this.activeVideoPostId,
      loadingError: loadingError ?? this.loadingError,
    );
  }

  @override
  List<Object> get props => [posts, activeVideoPostId, loadingError];
}
