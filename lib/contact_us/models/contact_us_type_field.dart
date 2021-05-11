import 'package:formz/formz.dart';

enum ContactUsType { login, signup, posts, marketplace, advertising }

enum ContactUsTypeValidationError { empty }

class ContactUsTypeField extends FormzInput<String, ContactUsTypeValidationError> {
  const ContactUsTypeField.pure() : super.pure('');
  const ContactUsTypeField.dirty([String value = '']) : super.dirty(value);

  @override
  ContactUsTypeValidationError validator(String value) {
    return value?.isNotEmpty == true ? null : ContactUsTypeValidationError.empty;
  }
}
