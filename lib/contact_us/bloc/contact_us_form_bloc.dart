import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:country_pickers/country.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:livefeed/common/models/email_form_field.dart';
import 'package:livefeed/common/models/phone_number_form_field.dart';
import 'package:livefeed/contact_us/models/contact_us_body.dart';
import 'package:livefeed/contact_us/models/contact_us_name.dart';
import 'package:livefeed/contact_us/models/contact_us_type_field.dart';

part 'contact_us_form_event.dart';

part 'contact_us_form_state.dart';

class ContactUsFormBloc extends Bloc<ContactUsFormEvent, ContactUsFormState> {
  ContactUsFormBloc({
    ContactUsType initialType,
    String initialBody,
  }) : super(ContactUsFormState(
          country: Country(isoCode: 'US'),
          type: initialType,
          body: initialBody != null
              ? ContactUsBody.dirty(initialBody)
              : ContactUsBody.pure(),
        ));

  @override
  Stream<ContactUsFormState> mapEventToState(
    ContactUsFormEvent event,
  ) async* {
    if (event is NameUpdated) {
      yield _mapNameUpdatedToState(event, state);
    } else if (event is TypeUpdated) {
      yield _mapTypeUpdatedToState(event, state);
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

  ContactUsFormState _mapNameUpdatedToState(
      NameUpdated event, ContactUsFormState state) {
    var name = ContactUsName.dirty(event.name);
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

  ContactUsFormState _mapTypeUpdatedToState(
      TypeUpdated event, ContactUsFormState state) {
    return state.copyWith(
      type: event.type,
      status: Formz.validate(
        [
          state.name,
          state.email,
          state.phoneNumber,
          state.body,
        ],
      ),
    );
  }

  ContactUsFormState _mapEmailUpdatedToState(
      EmailUpdated event, ContactUsFormState state) {
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

  ContactUsFormState _mapCountryUpdatedToState(
      CountryUpdated event, ContactUsFormState state) {
    return state.copyWith(
      country: Country(isoCode: event.country),
    );
  }

  ContactUsFormState _mapPhoneNumberUpdatedToState(
      PhoneNumberUpdated event, ContactUsFormState state) {
    var phoneNumber = PhoneNumberFormField.dirty(event.phoneNumber);
    return state.copyWith(
      phoneNumber: phoneNumber,
      status: Formz.validate([
        state.name,
        state.email,
        phoneNumber,
        state.body,
      ]),
    );
  }

  ContactUsFormState _mapBodyUpdatedToState(
      BodyUpdated event, ContactUsFormState state) {
    var body = ContactUsBody.dirty(event.body);
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

  ContactUsFormState _mapFormFocusChangedToState(
      FormFocusChanged event, ContactUsFormState state) {
    return state.copyWith(formFocused: event.formFocused);
  }
}
