part of 'apptab_bloc.dart';

abstract class ApptabEvent extends Equatable {
  const ApptabEvent();

  @override
  List<Object> get props => [];
}

class TabUpdated extends ApptabEvent {
  final AppTab tab;

  const TabUpdated(this.tab);

  @override
  List<Object> get props => [tab];

  @override
  String toString() => 'TabUpdated { tab: $tab }';
}
