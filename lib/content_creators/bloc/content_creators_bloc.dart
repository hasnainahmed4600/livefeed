import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'content_creators_event.dart';

part 'content_creators_state.dart';

class ContentCreatorsBloc
    extends Bloc<ContentCreatorsEvent, ContentCreatorsState> {
  ContentCreatorsBloc() : super(ContentCreatorsState());

  @override
  Stream<ContentCreatorsState> mapEventToState(
    ContentCreatorsEvent event,
  ) async* {
    if (event is HeadlineUpdated) {
      yield _mapHeadlineUpdatedToState(event, state);
    } else if (event is DescriptionUpdated) {
      yield _mapDescriptionUpdatedToState(event, state);
    } else if (event is CategoryUpdated) {
      yield _mapCategoryUpdatedToState(event, state);
    } else if (event is PhotoAdded) {
      yield _mapPhotoAddedToState(event, state);
    } else if (event is VideoAdded) {
      yield _mapVideoAddedToState(event, state);
    } else if (event is LocationUpdated) {
      yield _mapLocationUpdatedToState(event, state);
    }
  }

  ContentCreatorsState _mapHeadlineUpdatedToState(
      HeadlineUpdated event, ContentCreatorsState state) {
    return state.copyWith(headline: event.headline);
  }

  ContentCreatorsState _mapDescriptionUpdatedToState(
      DescriptionUpdated event, ContentCreatorsState state) {
    return state.copyWith(description: event.description);
  }

  ContentCreatorsState _mapCategoryUpdatedToState(
      CategoryUpdated event, ContentCreatorsState state) {
    return state.copyWith(category: event.category);
  }

  ContentCreatorsState _mapPhotoAddedToState(
      PhotoAdded event, ContentCreatorsState state) {
    return state.copyWith(
      uploadedImagePaths: [
        ...state.uploadedImagePaths,
        event.photoPath,
      ],
    );
  }

  ContentCreatorsState _mapVideoAddedToState(
      VideoAdded event, ContentCreatorsState state) {
    return state.copyWith(
      uploadedVideoPaths: [
        ...state.uploadedVideoPaths,
        event.videoPath,
      ],
    );
  }

  ContentCreatorsState _mapLocationUpdatedToState(
      LocationUpdated event, ContentCreatorsState state) {
    return state.copyWith(location: event.location);
  }
}
