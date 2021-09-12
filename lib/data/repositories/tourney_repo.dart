import 'package:tourney/data/data_providers/tourney_data_providers.dart';
import 'package:tourney/data/models/team.dart';

class TourneyRepo {
  TournamentDataProviders dataProviders = TournamentDataProviders();

  TourneyRepo();

  Future<List<Team>> getInitialSetup() async {
    return await Future.delayed(
      Duration(seconds: 3),
      () => dataProviders.provideInitialTeams(),
    );
  }

  Future<List<Team>> nextRound(List<Team> competitors) async {
    return await Future.delayed(
      Duration(seconds: 3),
      () => dataProviders.getWinners(competitors),
    );
  }
}
