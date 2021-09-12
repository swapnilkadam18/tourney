import 'package:test/test.dart';
import 'package:tourney/data/data_providers/tourney_data_providers.dart';
import 'package:tourney/data/models/team.dart';

void main() {
  TournamentDataProviders dataProviders;
  List<Team> initialTeams;
  setUp(() {
    dataProviders = TournamentDataProviders();
    initialTeams = [
      Team(id: 1, imgPath: 'India'),
      Team(id: 2, imgPath: 'United States'),
      Team(id: 3, imgPath: 'Canada'),
      Team(id: 4, imgPath: 'New Zealand')
    ];
  });

  test('to test initial teams', () {
    expect(dataProviders.provideInitialTeams(), initialTeams);
  });

  group(
    'tourney data providers',
    () {
      test(
          'should return as it is, when only one team is in the list that team will'
          'be the winner', () {
        List<Team> input = [Team(id: 1, imgPath: 'India')];
        expect(dataProviders.getWinners(input).length, 1);
      });

      test('should return null if uneven number of teams', () {
        List<Team> input = [
          Team(id: 1, imgPath: 'India'),
          Team(id: 2, imgPath: 'United States'),
          Team(id: 3, imgPath: 'Canada'),
        ];
        expect(dataProviders.getWinners(input), null);
      });

      test('should return 2 teams when 4 teams are provided to it', () {
        List<Team> input = [
          Team(id: 1, imgPath: 'India'),
          Team(id: 2, imgPath: 'United States'),
          Team(id: 3, imgPath: 'Canada'),
          Team(id: 4, imgPath: 'New Zealand')
        ];
        expect(dataProviders.getWinners(input).length, 2);
      });

      test('should return 1 team when 2 teams are provided to it', () {
        List<Team> input = [
          Team(id: 1, imgPath: 'India'),
          Team(id: 2, imgPath: 'United States')
        ];
        expect(dataProviders.getWinners(input).length, 1);
      });
    },
  );
}
