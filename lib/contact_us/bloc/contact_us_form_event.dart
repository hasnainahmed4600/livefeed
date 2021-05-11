part of 'contact_us_form_bloc.dart';

abstract class ContactUsFormEvent extends Equatable {
  const ContactUsFormEvent();

  @override
  List<Object> get props => [];
}

class NameUpdated extends ContactUsFormEvent {
  const NameUpdated(this.name);
  final String name;

  @override
  List<Object> get props => [name];
}

class TypeUpdated extends ContactUsFormEvent {
  const TypeUpdated(this.type);
  final ContactUsType type;

  @override
  List<Object> get props => [type];
}

class EmailUpdated extends ContactUsFormEvent {
  const EmailUpdated(this.email);
  final String email;

  @override
  List<Object> get props => [email];
}

class CountryUpdated extends ContactUsFormEvent {
  const CountryUpdated(this.country);
  final String country;

  @override
  List<Object> get props => [country];
}

class PhoneNumberUpdated extends ContactUsFormEvent {
  const PhoneNumberUpdated(this.phoneNumber);
  final String phoneNumber;

  @override
  List<Object> get props => [phoneNumber];
}

class BodyUpdated extends ContactUsFormEvent {
  const BodyUpdated(this.body);
  final String body;

  @override
  List<Object> get props => [body];
}

class FeedbackFormSubmitted extends ContactUsFormEvent {
  const FeedbackFormSubmitted();
}

class FormFocusChanged extends ContactUsFormEvent {
  const FormFocusChanged(this.formFocused);
  final bool formFocused;

  @override
  List<Object> get props => [formFocused];
}
