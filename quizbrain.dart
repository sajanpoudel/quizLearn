import 'question.dart';

class QuizBrain {
  int _questionNumber = 0;
  List<Question> _questionBank = [
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
        'It takes 170,000 YEARS, on average, for a photon to travel from the centre of the sun to it\'s surface.',
        true),
    Question('Silver is the most conductive of metals.', true),
  ];
  void questionChange() {
    if (_questionNumber < _questionBank.length - 1) {
      _questionNumber++;
    }
  }

  String getQuestionText() {
    return _questionBank[_questionNumber].questionText;
  }

  bool getAnswer() {
    return _questionBank[_questionNumber].answer;
  }

  bool isNotFinished() {
    if (_questionNumber < _questionBank.length - 1) {
      return true;
    } else {
      return false;
    }
  }

  void reset() {
    _questionNumber = 0;
  }
}
