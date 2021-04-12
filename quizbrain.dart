import 'question.dart';

/// Holds the true or false questions and remembers which one is on screen.
class QuizBrain {
  /// Index of the question that is currently shown.
  int _questionNumber = 0;
  final List<Question> _questionBank = [
    Question('The wavelength of red light is shorter than that of blue light.',
        false),
    Question('Helium gives off a pungent odor.', false),
    Question('Approximately one quarter of human bones are in the feet.', true),
    Question('A slug\'s blood is green.', true),
    Question(
        'The small intestine is about three-and-a-half times the length of your body.',
        true),
    Question(
        'Microsoft and Apple are two examples of how open-source companies can become global leaders in their industries.',
        false),
    Question(
        'Bananas are curved because they grow upwards towards the sun.', true),
    Question(
        'In an era of steadily rising costs, computing costs have been decreasing dramatically because of the rapid developments in both hardware and software technology.',
        true),
    Question('If you went into space without a spacesuit on, you\'d explode.',
        false),
    Question(
        'The total surface area of two human lungs is approximately 70 square metres.',
        true),
    Question('Google was originally called \"Backrub\".', true),
    Question(
        'Chocolate affects a dog\'s heart and nervous system; a few ounces are enough to kill a small dog.',
        true),
    Question(
        'It takes 170,000 YEARS, on average, for a photon to travel from the centre of the sun to its surface.',
        true),
    Question('Silver is the most conductive of metals.', true),
  ];
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
