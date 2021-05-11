import 'package:formz/formz.dart';

enum ContactUsBodyValidationError { empty, maxLimit }

class ContactUsBody extends FormzInput<String, ContactUsBodyValidationError> {
  const ContactUsBody.pure() : super.pure('');
  const ContactUsBody.dirty([String value = '']) : super.dirty(value);

  @override
  ContactUsBodyValidationError validator(String value) {
    return value?.isNotEmpty == true ? null : ContactUsBodyValidationError.empty;
  }
}
