import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'apptab_event.dart';

enum AppTab { profile, addPost, timeline, liveFeed }

class ApptabBloc extends Bloc<ApptabEvent, AppTab> {
  ApptabBloc() : super(AppTab.profile);

  @override
  Stream<AppTab> mapEventToState(
    ApptabEvent event,
  ) async* {
    if (event is TabUpdated) {
      yield event.tab;
    }
  }
}
