import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:livefeed/press/models/press_item_vm.dart';

part 'press_list_event.dart';
part 'press_list_state.dart';

class PressListBloc extends Bloc<PressListEvent, PressListState> {
  PressListBloc() : super(PressListState());

  @override
  Stream<PressListState> mapEventToState(
    PressListEvent event,
  ) async* {
    if (event is PressListLoaded) {
      yield _mapPressListLoadedToState(event, state);
    } else if (event is EndOfListReached) {
      yield _mapEndOfListReachedToState(event, state);
    } else if (event is VideoPlayed) {
      yield _mapVideoPlayedToState(event, state);
    } else if (event is VideoCleared) {
      yield _mapVideoClearedToState(event, state);
    }
  }

  PressListState _mapPressListLoadedToState(
      PressListLoaded event, PressListState state) {
    return state.copyWith(
      pressItems: [
        PressItemVm(
          imagePath: 'assets/images/india_festival3x.png',
          title: 'Celebration Of Kite Festival At liveFEED office',
          content:
              'Kite Flying Day Or Uttarayan or Makar Sankranti is one of the most beloved festivals celebrated in India. A day the people of India celebrate their harvest, a day when everyone gets on their rooftops to fly high their kites, filling the vast blue sky with nothing but kites.\n\nThe enthusiasm at LiveFEED was no less. Everyone was excited, and to add spark to the festivity the office walls were decorated with kites & ribbons that resonated with everyone\'s excitement.',
          postDate:
              DateTime.now().subtract(Duration(days: Random().nextInt(29))),
        ),
        PressItemVm(
          imagePath: 'assets/images/india_festival3x.png',
          title: 'Celebration Of Kite Festival At liveFEED office',
          content:
              'Kite Flying Day Or Uttarayan or Makar Sankranti is one of the most beloved festivals celebrated in India. A day the people of India celebrate their harvest, a day when everyone gets on their rooftops to fly high their kites, filling the vast blue sky with nothing but kites.\n\nThe enthusiasm at LiveFEED was no less. Everyone was excited, and to add spark to the festivity the office walls were decorated with kites & ribbons that resonated with everyone\'s excitement.',
          postDate:
              DateTime.now().subtract(Duration(days: Random().nextInt(29))),
          hasVideo: true,
          videoUrl:
              'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
        ),
        PressItemVm(
          imagePath: 'assets/images/india_festival3x.png',
          title: 'Celebration Of Kite Festival At liveFEED office',
          content:
              'Kite Flying Day Or Uttarayan or Makar Sankranti is one of the most beloved festivals celebrated in India. A day the people of India celebrate their harvest, a day when everyone gets on their rooftops to fly high their kites, filling the vast blue sky with nothing but kites.\n\nThe enthusiasm at LiveFEED was no less. Everyone was excited, and to add spark to the festivity the office walls were decorated with kites & ribbons that resonated with everyone\'s excitement.',
          postDate:
              DateTime.now().subtract(Duration(days: Random().nextInt(29))),
        ),
        PressItemVm(
          imagePath: 'assets/images/india_festival3x.png',
          title: 'Celebration Of Kite Festival At liveFEED office',
          content:
              'Kite Flying Day Or Uttarayan or Makar Sankranti is one of the most beloved festivals celebrated in India. A day the people of India celebrate their harvest, a day when everyone gets on their rooftops to fly high their kites, filling the vast blue sky with nothing but kites.\n\nThe enthusiasm at LiveFEED was no less. Everyone was excited, and to add spark to the festivity the office walls were decorated with kites & ribbons that resonated with everyone\'s excitement.',
          postDate:
              DateTime.now().subtract(Duration(days: Random().nextInt(29))),
          hasVideo: true,
          videoUrl:
              'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
        ),
        PressItemVm(
          imagePath: 'assets/images/india_festival3x.png',
          title: 'Celebration Of Kite Festival At liveFEED office',
          content:
              'Kite Flying Day Or Uttarayan or Makar Sankranti is one of the most beloved festivals celebrated in India. A day the people of India celebrate their harvest, a day when everyone gets on their rooftops to fly high their kites, filling the vast blue sky with nothing but kites.\n\nThe enthusiasm at LiveFEED was no less. Everyone was excited, and to add spark to the festivity the office walls were decorated with kites & ribbons that resonated with everyone\'s excitement.',
          postDate:
              DateTime.now().subtract(Duration(days: Random().nextInt(29))),
        ),
      ],
    );
  }

