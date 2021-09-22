![image](https://user-images.githubusercontent.com/35656849/134704972-3f18f13e-2742-40b3-9c68-1faa796c2449.png)

Quizlearn is a simple True-False game made with Flutter. This game has very simple UI and consists the questions related to physics , space  , technology and biology .


## Run it

```
flutter pub get
flutter run
```

## Project layout

- `main.dart` holds the UI and the answer handling.
- `quizbrain.dart` keeps the current position in the quiz.
- `question_bank.dart` holds the built in questions, grouped into physics, biology and technology.
- `question.dart` is the small model for one question and its answer.

## Questions

The questions live in `question_bank.dart`. To add one, append `Question('Your statement.', true)` to one of the topic lists (`physicsQuestions`, `biologyQuestions` or `technologyQuestions`). The quiz ends after the last question and the player can restart from the score dialog.

## Topics

The chips above the question limit the quiz to one topic. Add a new question to the list of its topic in `question_bank.dart`, or add a new list and register it in `questionTopics`.

## Explanations

A question can carry a short note: `Question('Statement.', true, explanation: 'Why it is true.')`. The note appears at the bottom of the screen after a wrong answer.

## Tests

```
flutter test
```

The tests cover `QuizBrain` (question order, finishing, reset) and the quiz page (answer buttons, score icons).

## Project layout

The Dart sources live in `lib/`, the tests in `test/`. Run `flutter create .` once if you need the Android and iOS runner folders.
