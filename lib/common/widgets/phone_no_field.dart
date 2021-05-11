import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dropdown.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:livefeed/common/models/phone_number_form_field.dart';

class PhoneNoField extends StatelessWidget {
  PhoneNoField({
    this.layoutDirection = Axis.horizontal,
    this.onCountryChanged,
    this.onPhoneNumberChanged,
    this.currentPhoneNumber,
    this.initialValueIsoCode,
  });

  final Axis layoutDirection;
  final String initialValueIsoCode;
  final PhoneNumberFormField currentPhoneNumber;
  final Function(Country country) onCountryChanged;
  final Function(String number) onPhoneNumberChanged;

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
            child: _CountryPicker(
              initialValueIsoCode: initialValueIsoCode,
              onNumberPicked:
                  onCountryChanged != null ? onCountryChanged : null,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: TextField(
            onChanged:
                onPhoneNumberChanged != null ? onPhoneNumberChanged : null,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              errorText:
                  currentPhoneNumber != null && currentPhoneNumber.invalid
                      ? translateErrorText(currentPhoneNumber.error)
                      : null,
              hintText: 'Enter your phone number',
            ),
          ),
        ),
      ],
    );
  }
}

class _CountryPicker extends StatefulWidget {
  _CountryPicker({
    this.initialValueIsoCode,
    this.onNumberPicked,
  });

  final String initialValueIsoCode;
  final Function(Country country) onNumberPicked;

  @override
  State<StatefulWidget> createState() => _CountryPickerState(
        onNumberPicked: onNumberPicked,
        initialValueIsoCode: initialValueIsoCode,
      );
}

class _CountryPickerState extends State<_CountryPicker> {
  _CountryPickerState({
    this.onNumberPicked,
    this.initialValueIsoCode,
  });

  Country _selectedCountry;

  List<Country> get countries => _countryCodes
      .map((e) => CountryPickerUtils.getCountryByIsoCode(e))
      .toList();

  final String initialValueIsoCode;

  final Function(Country country) onNumberPicked;

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
      initialValue: initialValueIsoCode,
      itemBuilder: _buildDropdownItem,
      selectedItemBuilder: _buildSelectedItem,
      // iconEnabledColor: Colors.transparent,
      itemFilter: (c) => _countryCodes.contains(c.isoCode),
      priorityList: [
        CountryPickerUtils.getCountryByIsoCode('US'),
        CountryPickerUtils.getCountryByIsoCode('BY'),
      ],
      sortComparator: (Country a, Country b) => a.isoCode.compareTo(b.isoCode),
      onValuePicked: onNumberPicked,
    );
  }
}

const List<String> _countryCodes = [
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
