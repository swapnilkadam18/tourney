import 'package:flutter/material.dart';

class PlayButton extends StatelessWidget {
  final Color color;
  final String buttonTitle;
  final Function onClicked;

  final kStyleButton = TextStyle(
      color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold);

  PlayButton({this.onClicked, this.color, this.buttonTitle});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20),
      color: color,
      onPressed: onClicked,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Text(
        buttonTitle,
        style: kStyleButton,
      ),
    );
  }
}
