import 'package:formz/formz.dart';

enum PhoneNumberValidationError { empty, invalid, tooShort, tooLong }

class PhoneNumberFormField extends FormzInput<String, PhoneNumberValidationError> {
  const PhoneNumberFormField.pure() : super.pure('');
  const PhoneNumberFormField.dirty([String value = '']) : super.dirty(value);

  @override
  PhoneNumberValidationError validator(String value) {
    final isNumeric = RegExp(r'^[0-9]+$').hasMatch(value);
    if (value?.isNotEmpty == true) {
      if (value.length <= 6) {
        return PhoneNumberValidationError.tooShort;
      } else if (value.length > 10) {
        return PhoneNumberValidationError.tooLong;
      } else if (!isNumeric) {
        return PhoneNumberValidationError.invalid;
      } else {
        return null;
      }
    } else
      return PhoneNumberValidationError.empty;
  }
}
