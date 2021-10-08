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
}
