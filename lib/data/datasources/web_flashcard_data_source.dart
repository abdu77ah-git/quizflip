import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/app_strings.dart';
import '../../core/errors/app_exception.dart';
import '../../domain/models/flashcard_model.dart';
import 'flashcard_data_source.dart';
import 'web_storage/web_storage.dart';

class WebFlashcardDataSource implements FlashcardDataSource {
  final List<FlashcardModel> _inMemoryCards = <FlashcardModel>[];

  List<FlashcardModel> _loadFromStorage() {
    if (!kIsWeb) return [];
    try {
      final jsonStr = WebStorage.instance.load(AppConstants.webStorageKey);
      if (jsonStr != null) {
        final List<dynamic> decoded = json.decode(jsonStr);
        return decoded
            .map((e) => FlashcardModel.fromMap(Map<String, dynamic>.from(e as Map)))
            .toList();
      }
    } catch (_) {
      // ignore
    }
    return [];
  }

  void _saveToStorage(List<FlashcardModel> cards) {
    if (!kIsWeb) return;
    try {
      final encoded = json.encode(cards.map((e) => e.toMap()).toList());
      WebStorage.instance.save(AppConstants.webStorageKey, encoded);
    } catch (_) {
      // ignore
    }
  }

  @override
  Future<List<FlashcardModel>> fetchFlashcards() async {
    final stored = _loadFromStorage();
    _inMemoryCards.clear();
    _inMemoryCards.addAll(stored);
    return _inMemoryCards;
  }

  @override
  Future<FlashcardModel> insertFlashcard(FlashcardModel flashcard) async {
    final id = _inMemoryCards.isEmpty ? 1 : (_inMemoryCards.map((e) => e.id ?? 0).reduce((a, b) => a > b ? a : b) + 1);
    final created = flashcard.copyWith(id: id);
    _inMemoryCards.insert(0, created);
    _saveToStorage(_inMemoryCards);
    return created;
  }

  @override
  Future<FlashcardModel> editFlashcard(FlashcardModel flashcard) async {
    final index = _inMemoryCards.indexWhere((e) => e.id == flashcard.id);
    if (index == -1) {
      throw AppException(AppStrings.flashcardNotFound);
    }
    _inMemoryCards[index] = flashcard;
    _saveToStorage(_inMemoryCards);
    return flashcard;
  }

  @override
  Future<void> removeFlashcard(int id) async {
    _inMemoryCards.removeWhere((e) => e.id == id);
    _saveToStorage(_inMemoryCards);
  }
}
