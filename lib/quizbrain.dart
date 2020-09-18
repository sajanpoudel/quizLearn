import 'question.dart';
import 'question_bank.dart';

/// Holds the true or false questions and remembers which one is on screen.
class QuizBrain {
  /// Uses [questions] when they are given, otherwise the built in question bank.
  QuizBrain({List<Question>? questions})
      : _questionBank = questions ?? defaultQuestions;

  /// Index of the question that is currently shown.
  int _questionNumber = 0;
  final List<Question> _questionBank;

  /// How many questions the quiz has.
  int get questionCount => _questionBank.length;

  /// The number of the current question, starting at 1.
  int get currentNumber => _questionNumber + 1;

  /// True while there is at least one more question after the current one.
  bool get _hasNextQuestion => _questionNumber < _questionBank.length - 1;

  /// Moves to the next question, or stays on the last one.
  void questionChange() {
    if (_hasNextQuestion) {
      _questionNumber++;
    }
  }

  /// The text of the current question.
  String getQuestionText() {
    return _questionBank[_questionNumber].questionText;
  }

  /// The correct answer of the current question.
  bool getAnswer() {
    return _questionBank[_questionNumber].answer;
  }

  /// False once the last question is reached, which is when the score is shown.
  bool isNotFinished() {
    return _hasNextQuestion;
  }

  /// Starts the quiz again from the first question.
  void reset() {
    _questionNumber = 0;
  }
}
