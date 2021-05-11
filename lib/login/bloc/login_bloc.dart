import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:livefeed/common/models/phone_number_form_field.dart';
import 'package:livefeed/common/models/verification_code_form_field.dart';
import 'package:meta/meta.dart';
import 'package:repository_core/repository_core.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({@required AuthenticationRepository authenticationRepository})
      : assert(authenticationRepository != null),
        _authenticationRepository = authenticationRepository,
        super(LoginState());

  final AuthenticationRepository _authenticationRepository;

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginLoaded) {
      yield _mapLoginLoadedToState();
    } else if (event is PhoneNumberUpdated) {
      yield _mapPhoneNumberUpdatedToState(event, state);
    } else if (event is PhoneNumberSubmitted) {
      yield* _mapPhoneNumberSubmittedToState(event, state);
    } else if (event is VerificationCodeUpdated) {
      yield _mapVerificationCodeUpdatedToState(event, state);
    } else if (event is VerificationCodeSubmitted) {
      yield* _mapVerificationCodeSubmittedToState(event, state);
    } else if (event is NumberChangeRequested) {
      _authenticationRepository.logOut();
    } else if (event is NewVerificationCodeRequested) {
      yield* _mapNewVerificationCodeRequestedToState(event, state);
    } else if (event is PhoneCodeUpdated) {
      yield _mapPhoneCodeUpdatedToState(event, state);
    }
  }

  LoginState _mapLoginLoadedToState() {
    return LoginState();
  }

  LoginState _mapPhoneNumberUpdatedToState(
    PhoneNumberUpdated event,
    LoginState state,
  ) {
    var phoneNumber = PhoneNumberFormField.dirty(event.phoneNumber);
    return state.copyWith(
      phoneNumber: phoneNumber,
      loginFormStatus: Formz.validate([phoneNumber]),
    );
  }

  Stream<LoginState> _mapPhoneNumberSubmittedToState(
    PhoneNumberSubmitted event,
    LoginState state,
  ) async* {
    if (state.loginFormStatus.isValidated) {
      yield state.copyWith(loginFormStatus: FormzStatus.submissionInProgress);
      try {
        await _authenticationRepository.phoneLogin(
          state.phoneIsoCode,
          state.phoneCountryCode,
          state.phoneNumber.value,
        );
        yield state.copyWith(
          loginFormStatus: FormzStatus.submissionSuccess,
          phoneNumber: PhoneNumberFormField.pure(),
        );
      } catch (ex) {
        yield state.copyWith(loginFormStatus: FormzStatus.submissionFailure);
      }
    }
  }

  LoginState _mapPhoneCodeUpdatedToState(
    PhoneCodeUpdated event,
    LoginState state,
  ) {
    return state.copyWith(
      phoneCountryCode: event.phoneCountryCode,
      phoneIsoCode: event.phoneIsoCode,
    );
  }

  LoginState _mapVerificationCodeUpdatedToState(
    VerificationCodeUpdated event,
    LoginState state,
  ) {
    var verificationCode = VerificationCodeFormField.dirty(event.verificationCode);
    return state.copyWith(
      verificationCode: verificationCode,
      verificationFormStatus: Formz.validate([verificationCode]),
    );
  }

  Stream<LoginState> _mapVerificationCodeSubmittedToState(
    VerificationCodeSubmitted event,
    LoginState state,
  ) async* {
    if (state.verificationFormStatus.isValidated) {
      yield state.copyWith(
          verificationFormStatus: FormzStatus.submissionInProgress);
      try {
        await _authenticationRepository.verify(
          state.verificationCode.value,
          phoneCountryCode: state.phoneCountryCode,
          phoneIsoCode: state.phoneIsoCode,
          phoneNumber: state.phoneNumber.value,
        );
        yield state.copyWith(
          verificationFormStatus: FormzStatus.submissionSuccess,
          verificationCode: VerificationCodeFormField.pure(),
        );
      } catch (ex) {
        yield state.copyWith(
            verificationFormStatus: FormzStatus.submissionFailure);
      }
    }
  }

  Stream<LoginState> _mapNewVerificationCodeRequestedToState(
    NewVerificationCodeRequested event,
    LoginState state,
  ) async* {
    yield state.copyWith(
        resendVerificationCodeStatus: FormzStatus.submissionInProgress);

    try {
      await _authenticationRepository.resendVerificationCode();
      yield state.copyWith(
        resendVerificationCodeStatus: FormzStatus.submissionSuccess,
      );
    } catch (ex) {
      yield state.copyWith(
          resendVerificationCodeStatus: FormzStatus.submissionFailure);
    }
  }
}
