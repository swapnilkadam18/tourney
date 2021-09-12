import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tourney/business_logic/tourney_cubit.dart';
import 'package:tourney/data/models/team.dart';

void main() {
  group(
    'Tourney cubit',
    () {
      TourneyCubit tourneyCubit;
      List<Team> initialTeams;
      List<Team> outputTeams;

      setUp(() {
        tourneyCubit = TourneyCubit();
        initialTeams = [
          Team(id: 1, imgPath: 'India'),
          Team(id: 2, imgPath: 'United States'),
          Team(id: 3, imgPath: 'Canada'),
          Team(id: 4, imgPath: 'New Zealand')
        ];
        outputTeams = [
          Team(id: 1, imgPath: 'India'),
          Team(id: 3, imgPath: 'Canada'),
        ];
      });

      tearDown(() => tourneyCubit.close());

      blocTest(
        'the tourney Cubit should emit a TourneyInitial when the init function is called',
        build: () => tourneyCubit,
        act: (cubit) => tourneyCubit.init(),
        expect: () => [TourneyLoader(), TourneyInitial(teams: initialTeams)],
      );

      blocTest(
        'the tourney Cubit should emit a TourneyMatches when the startTheGame function is called',
        build: () => tourneyCubit,
        act: (cubit) => tourneyCubit.startTheGame(initialTeams),
        expect: () => [TourneyLoader(), TourneyMatches(teams: outputTeams)],
      );
    },
  );
}
