import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  var resutscore = 0;
  final Function resetHandler;
  Result(this.resutscore, this.resetHandler);

  String get resultPhrase {
    String resultText;
    if (resutscore <= 8) {
      resultText = "You Are Amazing";
    } else if (resutscore <= 18) {
      resultText = "You Are Good";
    } else if (resutscore <= 24) {
      resultText = "You Are Decent";
    } else {
      resultText = "You Are Bad";
    }
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            resultPhrase,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          FlatButton(
            onPressed: resetHandler,
            child: Text(
              "Reset Quiz",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
          )
        ],
      ),
    );
  }
}
