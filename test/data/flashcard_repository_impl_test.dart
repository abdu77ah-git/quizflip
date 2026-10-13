import 'package:flutter_test/flutter_test.dart';
import 'package:quizflip/data/datasources/flashcard_data_source.dart';
import 'package:quizflip/data/repositories/flashcard_repository_impl.dart';
import 'package:quizflip/domain/models/flashcard_model.dart';

class FakeDataSource implements FlashcardDataSource {
  final List<FlashcardModel> _items = <FlashcardModel>[];

  @override
  Future<FlashcardModel> editFlashcard(FlashcardModel flashcard) async {
    final index = _items.indexWhere((e) => e.id == flashcard.id);
    _items[index] = flashcard;
    return flashcard;
  }

  @override
  Future<List<FlashcardModel>> fetchFlashcards() async => _items;

  @override
  Future<FlashcardModel> insertFlashcard(FlashcardModel flashcard) async {
    final created = flashcard.copyWith(id: _items.length + 1);
    _items.add(created);
    return created;
  }

  @override
  Future<void> removeFlashcard(int id) async {
    _items.removeWhere((e) => e.id == id);
  }
}

void main() {
  test('Repository delegates CRUD to datasource', () async {
    final repo = FlashcardRepositoryImpl(FakeDataSource());

    final created = await repo.createFlashcard(
      FlashcardModel(id: null, question: 'Q', answer: 'A', createdAt: DateTime.now(), updatedAt: DateTime.now()),
    );

    expect(created.id, 1);

    final all = await repo.getAllFlashcards();
    expect(all.length, 1);

    await repo.deleteFlashcard(1);
    final afterDelete = await repo.getAllFlashcards();
    expect(afterDelete, isEmpty);
  });
}
