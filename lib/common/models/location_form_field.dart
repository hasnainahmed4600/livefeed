import 'package:formz/formz.dart';

enum LocationValidationError { empty }

class LocationFormField extends FormzInput<String, LocationValidationError> {
  const LocationFormField.pure() : super.pure('');

  const LocationFormField.dirty([String value = '']) : super.dirty(value);

  @override
  LocationValidationError validator(String value) {
    if (value?.isEmpty == true)
      return LocationValidationError.empty;
    else
      return null;
  }

  String errorText() {
    if (this.invalid) {
      switch (this.error) {
        case LocationValidationError.empty:
          return 'This is required';
      }
    }
    return null;
  }
}
