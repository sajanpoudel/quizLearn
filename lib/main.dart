import 'package:flutter/material.dart';
import 'question_bank.dart';
import 'quizbrain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

/// Holds the questions and tracks which one is currently shown.
QuizBrain quizBrain = QuizBrain();

/// Percentage of correct answers that turns the result dialog green.
const int passMark = 60;

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

  /// The highest score of the runs played since the app was opened.
  int bestScore = 0;

  /// Records whether [userAnswer] matches the current question, or shows the
  /// final score once the quiz is over.
  void checkAnswer(bool userAnswer) {
    bool correctAnswer = quizBrain.getAnswer();
    final explanation = quizBrain.getExplanation();
    setState(() {
      if (correctAnswer == userAnswer) {
        scoreIcons.add(Icon(Icons.check, color: Colors.green.shade300));
        correctScore++;
      } else {
        scoreIcons.add(Icon(Icons.close, color: Colors.red.shade300));
        _showExplanation(explanation);
      }
      if (!quizBrain.isNotFinished()) {
        _showResult();
      }
    });
  }

  /// Tells the player why the answer was wrong, when the question has a note.
  void _showExplanation(String? explanation) {
    if (explanation == null) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(explanation)));
  }

  /// Opens the score dialog. Passing at least [passMark] percent counts as a good result.
  void _showResult() {
    final total = quizBrain.questionCount;
    final percent = (correctScore * 100 / total).round();
    final isNewBest = correctScore > bestScore;
    if (isNewBest) bestScore = correctScore;
    Alert(
      context: context,
      type: percent >= passMark ? AlertType.success : AlertType.error,
      title: "SCORE : $correctScore",
      desc: "You answered $correctScore of $total correctly ($percent%).\n"
          "${isNewBest ? 'New best score!' : 'Best score: $bestScore'}",
      buttons: [
        DialogButton(
          onPressed: _restart,
          width: 120,
          child: const Text(
            "RESTART",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ],
    ).show();
  }

  /// Closes the dialog and starts a new run with the questions reshuffled.
  void _restart() {
    setState(() {
      quizBrain.reset(shuffle: true);
      scoreIcons = [];
      correctScore = 0;
      Navigator.pop(context);
    });
  }

  /// The topic the quiz is limited to, or null for all questions.
  String? topic;

  /// Starts a new quiz with the questions of [chosen], or with every question when it is null.
  void _chooseTopic(String? chosen) {
    setState(() {
      topic = chosen;
      quizBrain = QuizBrain(
        questions: chosen == null ? null : questionTopics[chosen],
      );
      scoreIcons = [];
      correctScore = 0;
    });
  }

  Widget _buildTopicChips() {
    return SizedBox(
      height: 44,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          for (final name in questionTopics.keys)
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: ChoiceChip(
                label: Text(name),
                selected: topic == name,
                onSelected: (selected) => _chooseTopic(selected ? name : null),
              ),
            ),
        ],
      ),
    );
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
        _buildTopicChips(),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Text(
            'Question ${quizBrain.currentNumber} of ${quizBrain.questionCount}',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16.0, color: Colors.white70),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: LinearProgressIndicator(
            value: scoreIcons.length / quizBrain.questionCount,
            backgroundColor: Colors.white24,
            color: Colors.lightGreen.shade600,
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
