part of 'login_bloc.dart';

@immutable
class LoginState extends Equatable {
  final FormzStatus loginFormStatus;
  final String phoneIsoCode;
  final String phoneCountryCode;
  final PhoneNumberFormField phoneNumber;
  final FormzStatus verificationFormStatus;
  final VerificationCodeFormField verificationCode;
  final FormzStatus resendVerificationCodeStatus;

  const LoginState({
    this.loginFormStatus = FormzStatus.pure,
    this.phoneIsoCode = 'US',
    this.phoneCountryCode = '1',
    this.phoneNumber = const PhoneNumberFormField.pure(),
    this.verificationFormStatus = FormzStatus.pure,
    this.verificationCode = const VerificationCodeFormField.pure(),
    this.resendVerificationCodeStatus = FormzStatus.pure,
  });

  LoginState copyWith({
    FormzStatus loginFormStatus,
    String phoneIsoCode,
    String phoneCountryCode,
    PhoneNumberFormField phoneNumber,
    FormzStatus verificationFormStatus,
    VerificationCodeFormField verificationCode,
    FormzStatus resendVerificationCodeStatus,
  }) {
    return LoginState(
      loginFormStatus: loginFormStatus ?? this.loginFormStatus,
      phoneIsoCode: phoneIsoCode ?? this.phoneIsoCode,
      phoneCountryCode: phoneCountryCode ?? this.phoneCountryCode,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      verificationFormStatus:
          verificationFormStatus ?? this.verificationFormStatus,
      verificationCode: verificationCode ?? this.verificationCode,
      resendVerificationCodeStatus:
          resendVerificationCodeStatus ?? this.resendVerificationCodeStatus,
    );
  }

  @override
  List<Object> get props => [
        loginFormStatus,
        phoneIsoCode,
        phoneCountryCode,
        phoneNumber,
        verificationFormStatus,
        verificationCode,
        resendVerificationCodeStatus,
      ];
}
