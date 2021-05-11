part of 'how_it_works_bloc.dart';

abstract class HowItWorksEvent extends Equatable {
  const HowItWorksEvent();

  @override
  List<Object> get props => [];
}

class SearchQuestionUpdated extends HowItWorksEvent {
  const SearchQuestionUpdated(this.searchQuestion);
  final String searchQuestion;

  @override
  List<Object> get props => [searchQuestion];
}

class DisplayingQuestionsSearched extends HowItWorksEvent {
  const DisplayingQuestionsSearched(
      this.currentSearchString, this.displayingQuestions);
  final String currentSearchString;
  final List<HowItWorksQuestion> displayingQuestions;

  @override
  List<Object> get props => [displayingQuestions];
}

class DisplayingQuestionsReset extends HowItWorksEvent {
  const DisplayingQuestionsReset();
}
