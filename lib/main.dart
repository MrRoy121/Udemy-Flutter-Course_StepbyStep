import 'package:flutter/material.dart';
import 'package:udemy_flutter_course/result.dart';


import 'answer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final _question = const [
    {
      'question': "What's is your favourite color?",
      'answer': [
        {'text': 'Red', 'score': 10},
        {'text': 'Green', 'score': 2},
        {'text': 'Blue', 'score': 6},
        {'text': 'Pink', 'score': 4}
      ]
    },
    {
      'question': "What's is your favourite animal?",
      'answer': [
        {'text': 'Dog', 'score': 4},
        {'text': 'Cat', 'score': 6},
        {'text': 'Fish', 'score': 10},
        {'text': 'Tiger', 'score': 10}
      ]
    },
    {
      'question': "What's is your favourite Item?",
      'answer': [
        {'text': 'Mobile', 'score': 2},
        {'text': 'Tab', 'score': 10},
        {'text': 'Laptop', 'score': 8},
        {'text': 'Computer', 'score': 4}
      ]
    }
  ];
  var _questionIndex = 0;
  var _totalScore = 0;

  void _resetQuiz(){
    setState((){
      _questionIndex = 0;
      _totalScore = 0;
    });
  }
  void _answerQuestion(int score) {
    _totalScore += score;
    setState(() {
      _questionIndex += 1;
    });
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("App Bar"),
        ),
        body: _questionIndex < _question.length
            ? Quiz(
                questionIndex: _questionIndex,
                answerQuestion: _answerQuestion,
                question: _question,
              )
            : Result(_totalScore, _resetQuiz),
      ),
    );
  }
}
