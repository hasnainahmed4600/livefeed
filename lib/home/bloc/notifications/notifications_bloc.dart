import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  NotificationsBloc() : super(NotificationsState()) {
    _newEventTimer = Timer.periodic(
      Duration(seconds: 60),
      (timer) {
        add(NewPostsReceived(20));
      },
    );
  }

  Timer _newEventTimer;

  @override
  Stream<NotificationsState> mapEventToState(
    NotificationsEvent event,
  ) async* {
    if (event is PostSeen) {
      yield _mapPostSeenToState(event, state);
    } else if (event is NewPostsReceived) {
      yield _mapNewPostsReceivedToState(event, state);
    }
  }

  @override
  Future<void> close() {
    _newEventTimer.cancel();
    return super.close();
  }

  NotificationsState _mapNewPostsReceivedToState(
      NewPostsReceived event, NotificationsState state) {
    return state.copyWith(
      totalNewPosts: state.totalNewPosts + event.newPostsCount,
    );
  }

  NotificationsState _mapPostSeenToState(
      PostSeen event, NotificationsState state) {
    return state.copyWith(
      totalNewPosts: state.totalNewPosts - 1,
    );
  }
}
