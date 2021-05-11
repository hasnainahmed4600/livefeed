part of 'post_form_bloc.dart';

abstract class PostFormState extends Equatable {
  const PostFormState();

  @override
  List<Object> get props => [];
}

class PostFormLoadInProgress extends PostFormState {
  const PostFormLoadInProgress();
}

class PostFormLoadSuccess extends PostFormState {
  const PostFormLoadSuccess({
    this.headline = const HeadlineFormField.pure(),
    this.description = const DescriptionFormField.pure(),
    this.category = const CategoryFormField.pure(),
    this.selectedMedia = const SelectedMediaFormField.pure(),
    this.location = const LocationFormField.pure(),
    this.status = FormzStatus.pure,
    this.error = '',
  });

  final HeadlineFormField headline;
  final DescriptionFormField description;
  final CategoryFormField category;
  final SelectedMediaFormField selectedMedia;
  final LocationFormField location;
  final FormzStatus status;
  final String error;

  PostFormLoadSuccess copyWith({
    HeadlineFormField headline,
    DescriptionFormField description,
    CategoryFormField category,
    SelectedMediaFormField selectedMedia,
    LocationFormField location,
    FormzStatus status,
    String error,
  }) {
    return PostFormLoadSuccess(
      headline: headline ?? this.headline,
      description: description ?? this.description,
      category: category ?? this.category,
      selectedMedia: selectedMedia ?? this.selectedMedia,
      location: location ?? this.location,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  @override
  String toString() {
    return '{ headline: ${headline.value}, description: ${description.value}, category: ${category.value}, selectedMedia: ${selectedMedia.value.map((e) => e.file.path).toList().toString()}, location: ${location.value}, status: ${status.toString()} }';
  }

  @override
  List<Object> get props => [
        headline,
        description,
        category,
        selectedMedia,
        location,
        status,
        error,
      ];
}

class PostFormLoadFailure extends PostFormState {
  const PostFormLoadFailure(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}
