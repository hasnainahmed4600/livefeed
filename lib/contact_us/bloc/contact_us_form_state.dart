part of 'contact_us_form_bloc.dart';

class ContactUsFormState extends Equatable {
  const ContactUsFormState({
    this.name = const ContactUsName.pure(),
    this.type,
    this.email = const EmailFormField.pure(),
    this.country,
    this.phoneNumber = const PhoneNumberFormField.pure(),
    this.body = const ContactUsBody.pure(),
    this.status = FormzStatus.pure,
    this.error,
    this.formFocused = false,
  });

  final ContactUsName name;
  final ContactUsType type;
  final EmailFormField email;
  final Country country;
  final PhoneNumberFormField phoneNumber;
  final ContactUsBody body;
  final FormzStatus status;
  final String error;
  final bool formFocused;

  ContactUsFormState copyWith({
    ContactUsName name,
    ContactUsType type,
    EmailFormField email,
    Country country,
    PhoneNumberFormField phoneNumber,
    ContactUsBody body,
    FormzStatus status,
    String error,
    bool formFocused,
  }) {
    return ContactUsFormState(
      name: name ?? this.name,
      type: type ?? this.type,
      email: email ?? this.email,
      country: country ?? this.country,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      body: body ?? this.body,
      status: status ?? this.status,
      error: error ?? this.error,
      formFocused: formFocused ?? this.formFocused,
    );
  }

  @override
  List<Object> get props => [
        name,
        type,
        email,
        country,
        phoneNumber,
        body,
        status,
        error,
        formFocused,
      ];
}
