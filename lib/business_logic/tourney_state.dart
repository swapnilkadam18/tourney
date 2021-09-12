part of 'tourney_cubit.dart';

@immutable
abstract class TourneyState extends Equatable {
  const TourneyState();
}

class TourneyInitial extends TourneyState {
  final List<Team> teams;
  TourneyInitial({this.teams});

  @override
  List<Object> get props => [teams];
}

class TourneyLoader extends TourneyState {
  const TourneyLoader();
  @override
  List<Object> get props => [];
}

class TourneyMatches extends TourneyState {
  final List<Team> teams;
  TourneyMatches({this.teams});
  @override
  List<Object> get props => [teams];
}
