import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:livefeed/timeline_post/models/post_comment.dart';

part 'timeline_post_event.dart';

part 'timeline_post_state.dart';

class TimelinePostBloc extends Bloc<TimelinePostEvent, TimelinePostState> {
  TimelinePostBloc() : super(TimelinePostState());

  @override
  Stream<TimelinePostState> mapEventToState(
    TimelinePostEvent event,
  ) async* {
    if (event is PostLoaded) {
      yield _mapPostLoadedToState(event, state);
    } else if (event is MoreContributionsRequested) {
      yield _mapMoreContributionsRequestedToState(event, state);
    }
  }

  TimelinePostState _mapPostLoadedToState(
      PostLoaded event, TimelinePostState state) {
    List<PostComment> comments = [];
    for (int i = 1; i <= state.takeContributions; i++) {
      comments.add(
        PostComment(
          userName: 'Sibabalwe Rubusana',
          imagePath: 'assets/images/sibabalwe.png',
          message:
              'Texas, Alabama, Maine and Tennessee are allowing stay-at-home orders to expire.',
          postDate: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day - 1),
          postLocation: 'Chicago, IL 60606 (5 miles from you)',
        ),
      );
    }

    return state.copyWith(
      skipContributions: state.takeContributions,
      totalContributions: 22,
      contributions: comments,
    );
  }

  TimelinePostState _mapMoreContributionsRequestedToState(
      MoreContributionsRequested event, TimelinePostState state) {
    var tempContributions = [...state.contributions];
    for (int i = 1;
        i <=
            (state.totalContributions - state.contributions.length >=
                    state.takeContributions
                ? state.takeContributions
                : state.totalContributions - state.contributions.length);
        i++) {
      tempContributions.add(
        PostComment(
          userName: 'Sibabalwe Rubusana',
          imagePath: 'assets/images/sibabalwe.png',
          message:
              'Texas, Alabama, Maine and Tennessee are allowing stay-at-home orders to expire.',
          postDate: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day - 1),
          postLocation: 'Chicago, IL 60606 (5 miles from you)',
        ),
      );
    }

    return state.copyWith(
      skipContributions: state.skipContributions + state.takeContributions,
      contributions: tempContributions,
    );
  }
}
