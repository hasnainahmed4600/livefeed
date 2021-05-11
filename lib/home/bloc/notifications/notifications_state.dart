part of 'notifications_bloc.dart';

class NotificationsState extends Equatable {
  const NotificationsState({
    this.totalNewPosts = 0,
  });

  final int totalNewPosts;

  NotificationsState copyWith({
    int totalNewPosts,
  }) {
    return NotificationsState(
      totalNewPosts: totalNewPosts ?? this.totalNewPosts,
    );
  }

  @override
  List<Object> get props => [
        totalNewPosts,
      ];
}
