import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:livefeed/login/bloc/login_bloc.dart';
import 'package:livefeed/common/models/phone_number_form_field.dart';
import 'package:livefeed/login/screen/header.dart';
import 'package:livefeed/signup/screen/signup_feature.dart';
import 'package:livefeed/theme.dart';
import 'package:formz/formz.dart';

enum _FormVerticalCompactness { comfortable, dense, sparse }

class LoginForm extends StatelessWidget {
  Widget _buildLegalText({
    final bool wide = false,
    final _FormVerticalCompactness compactness =
        _FormVerticalCompactness.comfortable,
  }) {
    return Column(
      children: [
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.only(
                top: wide || compactness == _FormVerticalCompactness.dense
                    ? 0
                    : 22),
            child: Text(
              'Standard message and data rates may apply',
              textAlign: TextAlign.center,
              style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
                color: Colors.grey,
                fontSize: 10,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: wide || compactness == _FormVerticalCompactness.dense
                  ? 5
                  : 110),
          child: Text(
            '© 2017 - 2021 LIVE MEDIA INC. ALL RIGHTS RESERVED. PATENTS APPLIED FOR IN THE US AND ABROAD.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.grey[800],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFormLayout({
    final bool wide = false,
    final _FormVerticalCompactness compactness =
        _FormVerticalCompactness.comfortable,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        left: compactness == _FormVerticalCompactness.dense ? 15 : 35,
        right: compactness == _FormVerticalCompactness.dense ? 15 : 35,
        top: compactness == _FormVerticalCompactness.dense ? 5 : 20,
      ),
      // width: double.infinity,
      child: Column(
        mainAxisAlignment:
            wide ? MainAxisAlignment.center : MainAxisAlignment.start,
        // Make cross axis alignment stretch to handle correct text rendering https://stackoverflow.com/questions/51638176/under-which-circumstances-textalign-property-works-in-flutter
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'LOGIN',
            style: LiveFeedTheme.theme.textTheme.headline1,
          ),
          Padding(
            padding: EdgeInsets.only(
                top: compactness == _FormVerticalCompactness.dense ? 0 : 10),
            child: Text(
              'Login has never been easier. Just enter your phone number for a one-time password!',
              textAlign: TextAlign.left,
              style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
                color: Color.fromRGBO(150, 150, 150, 1),
                fontWeight: FontWeight.w500,
                fontSize: 16,
                height: 1.58,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: compactness == _FormVerticalCompactness.dense ? 10 : 22),
            child: _PhoneNoInput(
              layoutDirection: Axis.horizontal,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: compactness == _FormVerticalCompactness.dense ? 10 : 28),
            child: _SubmitButton(),
          ),
          _SignupButton(),
          // _buildLegalText(),
          // Align(
          //   alignment: Alignment.center,
          //   child: Padding(
          //     padding: EdgeInsets.only(top: wide ? 5 : 22),
          //     child: Text(
          //       'Standard message and data rates may apply',
          //       textAlign: TextAlign.center,
          //       style: LiveFeedTheme.theme.textTheme.bodyText1.copyWith(
          //         color: Colors.grey,
          //         fontSize: 10,
          //         fontWeight: FontWeight.w500,
          //         fontStyle: FontStyle.italic,
          //       ),
          //     ),
          //   ),
          // ),
          // Padding(
          //   padding: EdgeInsets.only(top: wide ? 10 : 120),
          //   child: Text(
          //     '© 2017 - 2021 LIVE MEDIA INC. ALL RIGHTS RESERVED. PATENTS APPLIED FOR IN THE US AND ABROAD.',
          //     textAlign: TextAlign.center,
          //     style: TextStyle(
          //       fontFamily: 'Poppins',
          //       fontSize: 12,
          //       fontWeight: FontWeight.w500,
          //       color: Colors.grey[800],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildVerticalLayout(
      {final _FormVerticalCompactness compactness =
          _FormVerticalCompactness.comfortable}) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Header(
            height: compactness == _FormVerticalCompactness.dense ? 90 : 140,
          ),
          _buildFormLayout(compactness: compactness),
          _buildLegalText(compactness: compactness),
        ],
      ),
    );
  }

  Widget _buildWideLayout() {
    return Flex(
      direction: Axis.horizontal,
      children: [
        Expanded(
          flex: 1,
          child: Header(),
        ),
        Expanded(
          flex: 1,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildFormLayout(wide: true),
                _buildLegalText(wide: true),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 450 &&
            MediaQuery.of(context).orientation == Orientation.landscape) {
          return _buildWideLayout();
        } else {
          _FormVerticalCompactness verticalCompactness;

          if (constraints.maxHeight < 600) {
            verticalCompactness = _FormVerticalCompactness.dense;
          } else if (constraints.maxHeight > 700) {
            verticalCompactness = _FormVerticalCompactness.sparse;
          } else {
            verticalCompactness = _FormVerticalCompactness.comfortable;
          }

          return _buildVerticalLayout(
            compactness: verticalCompactness,
          );
        }
      },
    );
  }
}

