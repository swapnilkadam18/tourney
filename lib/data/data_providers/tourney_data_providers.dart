import 'dart:math';

import 'package:tourney/data/models/team.dart';

class TournamentDataProviders {
  final List<Team> initialTeams = [
    Team(id: 1, imgPath: 'assets/icons/icon_india.png'),
    Team(id: 2, imgPath: 'assets/icons/icon_korea.png'),
    Team(id: 3, imgPath: 'assets/icons/icon_liberia.png'),
    Team(id: 4, imgPath: 'assets/icons/icon_spain.png'),
  ];

  TournamentDataProviders();

  List<Team> provideInitialTeams() {
    return initialTeams;
  }

  List<Team> getWinners(List<Team> competitors) {
    List<Team> winnersList = [];
    int sizeOfCompetitors = competitors.length;
    if (sizeOfCompetitors == 1) {
      return competitors;
    } else if (competitors.length % 2 != 0) {
      return null;
    }
    double groups = (sizeOfCompetitors / 2.0);
    int startNdx = 0;
    int endNdx = 0;
    for (int i = 0; i < groups; i++) {
      endNdx = startNdx + 1;
      Team winner = playMatch(competitors[startNdx], competitors[endNdx]);
      winnersList.add(winner);
      startNdx = endNdx + 1;
    }
    return winnersList;
  }

  Team playMatch(Team competitor1, Team competitor2) {
    int max = 2;
    int random = Random().nextInt(max);
    if (random == 0) {
      return competitor1;
    } else {
      return competitor2;
    }
  }
}
