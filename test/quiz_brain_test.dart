import 'package:flutter_test/flutter_test.dart';
import 'package:quizzler/question.dart';
import 'package:quizzler/quizbrain.dart';

void main() {
  test('starts on the first question', () {
    final brain = QuizBrain();
    expect(brain.getQuestionText(), startsWith('The wavelength of red light'));
  });

  test('the first answer is false', () {
    expect(QuizBrain().getAnswer(), isFalse);
  });

  test('questionChange moves to the next question', () {
    final brain = QuizBrain();
    final first = brain.getQuestionText();
    brain.questionChange();
    expect(brain.getQuestionText(), isNot(first));
  });
}
