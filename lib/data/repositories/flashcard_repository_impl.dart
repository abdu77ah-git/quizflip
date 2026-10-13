import '../../domain/models/flashcard_model.dart';
import '../../domain/repositories/flashcard_repository.dart';
import '../datasources/flashcard_data_source.dart';

class FlashcardRepositoryImpl implements FlashcardRepository {
  FlashcardRepositoryImpl(this._dataSource);

  final FlashcardDataSource _dataSource;

  @override
  Future<FlashcardModel> createFlashcard(FlashcardModel flashcard) {
    return _dataSource.insertFlashcard(flashcard);
  }

  @override
  Future<void> deleteFlashcard(int id) {
    return _dataSource.removeFlashcard(id);
  }

  @override
  Future<List<FlashcardModel>> getAllFlashcards() {
    return _dataSource.fetchFlashcards();
  }

  @override
  Future<FlashcardModel> updateFlashcard(FlashcardModel flashcard) {
    return _dataSource.editFlashcard(flashcard);
  }
}
