part of 'signup_bloc.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object> get props => [];
}

class SignupStarted extends SignupEvent {
  const SignupStarted();
}

class FullNameUpdated extends SignupEvent {
  const FullNameUpdated(this.fullName);
  final String fullName;

  @override
  List<Object> get props => [fullName];
}

class EmailUpdated extends SignupEvent {
  const EmailUpdated(this.email);
  final String email;

  @override
  List<Object> get props => [email];
}

class PhoneCodeUpdated extends SignupEvent {
  final String phoneIsoCode;
  final String phoneCountryCode;

  const PhoneCodeUpdated(this.phoneIsoCode, this.phoneCountryCode);

  @override
  List<Object> get props => [phoneIsoCode, phoneCountryCode];
}

class PhoneNumberUpdated extends SignupEvent {
  final String phoneNumber;

  const PhoneNumberUpdated(this.phoneNumber);

  @override
  List<Object> get props => [phoneNumber];
}

class FullAddressUpdated extends SignupEvent {
  const FullAddressUpdated(this.address, this.zipCode);
  final String address;
  final String zipCode;

  @override
  List<Object> get props => [address, zipCode];
}

class SignupSubmitted extends SignupEvent {
  const SignupSubmitted();
}

class VerificationCodeUpdated extends SignupEvent {
  final String verificationCode;
  const VerificationCodeUpdated(this.verificationCode);

  @override
  List<Object> get props => [verificationCode];
}

class NumberChangeRequested extends SignupEvent {
  const NumberChangeRequested();
}

class VerificationCodeSubmitted extends SignupEvent {
  const VerificationCodeSubmitted();
}

class NewVerificationCodeRequested extends SignupEvent {
  const NewVerificationCodeRequested();
}
