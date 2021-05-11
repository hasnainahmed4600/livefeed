import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'how_it_works_event.dart';
part 'how_it_works_state.dart';

class HowItWorksBloc extends Bloc<HowItWorksEvent, HowItWorksState> {
  HowItWorksBloc() : super(HowItWorksState());

  @override
  Stream<HowItWorksState> mapEventToState(
    HowItWorksEvent event,
  ) async* {
    if (event is SearchQuestionUpdated) {
      yield _mapSearchQuestionUpdatedToState(event, state);
    } else if (event is DisplayingQuestionsSearched) {
      yield _mapDisplayingQuestionsSearchedToState(event, state);
    } else if (event is DisplayingQuestionsReset) {
      yield state.copyWith(
        displayingQuestions: HowItWorksQuestion.values,
        isSearching: false,
        searchQuestion: '',
      );
    }
  }

  HowItWorksState _mapSearchQuestionUpdatedToState(
      SearchQuestionUpdated event, HowItWorksState state) {
    return state.copyWith(searchQuestion: event.searchQuestion);
  }

  HowItWorksState _mapDisplayingQuestionsSearchedToState(
      DisplayingQuestionsSearched event, HowItWorksState state) {
    return state.copyWith(
      searchQuestion: event.currentSearchString,
      displayingQuestions: event.displayingQuestions,
      isSearching: true,
    );
  }
}
