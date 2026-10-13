import '../../domain/models/flashcard_model.dart';

abstract class FlashcardDataSource {
  Future<List<FlashcardModel>> fetchFlashcards();
  Future<FlashcardModel> insertFlashcard(FlashcardModel flashcard);
  Future<FlashcardModel> editFlashcard(FlashcardModel flashcard);
  Future<void> removeFlashcard(int id);
}
