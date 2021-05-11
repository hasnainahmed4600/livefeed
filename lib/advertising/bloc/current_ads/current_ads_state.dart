part of 'current_ads_bloc.dart';

class CurrentAdsState extends Equatable {
  const CurrentAdsState({
    this.ads = const [],
  });

  final List<CurrentAd> ads;

  CurrentAdsState copyWith({
    List<CurrentAd> ads,
  }) {
    return CurrentAdsState(
      ads: ads ?? this.ads,
    );
  }

  @override
  List<Object> get props => [ads];
}
