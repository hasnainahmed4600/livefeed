import 'package:country_pickers/country.dart';
import 'package:flutter/material.dart';
import 'package:livefeed/common/models/email_form_field.dart';
import 'package:livefeed/common/widgets/phone_no_field.dart';
import 'package:livefeed/contact_us/bloc/contact_us_form_bloc.dart';
import 'package:livefeed/contact_us/models/contact_us_body.dart';
import 'package:livefeed/contact_us/models/contact_us_name.dart';
import 'package:livefeed/contact_us/models/contact_us_type_field.dart';
import 'package:livefeed/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactUsFormCard extends StatelessWidget {
  ContactUsFormCard({this.initialBodyText});

  final String initialBodyText;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          border: Border.all(width: 1.0, color: Colors.grey[400]),
          color: Colors.white,
        ),
        child: Padding(
          padding: EdgeInsets.only(
            left: 15,
            right: 15,
            top: 5,
            bottom: 15,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // _NameInput(),
              // const Padding(padding: EdgeInsets.only(top: 15)),
              _TypeInput(),
              const Padding(padding: EdgeInsets.only(top: 15)),
              _EmailInput(),
              const Padding(padding: EdgeInsets.only(top: 15)),
              BlocBuilder<ContactUsFormBloc, ContactUsFormState>(
                buildWhen: (previous, current) =>
                    previous.phoneNumber != current.phoneNumber,
                builder: (context, state) {
                  return PhoneNoField(
                    currentPhoneNumber: state.phoneNumber,
                    initialValueIsoCode: state.country.isoCode,
                    onCountryChanged: (country) {
                      context
                          .read<ContactUsFormBloc>()
                          .add(CountryUpdated(country.isoCode));
                    },
                    onPhoneNumberChanged: (number) {
                      context
                          .read<ContactUsFormBloc>()
                          .add(PhoneNumberUpdated(number));
                    },
                  );
                },
              ),
              const Padding(padding: EdgeInsets.only(top: 15)),
              _BodyInput(
                initialText: initialBodyText != null ? initialBodyText : null,
              ),
              const Padding(padding: EdgeInsets.only(top: 30)),
              _SubmitButton(),
              const Padding(padding: EdgeInsets.only(top: 15)),
            ],
          ),
        ));
  }
}

class _NameInput extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NameInputState();
}

class _NameInputState extends State<_NameInput> {
  FocusNode _focusNode;

  String translateErrorText(ContactUsNameValidationError error) {
    switch (error) {
      case ContactUsNameValidationError.empty:
        return 'Required';
      case ContactUsNameValidationError.maxLimit:
        return 'Too long';
    }
  }

  @override
  void initState() {
    _focusNode = new FocusNode()..addListener(_focusListener);
    super.initState();
  }

  void _focusListener() {
    if (!context.read<ContactUsFormBloc>().state.formFocused) {
      context
          .read<ContactUsFormBloc>()
          .add(FormFocusChanged(_focusNode.hasFocus));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactUsFormBloc, ContactUsFormState>(
      builder: (context, state) {
        return TextField(
          onChanged: (value) =>
              context.read<ContactUsFormBloc>().add(NameUpdated(value)),
          focusNode: _focusNode,
          maxLength: 80,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
            hintText: 'Name',
            filled: true,
            errorText: state.name.invalid
                ? translateErrorText(state.name.error)
                : null,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey[300],
                width: 1,
              ),
            ),
            errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                // color: Colors.grey,
                width: 2,
              ),
            ),
            focusedErrorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                // color: Colors.grey,
                width: 2,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey[800],
                width: 2,
              ),
            ),
            hoverColor: Colors.grey[200],
            fillColor: Colors.white,
            focusColor: Colors.grey[200],
            hintStyle:
                LiveFeedTheme.theme.inputDecorationTheme.hintStyle.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
            fontWeight: FontWeight.bold,
          ),
        );
      },
    );
  }
}

