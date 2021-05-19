![image](https://user-images.githubusercontent.com/35656849/134704972-3f18f13e-2742-40b3-9c68-1faa796c2449.png)

Quizlearn is a simple True-False game made with Flutter. This game has very simple UI and consists the questions related to physics , space  , technology and biology .


## Run it

```
flutter pub get
flutter run
```

## Project layout

- `main.dart` holds the UI and the answer handling.
- `quizbrain.dart` keeps the question bank and the current position.
- `question.dart` is the small model for one question and its answer.

## Questions

The questions live in `QuizBrain` in `quizbrain.dart`. To add one, append `Question('Your statement.', true)` to the `_questionBank` list. The quiz ends after the last question and the player can restart from the score dialog.
