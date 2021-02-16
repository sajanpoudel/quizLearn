import 'package:flutter/material.dart';
import 'quizbrain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = QuizBrain();

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade800,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreCheck = [];
  int correctScore = 0;
  void checkAnswer(bool userAnswer) {
    bool correctAnswer = quizBrain.getAnswer();
    setState(() {
      if (quizBrain.isNotFinished() == true) {
        if (correctAnswer == userAnswer) {
          scoreCheck.add(Icon(Icons.check, color: Colors.green[300]));
          correctScore++;
        } else {
          scoreCheck.add(Icon(Icons.close, color: Colors.red[300]));
        }
      } else {
        Alert(
          context: context,
          type: AlertType.error,
          title: "SCORE : $correctScore",
          desc: "You have completed the quiz.",
          buttons: [
            DialogButton(
              child: Text(
                "RESTART",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () {
                setState(() {
                  quizBrain.reset();
                  scoreCheck = [];
                  correctScore = 0;
                  Navigator.pop(context);
                });
              },
              width: 120,
            )
          ],
        ).show();
      }
    });
  }

//   List <String> questions=[
// 'You can lead  a cow down stairs but not up stairs.',
// 'Approximately one quarter of human bones are in the feet.',
// 'A slug\'s blood is green.'

//   ];
//   List <bool> answer = [
//     false,true,true
//   ];

  void changeQuestion() {
    setState(() {
      quizBrain.questionChange();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.lightGreen[600],
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                checkAnswer(true);
                changeQuestion();
                //The user picked true.
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red[300],
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                checkAnswer(false);
                //The user picked false.
                changeQuestion();
              },
            ),
          ),
        ),
        Row(
          children: scoreCheck,
        )
      ],
    );
  }
}
