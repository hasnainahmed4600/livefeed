part of 'how_it_works_bloc.dart';

enum HowItWorksQuestion {
  what_livefeed,
  how_signup,
  why_otp,
  update_phone_how,
  what_if_lose_access,
  marketplace_howto,
}

const Map<HowItWorksQuestion, String> howItWorksQuestions = {
  HowItWorksQuestion.what_livefeed: 'What is LiveFEED?',
  HowItWorksQuestion.how_signup: 'How to sign up?',
  HowItWorksQuestion.why_otp:
      'Why are we using a one-time password and your cell phone instead of an old-school password on a sheet of paper or wall in your living room?',
  HowItWorksQuestion.update_phone_how: 'How to update my phone number?',
  HowItWorksQuestion.what_if_lose_access:
      'What if I don\'t have access to my phone number any longer?',
  HowItWorksQuestion.marketplace_howto: 'Marketplace How-to',
};

class HowItWorksState extends Equatable {
  const HowItWorksState({
    this.searchQuestion = '',
    this.displayingQuestions = HowItWorksQuestion.values,
    this.isSearching = false,
  });
  final String searchQuestion;
  final List<HowItWorksQuestion> displayingQuestions;
  final bool isSearching;

  HowItWorksState copyWith({
    String searchQuestion,
    List<HowItWorksQuestion> displayingQuestions,
    bool isSearching,
  }) {
    return HowItWorksState(
      searchQuestion: searchQuestion ?? this.searchQuestion,
      displayingQuestions: displayingQuestions ?? this.displayingQuestions,
      isSearching: isSearching ?? this.isSearching,
    );
  }

  @override
  List<Object> get props => [
        searchQuestion,
        displayingQuestions,
        isSearching,
      ];
}
