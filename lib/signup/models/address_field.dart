import 'package:formz/formz.dart';

enum AddressFieldValidationError { empty, maxLimit }

class AddressField extends FormzInput<String, AddressFieldValidationError> {
  const AddressField.pure() : super.pure('');
  const AddressField.dirty([String value = '']) : super.dirty(value);

  @override
  AddressFieldValidationError validator(String value) {
    return value?.isNotEmpty == true ? null : AddressFieldValidationError.empty;
  }
}
