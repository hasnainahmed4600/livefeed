import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:livefeed/advertising/models/current_ad.dart';

part 'current_ads_event.dart';
part 'current_ads_state.dart';

class CurrentAdsBloc extends Bloc<CurrentAdsEvent, CurrentAdsState> {
  CurrentAdsBloc() : super(CurrentAdsState());

  @override
  Stream<CurrentAdsState> mapEventToState(
    CurrentAdsEvent event,
  ) async* {
    if (event is AdEnableToggled) {
      yield _mapAdEnableToggledToState(event, state);
    } else if (event is AdDeleted) {
      yield _mapAdDeletedToState(event, state);
    } else if (event is AdsLoaded) {
      yield _mapAdsLoadedToState(event, state);
    }
  }

  CurrentAdsState _mapAdsLoadedToState(AdsLoaded event, CurrentAdsState state) {
    var tempAds = <CurrentAd>[
      CurrentAd(
        id: '1',
        targetMarket: TargetMarket.worldwide,
        enabled: true,
        imagePath: 'assets/images/fashion_ad3x.png',
        networkImage: false,
      ),
      CurrentAd(
        id: '2',
        targetMarket: TargetMarket.local,
        enabled: false,
        imagePath: 'assets/images/ad_poster3x.png',
        networkImage: false,
        address: 'Chicago, IL',
        zipCode: '60606',
      ),
      CurrentAd(
        id: '3',
        targetMarket: TargetMarket.hyperlocal,
        enabled: false,
        imagePath: 'assets/images/ad_poster3x.png',
        networkImage: false,
        address: 'Chicago, IL',
        zipCode: '60606',
      ),
    ];

    return state.copyWith(ads: tempAds);
  }

  CurrentAdsState _mapAdEnableToggledToState(
      AdEnableToggled event, CurrentAdsState state) {
    print('Ad Enable Toggled');
    var tempAds = [...state.ads];
    var adToUpdate = tempAds.where((ad) => ad.id == event.id).first;
    adToUpdate = adToUpdate.copyWith(
      enabled: !adToUpdate.enabled,
    );

    var indexToUpdate = state.ads.indexWhere((ad) => ad.id == event.id);
    tempAds[indexToUpdate] = adToUpdate;

    return state.copyWith(ads: tempAds);
  }

  CurrentAdsState _mapAdDeletedToState(AdDeleted event, CurrentAdsState state) {
    var tempAds = [...state.ads];
    tempAds.removeWhere((ad) => ad.id == event.id);

    return state.copyWith(ads: tempAds);
  }
}
