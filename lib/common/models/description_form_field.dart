import 'package:formz/formz.dart';

enum DescriptionValidationError { empty, tooLong }

class DescriptionFormField
    extends FormzInput<String, DescriptionValidationError> {
  const DescriptionFormField.pure() : super.pure('');

  const DescriptionFormField.dirty([String value = '']) : super.dirty(value);

  @override
  DescriptionValidationError validator(String value) {
    if (value?.isEmpty == true)
      return DescriptionValidationError.empty;
    else if (value?.length > 2000)
      return DescriptionValidationError.tooLong;
    else
      return null;
  }

  String errorText() {
    if (this.invalid) {
      switch (this.error) {
        case DescriptionValidationError.empty:
          return 'This is required';
        case DescriptionValidationError.tooLong:
          return 'Up to 2000 characters allowed';
      }
    }
    return null;
  }
}
