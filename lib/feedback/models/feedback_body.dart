import 'package:formz/formz.dart';

enum FeedbackBodyValidationError { empty, maxLimit }

class FeedbackBody extends FormzInput<String, FeedbackBodyValidationError> {
  const FeedbackBody.pure() : super.pure('');
  const FeedbackBody.dirty([String value = '']) : super.dirty(value);

  @override
  FeedbackBodyValidationError validator(String value) {
    return value?.isNotEmpty == true ? null : FeedbackBodyValidationError.empty;
  }
}
