part of 'press_list_bloc.dart';

abstract class PressListEvent extends Equatable {
  const PressListEvent();

  @override
  List<Object> get props => [];
}

class PressListLoaded extends PressListEvent {
  const PressListLoaded();
}

class EndOfListReached extends PressListEvent {
  const EndOfListReached();
}

class VideoPlayed extends PressListEvent {
  const VideoPlayed(this.itemId);
  final String itemId;

  @override
  List<Object> get props => [itemId];
}

class VideoCleared extends PressListEvent {
  const VideoCleared(this.itemId);
  final String itemId;

  @override
  List<Object> get props => [itemId];
}