class _CountryPicker extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CountryPickerState();
}

class _CountryPickerState extends State<_CountryPicker> {
  Country _selectedCountry;
  List<Country> get countries => countryCodes
      .map((e) => CountryPickerUtils.getCountryByIsoCode(e))
      .toList();

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

  Widget _buildSelectedItem(Country country) {
    return Row(
      // direction: Axis.horizontal,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CountryPickerUtils.getDefaultFlagImage(country),
        const Padding(padding: EdgeInsets.only(left: 5)),
        Text('+${country.phoneCode}'),
      ],
    );
  }

  List<DropdownMenuItem<Country>> _buildDropdownItems() {
    return countries.map((country) {
      return DropdownMenuItem<Country>(
        child: _buildDropdownItem(country),
        value: country,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        // return DropdownButton<Country>(
        //   value: CountryPickerUtils.getCountryByIsoCode(state.phoneIsoCode),
        //   selectedItemBuilder: (context) {
        //     return countries
        //         .map((country) => _buildSelectedItem(country))
        //         .toList();
        //   },
        //   items: _buildDropdownItems(),
        //   underline: Divider(
        //     color: Colors.transparent,
        //   ),
        //   onChanged: (country) {
        //     setState(() {
        //       _selectedCountry = country;
        //     });
        //     context
        //         .read<LoginBloc>()
        //         .add(PhoneCodeUpdated(country.isoCode, country.phoneCode));
        //   },
        // );
        // return Container(
        //   color: Colors.blue,
        //   child: Column(
        //     children: [
        //       _buildSelectedItem(
        //         CountryPickerUtils.getCountryByIsoCode(state.phoneIsoCode),
        //       ),
        //     ],
        //   ),
        // );
        return CountryPickerDropdown(
          initialValue: state.phoneIsoCode,
          itemBuilder: _buildDropdownItem,
          selectedItemBuilder: _buildSelectedItem,
          // iconEnabledColor: Colors.transparent,
          itemFilter: (c) => countryCodes.contains(c.isoCode),
          priorityList: [
            CountryPickerUtils.getCountryByIsoCode('US'),
            CountryPickerUtils.getCountryByIsoCode('BY'),
          ],
          sortComparator: (Country a, Country b) =>
              a.isoCode.compareTo(b.isoCode),
          onValuePicked: (Country country) {
            context
                .read<LoginBloc>()
                .add(PhoneCodeUpdated(country.isoCode, country.phoneCode));
            print("${country.phoneCode}");
          },
        );
      },
    );
  }
}

