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

  test('isNotFinished is true at the start', () {
    expect(QuizBrain().isNotFinished(), isTrue);
  });

  test('the quiz finishes on the last question', () {
    final brain = QuizBrain();
    var steps = 0;
    while (brain.isNotFinished()) {
      brain.questionChange();
      steps++;
    }
    expect(steps, 13);
    expect(brain.isNotFinished(), isFalse);
  });

  test('questionChange stays on the last question', () {
    final brain = QuizBrain();
    for (var i = 0; i < 40; i++) {
      brain.questionChange();
    }
    final last = brain.getQuestionText();
    brain.questionChange();
    expect(brain.getQuestionText(), last);
  });

  test('reset returns to the first question', () {
    final brain = QuizBrain();
    final first = brain.getQuestionText();
    brain.questionChange();
    brain.questionChange();
    brain.reset();
    expect(brain.getQuestionText(), first);
    expect(brain.isNotFinished(), isTrue);
  });

  test('Question keeps its text and answer', () {
    final question = Question('Water is wet.', true);
    expect(question.questionText, 'Water is wet.');
    expect(question.answer, isTrue);
  });

  test('uses the questions it is given', () {
    final brain = QuizBrain(questions: [Question('Only one.', true)]);
    expect(brain.getQuestionText(), 'Only one.');
    expect(brain.isNotFinished(), isFalse);
  });

  test('counts the questions', () {
    final brain = QuizBrain(questions: [Question('a', true), Question('b', false), Question('c', true)]);
    expect(brain.questionCount, 3);
  });

  test('currentNumber starts at one and follows the questions', () {
    final brain = QuizBrain(questions: [Question('a', true), Question('b', false)]);
    expect(brain.currentNumber, 1);
    brain.questionChange();
    expect(brain.currentNumber, 2);
  });
}
