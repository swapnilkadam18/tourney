import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tourney/data/models/team.dart';
import 'package:tourney/data/repositories/tourney_repo.dart';

part 'tourney_state.dart';

class TourneyCubit extends Cubit<TourneyState> {
  TourneyRepo repo = TourneyRepo();

  TourneyCubit() : super(TourneyInitial());

  void startTheGame(List<Team> competitors) async {
    emit(const TourneyLoader());
    List<Team> winners = await repo.nextRound(competitors);
    emit(TourneyMatches(teams: winners));
  }

  void init() async {
    emit(const TourneyLoader());
    List<Team> initVal = await repo.getInitialSetup();
    emit(TourneyInitial(teams: initVal));
  }
}
