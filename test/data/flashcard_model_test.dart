import 'package:flutter_test/flutter_test.dart';
import 'package:quizflip/domain/models/flashcard_model.dart';

void main() {
  test('FlashcardModel validates required values', () {
    final model = FlashcardModel(
      id: null,
      question: 'Hi',
      answer: '',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    expect(model.isValid, isFalse);
    expect(model.validate().isNotEmpty, isTrue);
  });
}