class _TypeInput extends StatelessWidget {
  String typeToString(ContactUsType type) {
    switch (type) {
      case ContactUsType.posts:
        return 'Posts';
      case ContactUsType.advertising:
        return 'Advertising';
      case ContactUsType.login:
        return 'Login';
      case ContactUsType.marketplace:
        return 'Marketplace';
      case ContactUsType.signup:
        return 'Signup';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactUsFormBloc, ContactUsFormState>(
      builder: (context, state) {
        return DropdownButtonFormField<ContactUsType>(
          items: ContactUsType.values
              .map((e) => DropdownMenuItem(
                    child: Text(typeToString(e)),
                    value: e,
                  ))
              .toList(),
          style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
            fontWeight: FontWeight.bold,
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
            hintText: 'Type',
            filled: true,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey[300],
                width: 1,
              ),
            ),
            errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                // color: Colors.grey,
                width: 2,
              ),
            ),
            focusedErrorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                // color: Colors.grey,
                width: 2,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey[800],
                width: 2,
              ),
            ),
            hoverColor: Colors.grey[200],
            fillColor: Colors.white,
            focusColor: Colors.grey[200],
            hintStyle:
                LiveFeedTheme.theme.inputDecorationTheme.hintStyle.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          value: state.type,
          onChanged: (value) =>
              context.read<ContactUsFormBloc>().add(TypeUpdated(value)),
        );
      },
    );
  }
}

class _EmailInput extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EmailInputState();
}

class _EmailInputState extends State<_EmailInput> {
  FocusNode _focusNode;

  String translateErrorText(EmailValidationError error) {
    switch (error) {
      case EmailValidationError.empty:
        return 'Required';
      case EmailValidationError.invalid:
        return 'Invalid email';
    }
  }

  @override
  void initState() {
    _focusNode = new FocusNode()..addListener(_focusListener);
    super.initState();
  }

  void _focusListener() {
    if (!context.read<ContactUsFormBloc>().state.formFocused) {
      context
          .read<ContactUsFormBloc>()
          .add(FormFocusChanged(_focusNode.hasFocus));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactUsFormBloc, ContactUsFormState>(
      builder: (context, state) {
        return TextField(
          onChanged: (value) =>
              context.read<ContactUsFormBloc>().add(EmailUpdated(value)),
          focusNode: _focusNode,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
            hintText: 'Email',
            filled: true,
            errorText: state.email.invalid
                ? translateErrorText(state.email.error)
                : null,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey[300],
                width: 1,
              ),
            ),
            errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                // color: Colors.grey,
                width: 2,
              ),
            ),
            focusedErrorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                // color: Colors.grey,
                width: 2,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey[800],
                width: 2,
              ),
            ),
            hoverColor: Colors.grey[200],
            fillColor: Colors.white,
            focusColor: Colors.grey[200],
            hintStyle:
                LiveFeedTheme.theme.inputDecorationTheme.hintStyle.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
            fontWeight: FontWeight.bold,
          ),
        );
      },
    );
  }
}

class _BodyInput extends StatefulWidget {
  _BodyInput({this.initialText});

  final String initialText;

  @override
  State<StatefulWidget> createState() =>
      _BodyInputState(initialText: initialText);
}

class _BodyInputState extends State<_BodyInput> {
  _BodyInputState({this.initialText});

  FocusNode _focusNode;
  TextEditingController _controller;

  final String initialText;

  @override
  void initState() {
    _focusNode = new FocusNode()..addListener(_focusListener);
    _controller = new TextEditingController();
    if (initialText != null) {
      _controller.text = initialText;
    }
    super.initState();
  }

  String translateErrorText(ContactUsBodyValidationError error) {
    switch (error) {
      case ContactUsBodyValidationError.empty:
        return 'Required';
      case ContactUsBodyValidationError.maxLimit:
        return 'Too long';
    }
  }

  void _focusListener() {
    if (!context.read<ContactUsFormBloc>().state.formFocused) {
      context
          .read<ContactUsFormBloc>()
          .add(FormFocusChanged(_focusNode.hasFocus));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactUsFormBloc, ContactUsFormState>(
      builder: (context, state) {
        return TextField(
          onChanged: (value) =>
              context.read<ContactUsFormBloc>().add(BodyUpdated(value)),
          controller: _controller,
          focusNode: _focusNode,
          maxLines: 6,
          maxLength: 2000,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
            hintText: 'Type your message here...',
            filled: true,
            errorText: state.body.invalid
                ? translateErrorText(state.body.error)
                : null,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey[300],
                width: 1,
              ),
            ),
            errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                // color: Colors.grey,
                width: 2,
              ),
            ),
            focusedErrorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                // color: Colors.grey,
                width: 2,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey[800],
                width: 2,
              ),
            ),
            hoverColor: Colors.grey[200],
            fillColor: Colors.white,
            focusColor: Colors.grey[200],
            hintStyle:
                LiveFeedTheme.theme.inputDecorationTheme.hintStyle.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
            fontWeight: FontWeight.bold,
          ),
        );
      },
    );
  }
}

class _SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      minWidth: double.infinity,
      color: Colors.grey[850],
      onPressed: () {},
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Text(
          'SUBMIT',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
