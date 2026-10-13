import '../models/flashcard_model.dart';

abstract class FlashcardRepository {
  Future<List<FlashcardModel>> getAllFlashcards();
  Future<FlashcardModel> createFlashcard(FlashcardModel flashcard);
  Future<FlashcardModel> updateFlashcard(FlashcardModel flashcard);
  Future<void> deleteFlashcard(int id);
}
