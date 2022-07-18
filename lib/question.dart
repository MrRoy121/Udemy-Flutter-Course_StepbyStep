import 'package:flutter/cupertino.dart';

class Question extends StatelessWidget {
  final String question;

  Question(this.question);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        margin: EdgeInsets.all(10),
        child: Text(
          question,
          style: TextStyle(
            fontSize: 28,
          ),
          textAlign: TextAlign.center,
        ),
    );
  }
}
