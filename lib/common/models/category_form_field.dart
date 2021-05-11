import 'package:formz/formz.dart';

enum CategoryValidationError { empty }

class CategoryFormField extends FormzInput<String, CategoryValidationError> {
  const CategoryFormField.pure() : super.pure('');

  const CategoryFormField.dirty([String value = '']) : super.dirty(value);

  @override
  CategoryValidationError validator(String value) {
    if (value?.isEmpty == true)
      return CategoryValidationError.empty;
    else
      return null;
  }

  String errorText() {
    if (this.invalid) {
      switch (this.error) {
        case CategoryValidationError.empty:
          return 'This is required';
      }
    }
    return null;
  }
}
