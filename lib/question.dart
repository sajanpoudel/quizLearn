/// One true or false question and its correct answer.
class Question {
  /// The statement the player has to judge.
  final String questionText;

  /// True when the statement is correct.
  final bool answer;

  /// A short note that explains the correct answer, shown after a wrong guess.
  final String? explanation;

  Question(this.questionText, this.answer, {this.explanation});
}
