import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:livefeed/common/models/category_form_field.dart';
import 'package:livefeed/common/models/description_form_field.dart';
import 'package:livefeed/common/models/headline_form_field.dart';
import 'package:livefeed/common/models/location_form_field.dart';
import 'package:livefeed/common/models/selected_media_file.dart';
import 'package:livefeed/common/models/selected_media_form_field.dart';

part 'post_form_event.dart';

part 'post_form_state.dart';

class PostFormBloc extends Bloc<PostFormEvent, PostFormState> {
  // TODO: Add parameters to indicate whether the form is for making a new post, editing an existing one, or contributing to a different post
  PostFormBloc() : super(PostFormLoadInProgress());

  @override
  Stream<PostFormState> mapEventToState(
    PostFormEvent event,
  ) async* {
    if (event is PostFormLoaded) {
      yield* _mapPostFormLoadedToState(event, state);
    } else if (event is HeadlineUpdated) {
      yield _mapHeadlineUpdatedToState(event, state);
    } else if (event is DescriptionUpdated) {
      yield _mapDescriptionUpdatedToState(event, state);
    } else if (event is CategoryUpdated) {
      yield _mapCategoryUpdatedToState(event, state);
    } else if (event is MediaFileAdded) {
      yield _mapMediaFileAddedToState(event, state);
    } else if (event is MediaFileRemoved) {
      yield _mapMediaFileRemovedToState(event, state);
    } else if (event is LocationUpdated) {
      yield _mapLocationUpdatedToState(event, state);
    }
  }

  Stream<PostFormState> _mapPostFormLoadedToState(
      PostFormLoaded event, PostFormState state) async* {
    yield PostFormLoadInProgress();
    yield PostFormLoadSuccess();
  }

  PostFormState _mapHeadlineUpdatedToState(
      HeadlineUpdated event, PostFormState state) {
    if (state is PostFormLoadSuccess) {
      final headline = HeadlineFormField.dirty(event.headline);
      return state.copyWith(
        headline: headline,
        status: Formz.validate([
          headline,
          state.description,
          state.category,
          state.selectedMedia,
          state.location
        ]),
      );
    } else
      return state;
  }

  PostFormState _mapDescriptionUpdatedToState(
      DescriptionUpdated event, PostFormState state) {
    if (state is PostFormLoadSuccess) {
      final description = DescriptionFormField.dirty(event.description);
      return state.copyWith(
        description: description,
        status: Formz.validate([
          state.headline,
          description,
          state.category,
          state.selectedMedia,
          state.location
        ]),
      );
    } else
      return state;
  }

  PostFormState _mapCategoryUpdatedToState(
      CategoryUpdated event, PostFormState state) {
    if (state is PostFormLoadSuccess) {
      final category = CategoryFormField.dirty(event.category);
      return state.copyWith(
        category: category,
        status: Formz.validate([
          state.headline,
          state.description,
          category,
          state.selectedMedia,
          state.location
        ]),
      );
    } else
      return state;
  }

  PostFormState _mapMediaFileAddedToState(
      MediaFileAdded event, PostFormState state) {
    if (state is PostFormLoadSuccess) {
      final selectedMedia = SelectedMediaFormField.dirty([
        ...state.selectedMedia.value,
        event.file,
      ]);
      return state.copyWith(
        selectedMedia: selectedMedia,
        status: Formz.validate([
          state.headline,
          state.description,
          state.category,
          selectedMedia,
          state.location
        ]),
      );
    } else
      return state;
  }

  PostFormState _mapMediaFileRemovedToState(
      MediaFileRemoved event, PostFormState state) {
    if (state is PostFormLoadSuccess) {
      final tempFiles = [
        ...state.selectedMedia.value
            .where((file) => file.id != event.fileId).toList(),
      ];
      final selectedMedia = SelectedMediaFormField.dirty(tempFiles);
      return state.copyWith(
        selectedMedia: selectedMedia,
        status: Formz.validate([
          state.headline,
          state.description,
          state.category,
          selectedMedia,
          state.location
        ]),
      );
    } else
      return state;
  }

  PostFormState _mapLocationUpdatedToState(
      LocationUpdated event, PostFormState state) {
    if (state is PostFormLoadSuccess) {
      final location = LocationFormField.dirty(event.location);
      return state.copyWith(
        location: location,
        status: Formz.validate([
          state.headline,
          state.description,
          state.category,
          state.selectedMedia,
          location
        ]),
      );
    } else
      return state;
  }
}
