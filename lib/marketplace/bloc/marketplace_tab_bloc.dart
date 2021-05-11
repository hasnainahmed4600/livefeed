import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'marketplace_tab_event.dart';

enum MarketplaceTab {
  content_buyers,
  content_creators, /* how_it_works */
}

class MarketplaceTabBloc extends Bloc<MarketplaceTabEvent, MarketplaceTab> {
  MarketplaceTabBloc() : super(MarketplaceTab.content_buyers);

  @override
  Stream<MarketplaceTab> mapEventToState(
    MarketplaceTabEvent event,
  ) async* {
    if (event is MarketplaceTabUpdated) {
      yield event.tab;
    }
  }
}
