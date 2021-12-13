import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quizzler/main.dart';
import 'package:quizzler/question.dart';
import 'package:quizzler/quizbrain.dart';

void main() {
  setUp(() {
    quizBrain = QuizBrain();
  });

  testWidgets('shows the first question and both buttons', (tester) async {
    await tester.pumpWidget(const Quizzler());
    expect(find.textContaining('wavelength of red light'), findsOneWidget);
    expect(find.text('True'), findsOneWidget);
    expect(find.text('False'), findsOneWidget);
  });

  testWidgets('a correct answer adds a check mark', (tester) async {
    await tester.pumpWidget(const Quizzler());
    await tester.tap(find.text('False'));
    await tester.pump();
    expect(find.byIcon(Icons.check), findsOneWidget);
    expect(find.byIcon(Icons.close), findsNothing);
  });

  testWidgets('a wrong answer adds a cross', (tester) async {
    await tester.pumpWidget(const Quizzler());
    await tester.tap(find.text('True'));
    await tester.pump();
    expect(find.byIcon(Icons.close), findsOneWidget);
  });

  testWidgets('answering moves to the next question', (tester) async {
    await tester.pumpWidget(const Quizzler());
    await tester.tap(find.text('False'));
    await tester.pump();
    expect(find.textContaining('wavelength of red light'), findsNothing);
    expect(find.textContaining('pungent odor'), findsOneWidget);
  });

  testWidgets('a wrong last answer is not counted', (tester) async {
    quizBrain = QuizBrain(questions: [Question('Only one.', true)]);
    await tester.pumpWidget(const Quizzler());
    await tester.tap(find.text('False'));
    await tester.pumpAndSettle();
    expect(find.text('SCORE : 0'), findsOneWidget);
  });

  testWidgets('restart goes back to the first question', (tester) async {
    quizBrain = QuizBrain(questions: [Question('First.', true), Question('Second.', true)]);
    await tester.pumpWidget(const Quizzler());
    await tester.tap(find.text('True'));
    await tester.pump();
    await tester.tap(find.text('True'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('RESTART'));
    await tester.pumpAndSettle();
    expect(find.text('First.'), findsOneWidget);
    expect(find.byIcon(Icons.check), findsNothing);
  });

  testWidgets('the last answer counts towards the score', (tester) async {
    quizBrain = QuizBrain(questions: [Question('Only one.', true)]);
    await tester.pumpWidget(const Quizzler());
    await tester.tap(find.text('True'));
    await tester.pumpAndSettle();
    expect(find.text('SCORE : 1'), findsOneWidget);
  });

  testWidgets('shows the progress of the quiz', (tester) async {
    quizBrain = QuizBrain(questions: [Question('First.', true), Question('Second.', true)]);
    await tester.pumpWidget(const Quizzler());
    expect(find.text('Question 1 of 2'), findsOneWidget);
  });

  testWidgets('the progress moves on after an answer', (tester) async {
    quizBrain = QuizBrain(questions: [Question('First.', true), Question('Second.', true)]);
    await tester.pumpWidget(const Quizzler());
    await tester.tap(find.text('True'));
    await tester.pump();
    expect(find.text('Question 2 of 2'), findsOneWidget);
  });

  testWidgets('the result shows the percentage', (tester) async {
    quizBrain = QuizBrain(questions: [Question('First.', true), Question('Second.', true)]);
    await tester.pumpWidget(const Quizzler());
    await tester.tap(find.text('True'));
    await tester.pump();
    await tester.tap(find.text('False'));
    await tester.pumpAndSettle();
    expect(find.text('You answered 1 of 2 correctly (50%).'), findsOneWidget);
  });
}
