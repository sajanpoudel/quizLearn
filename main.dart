import 'package:flutter/material.dart';
import 'quizbrain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

/// Holds the questions and tracks which one is currently shown.
QuizBrain quizBrain = QuizBrain();

void main() => runApp(Quizzler());

/// Root widget of the app: a dark page that hosts the quiz.
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

/// The quiz screen with the question, the two answer buttons and the score row.
class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  /// One check or cross per answered question.
  List<Icon> scoreIcons = [];
  int correctScore = 0;

  /// Records whether [userAnswer] matches the current question, or shows the
  /// final score once the quiz is over.
  void checkAnswer(bool userAnswer) {
    bool correctAnswer = quizBrain.getAnswer();
    setState(() {
      if (quizBrain.isNotFinished()) {
        if (correctAnswer == userAnswer) {
          scoreIcons.add(Icon(Icons.check, color: Colors.green[300]));
          correctScore++;
        } else {
          scoreIcons.add(Icon(Icons.close, color: Colors.red[300]));
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
                  scoreIcons = [];
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

  void changeQuestion() {
    setState(() {
      quizBrain.questionChange();
    });
  }

  Widget _buildAnswerButton({String label, Color color, bool answer}) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: FlatButton(
          textColor: Colors.white,
          color: color,
          child: Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
          ),
          onPressed: () {
            checkAnswer(answer);
            changeQuestion();
          },
        ),
      ),
    );
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
        _buildAnswerButton(
          label: 'True',
          color: Colors.lightGreen[600],
          answer: true,
        ),
        _buildAnswerButton(
          label: 'False',
          color: Colors.red[300],
          answer: false,
        ),
        Row(
          children: scoreIcons,
        )
      ],
    );
  }
}
