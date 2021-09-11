import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:test/test.dart';

part 'tourney_state.dart';

class TourneyCubit extends Cubit<TourneyState> {
  TourneyCubit() : super(TourneyInitial());
}
