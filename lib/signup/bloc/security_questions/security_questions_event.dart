part of 'security_questions_bloc.dart';

abstract class SecurityQuestionsEvent extends Equatable {
  const SecurityQuestionsEvent();

  @override
  List<Object> get props => [];
}

class SecurityQuestionsSubmitted extends SecurityQuestionsEvent {
  const SecurityQuestionsSubmitted();
}
