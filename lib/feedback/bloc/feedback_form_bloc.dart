import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:country_pickers/country.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:livefeed/common/models/email_form_field.dart';
import 'package:livefeed/common/models/phone_number_form_field.dart';
import 'package:livefeed/feedback/models/feedback_body.dart';
import 'package:livefeed/feedback/models/feedback_name.dart';

part 'feedback_form_event.dart';

part 'feedback_form_state.dart';

class FeedbackFormBloc extends Bloc<FeedbackFormEvent, FeedbackFormState> {
  FeedbackFormBloc()
      : super(FeedbackFormState(country: Country(isoCode: 'US')));

  @override
  Stream<FeedbackFormState> mapEventToState(
    FeedbackFormEvent event,
  ) async* {
    if (event is NameUpdated) {
      yield _mapNameUpdatedToState(event, state);
    } else if (event is EmailUpdated) {
      yield _mapEmailUpdatedToState(event, state);
    } else if (event is CountryUpdated) {
      yield _mapCountryUpdatedToState(event, state);
    } else if (event is PhoneNumberUpdated) {
      yield _mapPhoneNumberUpdatedToState(event, state);
    } else if (event is BodyUpdated) {
      yield _mapBodyUpdatedToState(event, state);
    } else if (event is FormFocusChanged) {
      yield _mapFormFocusChangedToState(event, state);
    }
  }

  FeedbackFormState _mapNameUpdatedToState(
      NameUpdated event, FeedbackFormState state) {
    var name = FeedbackName.dirty(event.name);
    return state.copyWith(
      name: name,
      status: Formz.validate(
        [
          name,
          state.email,
          state.phoneNumber,
          state.body,
        ],
      ),
    );
  }

  FeedbackFormState _mapEmailUpdatedToState(
      EmailUpdated event, FeedbackFormState state) {
    var email = EmailFormField.dirty(event.email);
    return state.copyWith(
      email: email,
      status: Formz.validate(
        [
          state.name,
          email,
          state.phoneNumber,
          state.body,
        ],
      ),
    );
  }

  FeedbackFormState _mapCountryUpdatedToState(
      CountryUpdated event, FeedbackFormState state) {
    return state.copyWith(country: Country(isoCode: event.country));
  }

  FeedbackFormState _mapPhoneNumberUpdatedToState(
      PhoneNumberUpdated event, FeedbackFormState state) {
    var phoneNumber = PhoneNumberFormField.dirty(event.phoneNumber);
    return state.copyWith(
      phoneNumber: phoneNumber,
      status: Formz.validate(
        [
          state.name,
          state.email,
          phoneNumber,
          state.body,
        ],
      ),
    );
  }

  FeedbackFormState _mapBodyUpdatedToState(
      BodyUpdated event, FeedbackFormState state) {
    var body = FeedbackBody.dirty(event.body);
    return state.copyWith(
      body: body,
      status: Formz.validate(
        [
          state.name,
          state.email,
          state.phoneNumber,
          body,
        ],
      ),
    );
  }

  FeedbackFormState _mapFormFocusChangedToState(
      FormFocusChanged event, FeedbackFormState state) {
    return state.copyWith(formFocused: event.formFocused);
  }
}
