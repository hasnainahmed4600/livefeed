import 'package:formz/formz.dart';

enum HeadlineValidationError { empty, tooLong }

class HeadlineFormField extends FormzInput<String, HeadlineValidationError> {
  const HeadlineFormField.pure() : super.pure('');

  const HeadlineFormField.dirty([String value = '']) : super.dirty(value);

  @override
  HeadlineValidationError validator(String value) {
    if (value?.isEmpty == true)
      return HeadlineValidationError.empty;
    else if (value?.length > 80)
      return HeadlineValidationError.tooLong;
    else
      return null;
  }

  String errorText() {
    if (this.invalid) {
      switch (this.error) {
        case HeadlineValidationError.empty:
          return 'This is required';
        case HeadlineValidationError.tooLong:
          return 'Only 80 characters allowed';
      }
    }
    return null;
  }
}
