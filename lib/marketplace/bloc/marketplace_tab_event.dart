part of 'marketplace_tab_bloc.dart';

abstract class MarketplaceTabEvent extends Equatable {
  const MarketplaceTabEvent();

  @override
  List<Object> get props => [];
}

class MarketplaceTabUpdated extends MarketplaceTabEvent {
  final MarketplaceTab tab;

  const MarketplaceTabUpdated(this.tab);

  @override
  List<Object> get props => [tab];

  @override
  String toString() => 'MarketplaceTabUpdated { tab: $tab }';
}
