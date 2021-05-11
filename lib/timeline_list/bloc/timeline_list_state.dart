part of 'timeline_list_bloc.dart';

class TimelineListState extends Equatable {
  const TimelineListState({
    this.totalPosts = 50,
    this.skip = 0,
    this.take = 10,
    this.posts = const [],
    this.adOffset = 4,
    this.activeVideoPostId,
    this.loadingError,
  });

  final int totalPosts;
  final int skip;
  final int take;
  final List<LiveFeedPost> posts;
  final int adOffset;
  final String activeVideoPostId;
  final String loadingError;

  TimelineListState copyWith({
    int totalPosts,
    int skip,
    int take,
    List<LiveFeedPost> posts,
    int adOffset,
    String activeVideoPostId,
    String loadingError,
  }) {
    return TimelineListState(
      totalPosts: totalPosts ?? this.totalPosts,
      skip: skip ?? this.skip,
      take: take ?? this.take,
      posts: posts ?? this.posts,
      adOffset: adOffset ?? this.adOffset,
      activeVideoPostId: activeVideoPostId ?? this.activeVideoPostId,
      loadingError: loadingError ?? this.loadingError,
    );
  }

  @override
  List<Object> get props => [
        totalPosts,
        skip,
        take,
        posts,
        adOffset,
        activeVideoPostId,
        loadingError,
      ];
}
