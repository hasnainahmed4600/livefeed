import 'package:equatable/equatable.dart';

enum SecurityQuestionType { what_pet, first_teacher }

class SecurityQuestionAnswer extends Equatable {
  SecurityQuestionAnswer({
    this.type,
    this.answer,
  });
  final SecurityQuestionType type;
  final String answer;

  SecurityQuestionAnswer copyWith({
    SecurityQuestionType type,
    String answer,
  }) {
    return SecurityQuestionAnswer(
      type: type ?? this.type,
      answer: answer ?? this.answer,
    );
  }

  @override
  List<Object> get props => [
        type,
        answer,
      ];
}
