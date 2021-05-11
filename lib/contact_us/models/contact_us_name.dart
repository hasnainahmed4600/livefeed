import 'package:formz/formz.dart';

enum ContactUsNameValidationError { empty, maxLimit }

class ContactUsName extends FormzInput<String, ContactUsNameValidationError> {
  const ContactUsName.pure() : super.pure('');
  const ContactUsName.dirty([String value = '']) : super.dirty(value);

  @override
  ContactUsNameValidationError validator(String value) {
    return value?.isNotEmpty == true ? null : ContactUsNameValidationError.empty;
  }
}
