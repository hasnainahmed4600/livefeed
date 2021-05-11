import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:livefeed/authentication/bloc/authentication_bloc.dart';
import 'package:livefeed/signup/bloc/signup/signup_bloc.dart';
import 'package:livefeed/signup/models/full_name.dart';
import 'package:livefeed/common/models/email_form_field.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:livefeed/common/consts/country_codes.dart';
import 'package:livefeed/common/models/phone_number_form_field.dart';
import 'package:livefeed/common/widgets/location_field.dart';
import 'package:livefeed/theme.dart';
import 'package:formz/formz.dart';

class SignupForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // const Padding(padding: EdgeInsets.only(top: 15)),
        Text(
          'Signup',
          style: LiveFeedTheme.theme.textTheme.headline1,
        ),
        const Padding(padding: EdgeInsets.only(top: 10)),
        Text(
          'Please fill out the information below',
          style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
            color: Color.fromRGBO(150, 150, 150, 1),
            fontWeight: FontWeight.w500,
            fontSize: 16,
            height: 1.58,
          ),
        ),
        const Padding(padding: EdgeInsets.only(top: 10)),
        _FullNameInput(),
        const Padding(padding: EdgeInsets.only(top: 10)),
        _EmailInput(),
        const Padding(padding: EdgeInsets.only(top: 10)),
        _PhoneNoInput(),
        const Padding(padding: EdgeInsets.only(top: 10)),
        LocationField(
          (zip, address) {
            print('$zip, $address');
            context.read<SignupBloc>().add(FullAddressUpdated(address, zip));
          },
          fieldLabel: '',
        ),
        const Padding(padding: EdgeInsets.only(top: 22)),
        _SubmitButton(),
        // _LoginButton(),
        const Padding(padding: EdgeInsets.only(top: 10)),
        _FooterNote(),
        _FooterNote2(),
      ],
    );
  }
}

class _FullNameInput extends StatelessWidget {
  String translateErrorText(FullNameValidationError error) {
    switch (error) {
      case FullNameValidationError.empty:
        return 'Required';
      case FullNameValidationError.maxLimit:
        return 'Too long';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      buildWhen: (previous, current) => previous.fullName != current.fullName,
      builder: (context, state) {
        return TextField(
          onChanged: (value) {
            context.read<SignupBloc>().add(FullNameUpdated(value));
          },
          // keyboardType: TextInputType.phone,
          maxLength: 80,
          decoration: InputDecoration(
            errorText: state.fullName.invalid
                ? translateErrorText(state.fullName.error)
                : null,
            hintText: 'Full name',
          ),
        );
      },
    );
  }
}

class _EmailInput extends StatelessWidget {
  String translateErrorText(EmailValidationError error) {
    switch (error) {
      case EmailValidationError.empty:
        return 'Required';
      case EmailValidationError.invalid:
        return 'Invalid email address';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          onChanged: (value) {
            context.read<SignupBloc>().add(EmailUpdated(value));
          },
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            errorText: state.email.invalid
                ? translateErrorText(state.email.error)
                : null,
            hintText: 'Email address',
          ),
        );
      },
    );
  }
}

class _CountryPicker extends StatelessWidget {
  Widget _buildDropdownItem(Country country) => Container(
        child: Row(
          children: <Widget>[
            CountryPickerUtils.getDefaultFlagImage(country),
            SizedBox(
              width: 8.0,
            ),
            Text("+${country.phoneCode}"),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      builder: (context, state) {
        return CountryPickerDropdown(
          initialValue: state.phoneIsoCode,
          itemBuilder: _buildDropdownItem,
          itemFilter: (c) => countryCodes.contains(c.isoCode),
          priorityList: [
            CountryPickerUtils.getCountryByIsoCode('US'),
            CountryPickerUtils.getCountryByIsoCode('BY'),
          ],
          sortComparator: (Country a, Country b) =>
              a.isoCode.compareTo(b.isoCode),
          onValuePicked: (Country country) {
            context
                .read<SignupBloc>()
                .add(PhoneCodeUpdated(country.isoCode, country.phoneCode));
            print("${country.phoneCode}");
          },
        );
      },
    );
  }
}

class _PhoneNoInput extends StatelessWidget {
  String translateErrorText(PhoneNumberValidationError error) {
    switch (error) {
      case PhoneNumberValidationError.empty:
        return 'Required';
      case PhoneNumberValidationError.invalid:
        return 'Only numbers allowed';
      case PhoneNumberValidationError.tooShort:
        return 'Please enter at least 7 digits';
      case PhoneNumberValidationError.tooLong:
        return 'Maximum 10 digits allowed';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      buildWhen: (previous, current) =>
          previous.phoneNumber != current.phoneNumber,
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _CountryPicker(),
            Expanded(
              child: TextField(
                onChanged: (phoneNumber) {
                  context
                      .read<SignupBloc>()
                      .add(PhoneNumberUpdated(phoneNumber));
                },
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  errorText: state.phoneNumber.invalid
                      ? translateErrorText(state.phoneNumber.error)
                      : null,
                  hintText: 'Enter your phone number',
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      buildWhen: (previous, current) =>
          previous.signupFormStatus != current.signupFormStatus,
      builder: (context, state) {
        return state.signupFormStatus.isSubmissionInProgress
            ? Align(
                alignment: Alignment.center,
                child: Container(
                  height: 35,
                  width: 35,
                  child: const CircularProgressIndicator(),
                ),
              ) // Color taken from theme accentColor
            : Container(
                width: double.infinity,
                child: FlatButton(
                  onPressed: state.signupFormStatus.isValidated
                      ? () {
                          context
                              .read<SignupBloc>()
                              .add(const SignupSubmitted());
                        }
                      : null,
                  disabledColor: LiveFeedTheme.theme.disabledColor,
                  color: LiveFeedTheme.theme.buttonColor,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      'SUBMIT',
                      style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      minWidth: double.infinity,
      onPressed: () => Navigator.of(context).pop(),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Text(
          'LOG IN',
          style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
            color: LiveFeedTheme.theme.highlightColor,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}

class _FooterNote extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.italic,
          color: Color.fromRGBO(150, 150, 150, 1),
          fontSize: 12,
        ),
        children: <TextSpan>[
          TextSpan(text: 'By clicking submit, you agree to our '),
          TextSpan(
            text: 'Terms of Service ',
            style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
              color: LiveFeedTheme.theme.highlightColor,
            ),
          ),
          TextSpan(text: 'and '),
          TextSpan(
            text: 'Privacy Policy.',
            style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
              color: LiveFeedTheme.theme.highlightColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _FooterNote2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.italic,
          color: Color.fromRGBO(150, 150, 150, 1),
          fontSize: 12,
        ),
        children: <TextSpan>[
          TextSpan(
            text:
                'You may receive SMS notifications from us and can opt out at any time.',
          ),
        ],
      ),
    );
  }
}
