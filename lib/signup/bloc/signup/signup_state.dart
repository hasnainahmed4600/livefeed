part of 'signup_bloc.dart';

class SignupState extends Equatable {
  const SignupState({
    this.fullName = const FullName.pure(),
    this.email = const EmailFormField.pure(),
    this.phoneNumber = const PhoneNumberFormField.pure(),
    this.phoneIsoCode = 'US',
    this.phoneCountryCode = '1',
    this.address = const AddressField.pure(),
    this.zipCode = const ZipcodeField.pure(),
    this.verificationEvent,
    this.signupFormStatus = FormzStatus.pure,
    this.verificationFormStatus = FormzStatus.pure,
    this.verificationCode = const VerificationCodeFormField.pure(),
    this.resendVerificationCodeStatus = FormzStatus.pure,
    this.error,
  });

  final FullName fullName;
  final EmailFormField email;
  final PhoneNumberFormField phoneNumber;
  final String phoneIsoCode;
  final String phoneCountryCode;
  final AddressField address;
  final ZipcodeField zipCode;
  final VerificationEventEntity verificationEvent;
  final FormzStatus signupFormStatus;
  final FormzStatus verificationFormStatus;
  final VerificationCodeFormField verificationCode;
  final FormzStatus resendVerificationCodeStatus;
  final String error;

  SignupState copyWith({
    FullName fullName,
    EmailFormField email,
    PhoneNumberFormField phoneNumber,
    String phoneIsoCode,
    String phoneCountryCode,
    AddressField address,
    ZipcodeField zipCode,
    VerificationEventEntity verificationEvent,
    FormzStatus signupFormStatus,
    FormzStatus verificationFormStatus,
    VerificationCodeFormField verificationCode,
    FormzStatus resendVerificationCodeStatus,
    String error,
  }) {
    return SignupState(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      phoneIsoCode: phoneIsoCode ?? this.phoneIsoCode,
      phoneCountryCode: phoneCountryCode ?? this.phoneCountryCode,
      address: address ?? this.address,
      zipCode: zipCode ?? this.zipCode,
      verificationEvent: verificationEvent ?? this.verificationEvent,
      signupFormStatus: signupFormStatus ?? this.signupFormStatus,
      verificationFormStatus:
          verificationFormStatus ?? this.verificationFormStatus,
      verificationCode: verificationCode ?? this.verificationCode,
      resendVerificationCodeStatus:
          resendVerificationCodeStatus ?? this.resendVerificationCodeStatus,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [
        fullName,
        email,
        phoneNumber,
        phoneIsoCode,
        phoneCountryCode,
        address,
        zipCode,
        verificationEvent,
        signupFormStatus,
        verificationFormStatus,
        verificationCode,
        resendVerificationCodeStatus,
        error,
      ];
}
