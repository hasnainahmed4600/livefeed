part of 'feedback_form_bloc.dart';

abstract class FeedbackFormEvent extends Equatable {
  const FeedbackFormEvent();

  @override
  List<Object> get props => [];
}

class NameUpdated extends FeedbackFormEvent {
  const NameUpdated(this.name);
  final String name;

  @override
  List<Object> get props => [name];
}

class EmailUpdated extends FeedbackFormEvent {
  const EmailUpdated(this.email);
  final String email;

  @override
  List<Object> get props => [email];
}

class CountryUpdated extends FeedbackFormEvent {
  const CountryUpdated(this.country);
  final String country;

  @override
  List<Object> get props => [country];
}

class PhoneNumberUpdated extends FeedbackFormEvent {
  const PhoneNumberUpdated(this.phoneNumber);
  final String phoneNumber;

  @override
  List<Object> get props => [phoneNumber];
}

class BodyUpdated extends FeedbackFormEvent {
  const BodyUpdated(this.body);
  final String body;

  @override
  List<Object> get props => [body];
}

class FeedbackFormSubmitted extends FeedbackFormEvent {
  const FeedbackFormSubmitted();
}

class FormFocusChanged extends FeedbackFormEvent {
  const FormFocusChanged(this.formFocused);
  final bool formFocused;

  @override
  List<Object> get props => [formFocused];
}
