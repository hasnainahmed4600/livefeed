import 'package:formz/formz.dart';

enum ZipcodeFieldValidationError { empty, maxLimit }

class ZipcodeField extends FormzInput<String, ZipcodeFieldValidationError> {
  const ZipcodeField.pure() : super.pure('');
  const ZipcodeField.dirty([String value = '']) : super.dirty(value);

  @override
  ZipcodeFieldValidationError validator(String value) {
    return value?.isNotEmpty == true ? null : ZipcodeFieldValidationError.empty;
  }
}
