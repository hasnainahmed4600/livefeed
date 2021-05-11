part of 'login_bloc.dart';

@immutable
abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginLoaded extends LoginEvent {
  const LoginLoaded();
}

class PhoneCodeUpdated extends LoginEvent {
  final String phoneIsoCode;
  final String phoneCountryCode;

  const PhoneCodeUpdated(this.phoneIsoCode, this.phoneCountryCode);

  @override
  List<Object> get props => [phoneIsoCode, phoneCountryCode];
}

class PhoneNumberUpdated extends LoginEvent {
  final String phoneNumber;

  const PhoneNumberUpdated(this.phoneNumber);

  @override
  List<Object> get props => [phoneNumber];
}

class PhoneNumberSubmitted extends LoginEvent {
  const PhoneNumberSubmitted();
}

class VerificationCodeUpdated extends LoginEvent {
  final String verificationCode;
  const VerificationCodeUpdated(this.verificationCode);

  @override
  List<Object> get props => [verificationCode];
}

class NumberChangeRequested extends LoginEvent {
  const NumberChangeRequested();
}

class VerificationCodeSubmitted extends LoginEvent {
  const VerificationCodeSubmitted();
}

class NewVerificationCodeRequested extends LoginEvent {
  const NewVerificationCodeRequested();
}
