import 'dart:ffi';

import 'package:flutter/material.dart';

import 'answer.dart';

class Quiz extends StatelessWidget {
  final Function answerQuestion;
  final int questionIndex;
  final List<Map<String, Object>> question;


  Quiz({
    @required this.question,
    @required this.answerQuestion,
    @required this.questionIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Question(question[questionIndex]['question'] as String),
        ...(question[questionIndex]['answer'] as List<Map<String,Object>>).map((answer) {
          return Answer(() => answerQuestion(answer['score']), answer['text']as String);
        }).toList(),
      ],
    );
  }
}
