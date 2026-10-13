import 'package:flutter_test/flutter_test.dart';
import 'package:quizflip/domain/models/flashcard_model.dart';
import 'package:quizflip/domain/repositories/flashcard_repository.dart';
import 'package:quizflip/presentation/viewmodels/flashcard_view_model.dart';

class FakeRepository implements FlashcardRepository {
  final List<FlashcardModel> _items = <FlashcardModel>[];

  @override
  Future<FlashcardModel> createFlashcard(FlashcardModel flashcard) async {
    final created = flashcard.copyWith(id: _items.length + 1);
    _items.insert(0, created);
    return created;
  }

  @override
  Future<void> deleteFlashcard(int id) async {
    _items.removeWhere((e) => e.id == id);
  }

  @override
  Future<List<FlashcardModel>> getAllFlashcards() async => _items;

  @override
  Future<FlashcardModel> updateFlashcard(FlashcardModel flashcard) async {
    final index = _items.indexWhere((e) => e.id == flashcard.id);
    _items[index] = flashcard;
    return flashcard;
  }
}

void main() {
  test('addFlashcard creates card and updates state', () async {
    final vm = FlashcardViewModel(FakeRepository());

    final result = await vm.addFlashcard(question: 'What is Flutter?', answer: 'An SDK');

    expect(result, isTrue);
    expect(vm.flashcards.length, 1);
    expect(vm.currentCard?.question, 'What is Flutter?');
  });

  test('navigation works across cards', () async {
    final vm = FlashcardViewModel(FakeRepository());

    await vm.addFlashcard(question: 'Question 1', answer: 'Answer 1');
    await vm.addFlashcard(question: 'Question 2', answer: 'Answer 2');

    expect(vm.currentIndex, 0);
    vm.nextCard();
    expect(vm.currentIndex, 1);
    vm.previousCard();
    expect(vm.currentIndex, 0);
  });
}
