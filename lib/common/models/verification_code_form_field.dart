import 'package:formz/formz.dart';

enum VerificationCodeValidationError { empty, invalid, tooShort }

class VerificationCodeFormField
    extends FormzInput<String, VerificationCodeValidationError> {
  const VerificationCodeFormField.pure() : super.pure('');
  const VerificationCodeFormField.dirty([String value = '']) : super.dirty(value);

  @override
  VerificationCodeValidationError validator(String value) {
    final isAlphanumeric =
        RegExp(r'^(?!\s*$)[a-zA-Z0-9- ]{1,20}$').hasMatch(value);
    final isNumeric = RegExp(r'^[0-9]+$').hasMatch(value);

    if (value?.isNotEmpty == true) {
      if (!isNumeric) {
        return VerificationCodeValidationError.invalid;
      }
      if (value.length < 6) {
        return VerificationCodeValidationError.tooShort;
      }
      return null;
    } else
      return VerificationCodeValidationError.empty;
  }
}
