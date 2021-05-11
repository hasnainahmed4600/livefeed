import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:livefeed/common/models/verification_code_form_field.dart';

part 'signup_verification_event.dart';
part 'signup_verification_state.dart';

class SignupVerificationBloc
    extends Bloc<SignupVerificationEvent, SignupVerificationState> {
  SignupVerificationBloc() : super(SignupVerificationState());

  @override
  Stream<SignupVerificationState> mapEventToState(
    SignupVerificationEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
