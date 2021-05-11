import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:repository_core/repository_core.dart';

part 'security_questions_event.dart';
part 'security_questions_state.dart';

class SecurityQuestionsBloc
    extends Bloc<SecurityQuestionsEvent, SecurityQuestionsState> {
  SecurityQuestionsBloc() : super(SecurityQuestionsState());

  @override
  Stream<SecurityQuestionsState> mapEventToState(
    SecurityQuestionsEvent event,
  ) async* {
    if (event is SecurityQuestionsSubmitted) {
      yield _mapSecurityQuestionsSubmittedToState(event, state);
    }
  }

  SecurityQuestionsState _mapSecurityQuestionsSubmittedToState(
      SecurityQuestionsSubmitted event, SecurityQuestionsState state) {
    return state.copyWith(status: FormzStatus.submissionSuccess);
  }
}
