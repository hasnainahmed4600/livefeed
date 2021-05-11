part of 'ad_form_bloc.dart';

abstract class AdFormEvent extends Equatable {
  const AdFormEvent();

  @override
  List<Object> get props => [];
}

class TargetMarketUpdated extends AdFormEvent {
  const TargetMarketUpdated(this.targetMarket);
  final TargetMarket targetMarket;

  @override
  List<Object> get props => [targetMarket];
}

class TargetViewUpdated extends AdFormEvent {
  const TargetViewUpdated(this.targetView);
  final TargetView targetView;

  @override
  List<Object> get props => [targetView];
}

class CreateDesignRequestDescriptionUpdated extends AdFormEvent {
  const CreateDesignRequestDescriptionUpdated(this.description);
  final String description;

  @override
  List<Object> get props => [description];
}

class CreateDesignRequestImagePathUpdated extends AdFormEvent {
  const CreateDesignRequestImagePathUpdated(this.imagePath);
  final String imagePath;

  @override
  List<Object> get props => [imagePath];
}

class UploadDesignImagePathUpdated extends AdFormEvent {
  const UploadDesignImagePathUpdated(this.imagePath);
  final String imagePath;

  @override
  List<Object> get props => [imagePath];
}
