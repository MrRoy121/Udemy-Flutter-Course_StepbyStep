import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final Function stateHandlers;
  final String answer;

  Answer(this.stateHandlers, this.answer);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: RaisedButton(
          child: Text(answer),
          color: Colors.blueAccent,
          textColor: Colors.white,
          onPressed: stateHandlers),
    );
  }
}
