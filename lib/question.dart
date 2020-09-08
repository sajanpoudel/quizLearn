/// One true or false question and its correct answer.
class Question {
  /// The statement the player has to judge.
  final String questionText;
  /// True when the statement is correct.
  final bool answer;

  Question(this.questionText, this.answer);
}
