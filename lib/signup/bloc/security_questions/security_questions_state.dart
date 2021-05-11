part of 'security_questions_bloc.dart';

class SecurityQuestionsState extends Equatable {
  const SecurityQuestionsState({
    this.securityQuestions = const [],
    this.status = FormzStatus.pure,
  });

  final List<SecurityQuestionAnswer> securityQuestions;
  final FormzStatus status;

  SecurityQuestionsState copyWith({
    List<SecurityQuestionAnswer> securityQuestions,
    FormzStatus status,
  }) {
    return SecurityQuestionsState(
      securityQuestions: securityQuestions ?? this.securityQuestions,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [securityQuestions, status];
}
