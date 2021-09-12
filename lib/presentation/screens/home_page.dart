import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tourney/business_logic/tourney_cubit.dart';
import 'package:tourney/data/models/team.dart';
import 'package:tourney/presentation/widgets/play_button.dart';

class TourneyDashboard extends StatefulWidget {
  TourneyDashboard({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _TourneyDashboardState createState() => _TourneyDashboardState();
}

class _TourneyDashboardState extends State<TourneyDashboard> {
  List<Team> teams;
  List<Team> quarterFinalist;
  List<Team> semiFinalist;
  List<Team> winner;
  String buttonTitle;
  String placeHolder = 'assets/icons/icon_question.png';
  String titleSemis = 'Play Semis';
  String titleFinals = 'Play Finals';
  String titleRestart = 'Restart';
  double avatarRadius = 35.0;
  ConfettiController _controllerCenter;

  @override
  void initState() {
    init();
    _controllerCenter =
        ConfettiController(duration: const Duration(seconds: 4));
    startOrRestart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF111328),
        shadowColor: Colors.white,
        title: Text(
          widget.title,
        ), // status bar brightness
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: BlocConsumer<TourneyCubit, TourneyState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is TourneyLoader) {
                return buildLoading();
              } else if (state is TourneyInitial) {
                teams = state.teams;
                quarterFinalist = teams;
                buttonTitle = titleSemis;
                return buildUi(buttonTitle, quarterFinalist);
              } else if (state is TourneyMatches) {
                teams = state.teams;
                if (teams.length == 2) {
                  semiFinalist = teams;
                  buttonTitle = titleFinals;
                  return buildUi(buttonTitle, teams);
                } else if (teams.length == 1) {
                  winner = teams;
                  buttonTitle = titleRestart;
                  _controllerCenter.play();
                  return buildUi(buttonTitle, teams);
                }
              }
            },
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  void dispose() {
    _controllerCenter.dispose();
    super.dispose();
  }

  Widget buildLoading() {
    return Center(
      child: SpinKitDoubleBounce(
        color: Color(0xFFEB1555),
        size: 80.0,
      ),
    );
  }

  Widget buildUi(String title, List<Team> teamsToBeShown) {
    if (teamsToBeShown.length == 1) {}
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          //finalist row
          showCelebration(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              showAvatar(winner.isNotEmpty ? winner[0].mImgPath : placeHolder),
            ],
          ),
          SizedBox(
            height: 30.0,
          ),
          //semi finalist row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              showAvatar(semiFinalist.isNotEmpty
                  ? semiFinalist[0].mImgPath
                  : placeHolder),
              showAvatar(semiFinalist.isNotEmpty
                  ? semiFinalist[1].mImgPath
                  : placeHolder),
            ],
          ),
          SizedBox(
            height: 30.0,
          ),
          //quarter finalist
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              showAvatar(quarterFinalist.isNotEmpty
                  ? quarterFinalist[0].mImgPath
                  : placeHolder),
              showAvatar(quarterFinalist.isNotEmpty
                  ? quarterFinalist[1].mImgPath
                  : placeHolder),
              showAvatar(quarterFinalist.isNotEmpty
                  ? quarterFinalist[2].mImgPath
                  : placeHolder),
              showAvatar(quarterFinalist.isNotEmpty
                  ? quarterFinalist[3].mImgPath
                  : placeHolder),
            ],
          ),
          SizedBox(
            height: 30.0,
          ),
          PlayButton(
            onClicked: playTournament,
            color: Color(0xFFEB1555),
            buttonTitle: title,
          ),
        ],
      ),
    );
  }

  void playTournament() {
    if (buttonTitle == 'Restart') {
      init();
      startOrRestart();
    } else {
      BlocProvider.of<TourneyCubit>(context).startTheGame(teams);
    }
  }

  Widget showAvatar(String imagePath) {
    return CircleAvatar(
      child: Transform.scale(
        scale: 1,
        child: Image.asset(
          imagePath,
          height: 60,
          width: 60,
          fit: BoxFit.fitWidth,
        ),
      ),
      backgroundColor: Color(0xFF111328),
      radius: avatarRadius,
    );
  }

  void startOrRestart() {
    BlocProvider.of<TourneyCubit>(context).init();
  }

  void init() {
    quarterFinalist = [];
    semiFinalist = [];
    winner = [];
    buttonTitle = '';
  }

  Widget showCelebration() {
    return Align(
      alignment: Alignment.topCenter,
      child: ConfettiWidget(
        confettiController: _controllerCenter,
        blastDirection: pi / 2,
        blastDirectionality: BlastDirectionality.explosive,
        particleDrag: 0.05,
        emissionFrequency: 0.05,
        numberOfParticles: 50,
        gravity: 0.05,
        shouldLoop: false,
        colors: const [
          Colors.green,
          Colors.blue,
          Colors.pink,
          Colors.orange,
          Colors.purple
        ], // manually specify the colors to be used
      ),
    );
  }
}
