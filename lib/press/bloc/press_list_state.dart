part of 'press_list_bloc.dart';

class PressListState extends Equatable {
  const PressListState({
    this.pressItems = const [],
    this.activeVideoItemId,
    this.error,
  });

  final List<PressItemVm> pressItems;
  final String activeVideoItemId;
  final String error;

  PressListState copyWith({
    List<PressItemVm> pressItems,
    String activeVideoItemId,
    String error,
  }) {
    return PressListState(
      pressItems: pressItems ?? this.pressItems,
      activeVideoItemId: activeVideoItemId ?? this.activeVideoItemId,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [
        pressItems,
        activeVideoItemId,
        error,
      ];
}
