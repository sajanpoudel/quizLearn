import 'package:flutter/material.dart';
import 'quizbrain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

/// Holds the questions and tracks which one is currently shown.
QuizBrain quizBrain = QuizBrain();

void main() => runApp(const Quizzler());

/// Root widget of the app: a dark page that hosts the quiz.
class Quizzler extends StatelessWidget {
  const Quizzler({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade800,
        body: const SafeArea(
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
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  /// One check or cross per answered question.
  List<Icon> scoreIcons = [];
  /// Number of correct answers in this run.
  int correctScore = 0;

  /// Records whether [userAnswer] matches the current question, or shows the
  /// final score once the quiz is over.
  void checkAnswer(bool userAnswer) {
    bool correctAnswer = quizBrain.getAnswer();
    setState(() {
      if (correctAnswer == userAnswer) {
        scoreIcons.add(Icon(Icons.check, color: Colors.green.shade300));
        correctScore++;
      } else {
        scoreIcons.add(Icon(Icons.close, color: Colors.red.shade300));
      }
      if (!quizBrain.isNotFinished()) {
        Alert(
          context: context,
          type: AlertType.error,
          title: "SCORE : $correctScore",
          desc:
              "You answered $correctScore of ${quizBrain.questionCount} correctly (${(correctScore * 100 / quizBrain.questionCount).round()}%).",
          buttons: [
            DialogButton(
              onPressed: () {
                setState(() {
                  quizBrain.reset();
                  scoreIcons = [];
                  correctScore = 0;
                  Navigator.pop(context);
                });
              },
              width: 120,
              child: const Text(
                "RESTART",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            )
          ],
        ).show();
      }
    });
  }

  /// Shows the next question and rebuilds the screen.
  void changeQuestion() {
    setState(() {
      quizBrain.questionChange();
    });
  }

  Widget _buildAnswerButton({
    required String label,
    required Color color,
    required bool answer,
  }) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: color,
          ),
          child: Text(
            label,
            style: const TextStyle(
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
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Text(
            'Question ${quizBrain.currentNumber} of ${quizBrain.questionCount}',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16.0, color: Colors.white70),
          ),
        ),
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        _buildAnswerButton(
          label: 'True',
          color: Colors.lightGreen.shade600,
          answer: true,
        ),
        _buildAnswerButton(
          label: 'False',
          color: Colors.red.shade300,
          answer: false,
        ),
        Row(
          children: scoreIcons,
        )
      ],
    );
  }
}
