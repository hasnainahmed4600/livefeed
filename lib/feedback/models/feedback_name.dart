import 'package:formz/formz.dart';

enum FeedbackNameValidationError { empty, maxLimit }

class FeedbackName extends FormzInput<String, FeedbackNameValidationError> {
  const FeedbackName.pure() : super.pure('');
  const FeedbackName.dirty([String value = '']) : super.dirty(value);

  @override
  FeedbackNameValidationError validator(String value) {
    return value?.isNotEmpty == true ? null : FeedbackNameValidationError.empty;
  }
}
