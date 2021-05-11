part of 'signup_verification_bloc.dart';

class SignupVerificationState extends Equatable {
  const SignupVerificationState({
    this.verificationCode = const VerificationCodeFormField.pure(),
    this.status = FormzStatus.pure,
  });

  final VerificationCodeFormField verificationCode;
  final FormzStatus status;

  @override
  List<Object> get props => [
        verificationCode,
        status,
      ];
}