  PressListState _mapEndOfListReachedToState(
      EndOfListReached event, PressListState state) {
    var tempItems = [...state.pressItems];
    tempItems.addAll(
      [
        PressItemVm(
          imagePath: 'assets/images/india_festival3x.png',
          title: 'Celebration Of Kite Festival At liveFEED office',
          content:
              'Kite Flying Day Or Uttarayan or Makar Sankranti is one of the most beloved festivals celebrated in India. A day the people of India celebrate their harvest, a day when everyone gets on their rooftops to fly high their kites, filling the vast blue sky with nothing but kites.\n\nThe enthusiasm at LiveFEED was no less. Everyone was excited, and to add spark to the festivity the office walls were decorated with kites & ribbons that resonated with everyone\'s excitement.',
          postDate:
              DateTime.now().subtract(Duration(days: Random().nextInt(29))),
        ),
        PressItemVm(
          imagePath: 'assets/images/india_festival3x.png',
          title: 'Celebration Of Kite Festival At liveFEED office',
          content:
              'Kite Flying Day Or Uttarayan or Makar Sankranti is one of the most beloved festivals celebrated in India. A day the people of India celebrate their harvest, a day when everyone gets on their rooftops to fly high their kites, filling the vast blue sky with nothing but kites.\n\nThe enthusiasm at LiveFEED was no less. Everyone was excited, and to add spark to the festivity the office walls were decorated with kites & ribbons that resonated with everyone\'s excitement.',
          postDate:
              DateTime.now().subtract(Duration(days: Random().nextInt(29))),
          hasVideo: true,
          videoUrl:
              'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
        ),
        PressItemVm(
          imagePath: 'assets/images/india_festival3x.png',
          title: 'Celebration Of Kite Festival At liveFEED office',
          content:
              'Kite Flying Day Or Uttarayan or Makar Sankranti is one of the most beloved festivals celebrated in India. A day the people of India celebrate their harvest, a day when everyone gets on their rooftops to fly high their kites, filling the vast blue sky with nothing but kites.\n\nThe enthusiasm at LiveFEED was no less. Everyone was excited, and to add spark to the festivity the office walls were decorated with kites & ribbons that resonated with everyone\'s excitement.',
          postDate:
              DateTime.now().subtract(Duration(days: Random().nextInt(29))),
        ),
        PressItemVm(
          imagePath: 'assets/images/india_festival3x.png',
          title: 'Celebration Of Kite Festival At liveFEED office',
          content:
              'Kite Flying Day Or Uttarayan or Makar Sankranti is one of the most beloved festivals celebrated in India. A day the people of India celebrate their harvest, a day when everyone gets on their rooftops to fly high their kites, filling the vast blue sky with nothing but kites.\n\nThe enthusiasm at LiveFEED was no less. Everyone was excited, and to add spark to the festivity the office walls were decorated with kites & ribbons that resonated with everyone\'s excitement.',
          postDate:
              DateTime.now().subtract(Duration(days: Random().nextInt(29))),
          hasVideo: true,
          videoUrl:
              'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
        ),
        PressItemVm(
          imagePath: 'assets/images/india_festival3x.png',
          title: 'Celebration Of Kite Festival At liveFEED office',
          content:
              'Kite Flying Day Or Uttarayan or Makar Sankranti is one of the most beloved festivals celebrated in India. A day the people of India celebrate their harvest, a day when everyone gets on their rooftops to fly high their kites, filling the vast blue sky with nothing but kites.\n\nThe enthusiasm at LiveFEED was no less. Everyone was excited, and to add spark to the festivity the office walls were decorated with kites & ribbons that resonated with everyone\'s excitement.',
          postDate:
              DateTime.now().subtract(Duration(days: Random().nextInt(29))),
        ),
      ],
    );
    return state.copyWith(pressItems: tempItems);
  }

  PressListState _mapVideoPlayedToState(
      VideoPlayed event, PressListState state) {
    print('Video played: ${event.itemId}');
    return state.copyWith(activeVideoItemId: event.itemId);
  }

  PressListState _mapVideoClearedToState(
      VideoCleared event, PressListState state) {
    if (event.itemId == state.activeVideoItemId) {
      return state.copyWith(activeVideoItemId: '');
    } else {
      return state;
    }
  }
}
