part of 'notifications_bloc.dart';

abstract class NotificationsEvent extends Equatable {
  const NotificationsEvent();

  @override
  List<Object> get props => [];
}

class NewPostsReceived extends NotificationsEvent {
  const NewPostsReceived(this.newPostsCount);
  final int newPostsCount;

  @override
  List<Object> get props => [
        newPostsCount,
      ];
}

/// This event is simply for updating the unseen posts count in UI. The change in backend is triggered by API function called in TimelinePostBloc event when user opens the post.
class PostSeen extends NotificationsEvent {
  const PostSeen();
}
