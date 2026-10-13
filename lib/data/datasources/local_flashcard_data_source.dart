import 'package:sqflite/sqflite.dart';

import '../../core/constants/app_constants.dart';
import '../../core/constants/app_strings.dart';
import '../../core/errors/app_exception.dart';
import '../../domain/models/flashcard_model.dart';
import 'database_service.dart';
import 'flashcard_data_source.dart';

class LocalFlashcardDataSource implements FlashcardDataSource {
  LocalFlashcardDataSource({DatabaseService? databaseService})
    : _databaseService = databaseService ?? DatabaseService.instance;

  final DatabaseService _databaseService;

  @override
  Future<List<FlashcardModel>> fetchFlashcards() async {
    try {
      final db = await _databaseService.database;
      final rows = await db.query(AppConstants.flashcardTable, orderBy: 'updated_at DESC');
      return rows.map(FlashcardModel.fromMap).toList(growable: false);
    } on DatabaseException catch (error) {
      throw AppException(AppStrings.failedToLoadFlashcards, code: error.getResultCode().toString());
    }
  }

  @override
  Future<FlashcardModel> insertFlashcard(FlashcardModel flashcard) async {
    try {
      final db = await _databaseService.database;
      final id = await db.insert(AppConstants.flashcardTable, flashcard.toMap()..remove('id'));
      return flashcard.copyWith(id: id);
    } on DatabaseException catch (error) {
      throw AppException(AppStrings.failedToAddFlashcard, code: error.getResultCode().toString());
    }
  }

  @override
  Future<FlashcardModel> editFlashcard(FlashcardModel flashcard) async {
    if (flashcard.id == null) {
      throw AppException(AppStrings.cannotUpdateWithoutId);
    }

    try {
      final db = await _databaseService.database;
      final count = await db.update(
        AppConstants.flashcardTable,
        flashcard.toMap()..remove('id'),
        where: 'id = ?',
        whereArgs: <Object>[flashcard.id!],
      );
      if (count == 0) {
        throw AppException(AppStrings.flashcardNotFound);
      }
      return flashcard;
    } on DatabaseException catch (error) {
      throw AppException(AppStrings.failedToUpdateFlashcard, code: error.getResultCode().toString());
    }
  }

  @override
  Future<void> removeFlashcard(int id) async {
    try {
      final db = await _databaseService.database;
      final count = await db.delete(AppConstants.flashcardTable, where: 'id = ?', whereArgs: <Object>[id]);
      if (count == 0) {
        throw AppException(AppStrings.flashcardNotFound);
      }
    } on DatabaseException catch (error) {
      throw AppException(AppStrings.failedToDeleteFlashcard, code: error.getResultCode().toString());
    }
  }
}
