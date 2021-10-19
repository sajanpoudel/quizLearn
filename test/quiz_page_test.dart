import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quizzler/main.dart';
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
}
