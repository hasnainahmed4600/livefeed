part of 'feedback_form_bloc.dart';

class FeedbackFormState extends Equatable {
  const FeedbackFormState({
    this.name = const FeedbackName.pure(),
    this.email = const EmailFormField.pure(),
    this.country,
    this.phoneNumber = const PhoneNumberFormField.pure(),
    this.body = const FeedbackBody.pure(),
    this.status = FormzStatus.pure,
    this.error,
    this.formFocused = false,
  });

  final FeedbackName name;
  final EmailFormField email;
  final Country country;
  final PhoneNumberFormField phoneNumber;
  final FeedbackBody body;
  final FormzStatus status;
  final String error;
  final bool formFocused;

  FeedbackFormState copyWith({
    FeedbackName name,
    EmailFormField email,
    Country country,
    PhoneNumberFormField phoneNumber,
    FeedbackBody body,
    FormzStatus status,
    String error,
    bool formFocused,
  }) {
    return FeedbackFormState(
      name: name ?? this.name,
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
        email,
        country,
        phoneNumber,
        body,
        status,
        error,
        formFocused,
      ];
}
