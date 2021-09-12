import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tourney/data/data_providers/tourney_data_providers.dart';
import 'package:tourney/data/models/team.dart';
import 'package:tourney/data/repositories/tourney_repo.dart';

import '../data_providers/tourney_data_providers_mock.dart';

@GenerateMocks([TournamentDataProviders])
void main() {
  TourneyRepo repo = TourneyRepo();
  TournamentDataProviders dataProvidersMock = TournamentDataProvidersMock();

  test(
    'to test the initial setup',
    () {
      List<Team> teamsList = [
        Team(id: 1, imgPath: 'India'),
        Team(id: 2, imgPath: 'United States')
      ];
      when(dataProvidersMock.provideInitialTeams()).thenReturn(teamsList);
      // do something to wait for 2 seconds
      expect(repo.getInitialSetup(), teamsList);
    },
  );
}
