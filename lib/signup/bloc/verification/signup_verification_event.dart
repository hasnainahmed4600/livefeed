part of 'signup_verification_bloc.dart';

abstract class SignupVerificationEvent extends Equatable {
  const SignupVerificationEvent();

  @override
  List<Object> get props => [];
}

class VerificationStarted extends SignupVerificationEvent {
  const VerificationStarted();
}

class VerificationCodeUpdated extends SignupVerificationEvent {
  const VerificationCodeUpdated(this.verificationCode);
  final String verificationCode;

  @override
  List<Object> get props => [verificationCode];
}

class VerificationCodeSubmitted extends SignupVerificationEvent {
  const VerificationCodeSubmitted();
}
