part of 'timeline_post_bloc.dart';

class TimelinePostState extends Equatable {
  const TimelinePostState({
    this.skipContributions = 0,
    this.takeContributions = 5,
    this.totalContributions = 50,
    this.contributions = const [],
  });

  final int skipContributions;
  final int takeContributions;
  final int totalContributions;
  final List<PostComment> contributions;

  TimelinePostState copyWith({
    int skipContributions,
    int takeContributions,
    int totalContributions,
    List<PostComment> contributions,
  }) {
    return TimelinePostState(
      skipContributions: skipContributions ?? this.skipContributions,
      takeContributions: takeContributions ?? this.takeContributions,
      totalContributions: totalContributions ?? this.totalContributions,
      contributions: contributions ?? this.contributions,
    );
  }

  @override
  List<Object> get props => [
        skipContributions,
        takeContributions,
        totalContributions,
        contributions,
      ];
}
