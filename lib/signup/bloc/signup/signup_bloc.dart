import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:livefeed/common/models/email_form_field.dart';
import 'package:livefeed/common/models/phone_number_form_field.dart';
import 'package:livefeed/common/models/verification_code_form_field.dart';
import 'package:livefeed/signup/models/address_field.dart';
import 'package:livefeed/signup/models/full_name.dart';
import 'package:livefeed/signup/models/zipcode_field.dart';
import 'package:meta/meta.dart';
import 'package:repository_core/repository_core.dart';
import 'package:uuid/uuid.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc({
    @required AuthenticationRepository authenticationRepository,
    @required UserRepositoryCore userRepository,
  })  : assert(authenticationRepository != null),
        assert(userRepository != null),
        _authenticationRepository = authenticationRepository,
        _userRepository = userRepository,
        super(SignupState());

  final AuthenticationRepository _authenticationRepository;
  final UserRepositoryCore _userRepository;

  @override
  Stream<SignupState> mapEventToState(
    SignupEvent event,
  ) async* {
    if (event is FullNameUpdated) {
      yield _mapFullNameUpdatedToState(event, state);
    } else if (event is EmailUpdated) {
      yield _mapEmailUpdatedToState(event, state);
    } else if (event is PhoneCodeUpdated) {
      yield _mapPhoneCodeUpdatedToState(event, state);
    } else if (event is PhoneNumberUpdated) {
      yield _mapPhoneNumberUpdatedToState(event, state);
    } else if (event is FullAddressUpdated) {
      yield _mapFullAddressUpdatedToState(event, state);
    } else if (event is SignupSubmitted) {
      yield* _mapSignupSubmittedToState(event, state);
    } else if (event is SignupStarted) {
      yield _mapSignupStartedToState(event, state);
    } else if (event is VerificationCodeUpdated) {
      yield _mapVerificationCodeUpdatedToState(event, state);
    } else if (event is VerificationCodeSubmitted) {
      yield* _mapVerificationCodeSubmittedToState(event, state);
    } else if (event is NumberChangeRequested) {
      yield _mapNumberChangeRequestedToState(event, state);
    } else if (event is NewVerificationCodeRequested) {
      yield* _mapNewVerificationCodeRequestedToState(event, state);
    }
  }

  SignupState _mapSignupStartedToState(SignupStarted event, SignupState state) {
    return new SignupState();
  }

  SignupState _mapNumberChangeRequestedToState(
      NumberChangeRequested event, SignupState state) {
    return new SignupState();
  }

  SignupState _mapFullNameUpdatedToState(
      FullNameUpdated event, SignupState state) {
    var fullName = FullName.dirty(event.fullName);
    return state.copyWith(
      fullName: fullName,
      signupFormStatus: Formz.validate([
        fullName,
        state.email,
        state.phoneNumber,
        state.address,
        state.zipCode,
      ]),
    );
  }

  SignupState _mapEmailUpdatedToState(EmailUpdated event, SignupState state) {
    var email = EmailFormField.dirty(event.email);
    return state.copyWith(
      email: email,
      signupFormStatus: Formz.validate([
        state.fullName,
        email,
        state.phoneNumber,
        state.address,
        state.zipCode,
      ]),
    );
  }

  SignupState _mapPhoneCodeUpdatedToState(
      PhoneCodeUpdated event, SignupState state) {
    return state.copyWith(
      phoneIsoCode: event.phoneIsoCode,
      phoneCountryCode: event.phoneCountryCode,
    );
  }

  SignupState _mapPhoneNumberUpdatedToState(
      PhoneNumberUpdated event, SignupState state) {
    var phoneNumber = PhoneNumberFormField.dirty(event.phoneNumber);
    return state.copyWith(
      phoneNumber: phoneNumber,
      signupFormStatus: Formz.validate([
        state.fullName,
        state.email,
        phoneNumber,
        state.address,
        state.zipCode,
      ]),
    );
  }

  SignupState _mapFullAddressUpdatedToState(
      FullAddressUpdated event, SignupState state) {
    var address = AddressField.dirty(event.address);
    var zipCode = ZipcodeField.dirty(event.zipCode);
    return state.copyWith(
      address: address,
      zipCode: zipCode,
      signupFormStatus: Formz.validate([
        state.fullName,
        state.email,
        state.phoneNumber,
        address,
        zipCode,
      ]),
    );
  }

  Stream<SignupState> _mapSignupSubmittedToState(
      SignupSubmitted event, SignupState state) async* {
    if (state.signupFormStatus.isValidated) {
      yield state.copyWith(
        signupFormStatus: FormzStatus.submissionInProgress,
      );

      try {
        var verificationEvent = await Future<VerificationEventEntity>.delayed(
          const Duration(milliseconds: 300),
          () {
            return VerificationEventEntity(
              id: Uuid().v4(),
              requestedOn: DateTime.now(),
              throttleDurationSeconds: 30,
            );
          },
        );
        var toAddUSer = new UserEntity(
          name: state.fullName.value,
          email: state.email.value,
          phoneNumber: state.phoneNumber.value,
          phoneCountryCode: state.phoneCountryCode,
          phoneIsoCode: state.phoneIsoCode,
          address: state.address.value,
          zipCode: state.address.value,
        );
        await _userRepository.createUser(toAddUSer);

        // await _authenticationRepository.phoneLogin(state.phoneIsoCode,
        //     state.phoneCountryCode, state.phoneNumber.value);

        yield state.copyWith(
          signupFormStatus: FormzStatus.submissionSuccess,
          verificationEvent: verificationEvent,
        );
      } catch (e) {
        yield state.copyWith(error: e.toString());
      }
    }
  }

  SignupState _mapVerificationCodeUpdatedToState(
    VerificationCodeUpdated event,
    SignupState state,
  ) {
    var verificationCode = VerificationCodeFormField.dirty(event.verificationCode);
    return state.copyWith(
      verificationCode: verificationCode,
      verificationFormStatus: Formz.validate([verificationCode]),
    );
  }

  Stream<SignupState> _mapVerificationCodeSubmittedToState(
    VerificationCodeSubmitted event,
    SignupState state,
  ) async* {
    if (state.verificationFormStatus.isValidated) {
      yield state.copyWith(
          verificationFormStatus: FormzStatus.submissionInProgress);
      try {
        await _authenticationRepository.verify(
          state.verificationCode.value,
          verificationEventId: state.verificationEvent.id,
          name: state.fullName.value,
          phoneIsoCode: state.phoneIsoCode,
          phoneCountryCode: state.phoneCountryCode,
          phoneNumber: state.phoneNumber.value,
        );
        print(event.toString());
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

  Stream<SignupState> _mapNewVerificationCodeRequestedToState(
    NewVerificationCodeRequested event,
    SignupState state,
  ) async* {
    yield state.copyWith(
        resendVerificationCodeStatus: FormzStatus.submissionInProgress);

    try {
      var verificationEvent = await Future<VerificationEventEntity>.delayed(
        const Duration(milliseconds: 300),
        () {
          return VerificationEventEntity(
            id: Uuid().v4(),
            requestedOn: DateTime.now(),
            throttleDurationSeconds: 30,
          );
        },
      );
      yield state.copyWith(
        verificationEvent: verificationEvent,
        resendVerificationCodeStatus: FormzStatus.submissionSuccess,
      );
    } catch (ex) {
      yield state.copyWith(
          resendVerificationCodeStatus: FormzStatus.submissionFailure);
    }
  }
}