class _PhoneNoInput extends StatelessWidget {
  _PhoneNoInput({
    this.layoutDirection = Axis.horizontal,
  });
  final Axis layoutDirection;

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
      default:
        return 'Required';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) =>
          previous.phoneNumber != current.phoneNumber,
      builder: (context, state) {
        return Flex(
          direction: layoutDirection,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // _CountryPicker(),
            // TextField(
            //   onChanged: (phoneNumber) {
            //     context.read<LoginBloc>().add(PhoneNumberUpdated(phoneNumber));
            //   },
            //   keyboardType: TextInputType.phone,
            //   decoration: InputDecoration(
            //     errorText: state.phoneNumber.invalid
            //         ? translateErrorText(state.phoneNumber.error)
            //         : null,
            //     hintText: 'Enter your phone number',
            //   ),
            // ),
            Expanded(
              flex: 1,
              // child: _CountryPicker(),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: _CountryPicker(),
              ),
            ),
            Expanded(
              flex: 2,
              child: TextField(
                onChanged: (phoneNumber) {
                  context
                      .read<LoginBloc>()
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
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) =>
          previous.loginFormStatus != current.loginFormStatus,
      builder: (context, state) {
        return state.loginFormStatus.isSubmissionInProgress
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
                  onPressed: state.loginFormStatus.isValidated
                      ? () {
                          context
                              .read<LoginBloc>()
                              .add(const PhoneNumberSubmitted());
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

class _SignupButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      minWidth: double.infinity,
      onPressed: () => Navigator.of(context).push(SignupFeature.route()),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Text(
          'SIGN UP',
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

const List<String> countryCodes = [
  'AF',
  'AX',
  'AL',
  'DZ',
  'AS',
  'AD',
  'AO',
  'AI',
  'AQ',
  'AG',
  'AR',
  'AM',
  'AW',
  'AU',
  'AT',
  'AZ',
  'BS',
  'BH',
  'BD',
  'BB',
  'BY',
  'BE',
  'BZ',
  'BJ',
  'BM',
  'BT',
  'BO',
  'BA',
  'BW',
  'BV',
  'BR',
  'IO',
  'BN',
  'BG',
  'BF',
  'BI',
  'KH',
  'CM',
  'CA',
  'CV',
  'KY',
  'CF',
  'TD',
  'CL',
  'CN',
  'CX',
  'CC',
  'CO',
  'KM',
  'CG',
  'CD',
  'CK',
  'CR',
  'CI',
  'HR',
  'CU',
  'CY',
  'CZ',
  'DK',
  'DJ',
  'DM',
  'DO',
  'EC',
  'EG',
  'SV',
  'GQ',
  'ER',
  'EE',
  'ET',
  'FK',
  'FO',
  'FJ',
  'FI',
  'FR',
  'GF',
  'PF',
  'TF',
  'GA',
  'GM',
  'GE',
  'DE',
  'GH',
  'GI',
  'GR',
  'GL',
  'GD',
  'GP',
  'GU',
  'GT',
  'GG',
  'GN',
  'GW',
  'GY',
  'HT',
  'HM',
  'VA',
  'HN',
  'HK',
  'HU',
  'IS',
  'IN',
  'ID',
  'IR',
  'IQ',
  'IE',
  'IM',
  'IL',
  'IT',
  'JM',
  'JP',
  'JE',
  'JO',
  'KZ',
  'KE',
  'KI',
  'KP',
  'KR',
  'KW',
  'KG',
  'LA',
  'LV',
  'LB',
  'LS',
  'LR',
  'LY',
  'LI',
  'LT',
  'LU',
  'MO',
  'MK',
  'MG',
  'MW',
  'MY',
  'MV',
  'ML',
  'MT',
  'MH',
  'MQ',
  'MR',
  'MU',
  'YT',
  'MX',
  'FM',
  'MD',
  'MC',
  'MN',
  'ME',
  'MS',
  'MA',
  'MZ',
  'MM',
  'NA',
  'NR',
  'NP',
  'NL',
  'AN',
  'NC',
  'NZ',
  'NI',
  'NE',
  'NG',
  'NU',
  'NF',
  'MP',
  'NO',
  'OM',
  'PK',
  'PW',
  'PS',
  'PA',
  'PG',
  'PY',
  'PE',
  'PH',
  'PN',
  'PL',
  'PT',
  'PR',
  'QA',
  'RE',
  'RO',
  'RU',
  'RW',
  'BL',
  'SH',
  'KN',
  'LC',
  'MF',
  'PM',
  'VC',
  'WS',
  'SM',
  'ST',
  'SA',
  'SN',
  'RS',
  'SC',
  'SL',
  'SG',
  'SK',
  'SI',
  'SB',
  'SO',
  'ZA',
  'GS',
  'ES',
  'LK',
  'SD',
  'SR',
  'SJ',
  'SZ',
  'SE',
  'CH',
  'SY',
  'TW',
  'TJ',
  'TZ',
  'TH',
  'TL',
  'TG',
  'TK',
  'TO',
  'TT',
  'TN',
  'TR',
  'TM',
  'TC',
  'TV',
  'UG',
  'UA',
  'AE',
  'GB',
  'US',
  'UM',
  'UY',
  'UZ',
  'VU',
  'VE',
  'VN',
  'VG',
  'VI',
  'WF',
  'EH',
  'YE',
  'ZM',
  'ZW',
];
