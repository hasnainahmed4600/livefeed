part of 'current_ads_bloc.dart';

abstract class CurrentAdsEvent extends Equatable {
  const CurrentAdsEvent();

  @override
  List<Object> get props => [];
}

class AdsLoaded extends CurrentAdsEvent {
  const AdsLoaded();
}

class AdEnableToggled extends CurrentAdsEvent {
  const AdEnableToggled(this.id);
  final String id;

  @override
  List<Object> get props => [id];
}

class AdDeleted extends CurrentAdsEvent {
  const AdDeleted(this.id);
  final String id;

  @override
  List<Object> get props => [id];
}
