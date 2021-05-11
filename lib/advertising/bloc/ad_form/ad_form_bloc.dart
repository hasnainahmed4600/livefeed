import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:livefeed/advertising/models/current_ad.dart';

part 'ad_form_event.dart';
part 'ad_form_state.dart';

class AdFormBloc extends Bloc<AdFormEvent, AdFormState> {
  AdFormBloc() : super(AdFormState());

  @override
  Stream<AdFormState> mapEventToState(
    AdFormEvent event,
  ) async* {
    if (event is TargetMarketUpdated) {
      yield _mapTargetMarketUpdatedToState(event, state);
    } else if (event is TargetViewUpdated) {
      yield _mapTargetViewUpdatedToState(event, state);
    } else if (event is CreateDesignRequestDescriptionUpdated) {
      yield _mapCreateDesignRequestDescriptionUpdatedToState(event, state);
    } else if (event is CreateDesignRequestImagePathUpdated) {
      yield _mapCreateDesignRequestImagePathUpdatedToState(event, state);
    } else if (event is UploadDesignImagePathUpdated) {
      yield _mapUploadDesignImagePathUpdatedToState(event, state);
    }
  }

  AdFormState _mapTargetMarketUpdatedToState(
      TargetMarketUpdated event, AdFormState state) {
    return state.copyWith(
      targetMarket: event.targetMarket,
    );
  }

  AdFormState _mapTargetViewUpdatedToState(
      TargetViewUpdated event, AdFormState state) {
    return state.copyWith(
      targetView: event.targetView,
    );
  }

  AdFormState _mapCreateDesignRequestDescriptionUpdatedToState(
      CreateDesignRequestDescriptionUpdated event, AdFormState state) {
    return state.copyWith(createDesignRequestDescription: event.description);
  }

  AdFormState _mapCreateDesignRequestImagePathUpdatedToState(
      CreateDesignRequestImagePathUpdated event, AdFormState state) {
    return state.copyWith(createDesignRequestImagePath: event.imagePath);
  }

  AdFormState _mapUploadDesignImagePathUpdatedToState(
      UploadDesignImagePathUpdated event, AdFormState state) {
    return state.copyWith(uploadDesignImagePath: event.imagePath);
  }
}
