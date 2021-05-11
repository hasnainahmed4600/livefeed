import 'package:formz/formz.dart';
import 'package:livefeed/common/models/selected_media_file.dart';

enum SelectedMediaValidationError { empty, tooManyVideos, tooManyImages }

class SelectedMediaFormField
    extends FormzInput<List<SelectedMediaFile>, SelectedMediaValidationError> {
  const SelectedMediaFormField.pure() : super.pure(const []);

  const SelectedMediaFormField.dirty([List<SelectedMediaFile> value = const []])
      : super.dirty(value);

  @override
  SelectedMediaValidationError validator(List<SelectedMediaFile> value) {
    if (value?.isEmpty == true)
      return SelectedMediaValidationError.empty;
    if (value?.where((element) => element.isVideo).length > 1)
      return SelectedMediaValidationError.tooManyVideos;
    if (value?.where((element) => !element.isVideo).length > 5)
      return SelectedMediaValidationError.tooManyImages;
    return null;
  }

  String errorText() {
    if (this.invalid) {
      switch (this.error) {
        case SelectedMediaValidationError.empty:
          return 'This is required';
        case SelectedMediaValidationError.tooManyVideos:
          return 'Only 1 video allowed';
        case SelectedMediaValidationError.tooManyImages:
          return 'Up to 5 pictures allowed';
      }
    }
    return null;
  }
}
