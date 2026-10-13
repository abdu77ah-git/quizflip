import 'package:flutter/foundation.dart';

import '../../core/constants/app_strings.dart';
import '../../core/errors/error_handler.dart';
import '../../core/helpers/logger.dart';
import '../../core/helpers/validators.dart';
import '../../domain/models/flashcard_model.dart';
import '../../domain/repositories/flashcard_repository.dart';

class FlashcardViewModel extends ChangeNotifier {
  FlashcardViewModel(this._repository);

  final FlashcardRepository _repository;

  final List<FlashcardModel> _flashcards = <FlashcardModel>[];

  bool _isLoading = false;
  String? _errorMessage;
  int _currentIndex = 0;
  bool _showAnswer = false;

  List<FlashcardModel> get flashcards => List<FlashcardModel>.unmodifiable(_flashcards);
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  int get currentIndex => _currentIndex;
  bool get showAnswer => _showAnswer;

  bool get hasCards => _flashcards.isNotEmpty;
  bool get canGoNext => _currentIndex < _flashcards.length - 1;
  bool get canGoPrevious => _currentIndex > 0;

  FlashcardModel? get currentCard {
    if (!hasCards) {
      return null;
    }
    return _flashcards[_currentIndex];
  }

  Future<void> loadFlashcards() async {
    _setLoading(true);
    _clearError();

    try {
      final items = await _repository.getAllFlashcards();
      _flashcards
        ..clear()
        ..addAll(items);
      _currentIndex = _flashcards.isEmpty ? 0 : _currentIndex.clamp(0, _flashcards.length - 1);
      _showAnswer = false;
    } catch (error, stackTrace) {
      AppLogger.error(AppStrings.logLoadFlashcardsFailed, error: error, stackTrace: stackTrace);
      _errorMessage = ErrorHandler.mapToMessage(error);
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> addFlashcard({required String question, required String answer}) async {
    final validationError = _validateInput(question: question, answer: answer);
    if (validationError != null) {
      _errorMessage = validationError;
      notifyListeners();
      return false;
    }

    _setLoading(true);
    _clearError();

    try {
      final now = DateTime.now();
      final flashcard = FlashcardModel(
        id: null,
        question: question.trim(),
        answer: answer.trim(),
        createdAt: now,
        updatedAt: now,
      );
      final created = await _repository.createFlashcard(flashcard);
      _flashcards.insert(0, created);
      _currentIndex = 0;
      _showAnswer = false;
      return true;
    } catch (error, stackTrace) {
      AppLogger.error(AppStrings.logAddFlashcardFailed, error: error, stackTrace: stackTrace);
      _errorMessage = ErrorHandler.mapToMessage(error);
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> updateFlashcard({required int id, required String question, required String answer}) async {
    final validationError = _validateInput(question: question, answer: answer);
    if (validationError != null) {
      _errorMessage = validationError;
      notifyListeners();
      return false;
    }

    _setLoading(true);
    _clearError();

    try {
      final index = _flashcards.indexWhere((item) => item.id == id);
      if (index == -1) {
        _errorMessage = AppStrings.flashcardNotFound;
        return false;
      }

      final updated = _flashcards[index].copyWith(
        question: question.trim(),
        answer: answer.trim(),
        updatedAt: DateTime.now(),
      );

      final saved = await _repository.updateFlashcard(updated);
      _flashcards[index] = saved;
      _showAnswer = false;
      return true;
    } catch (error, stackTrace) {
      AppLogger.error(AppStrings.logUpdateFlashcardFailed, error: error, stackTrace: stackTrace);
      _errorMessage = ErrorHandler.mapToMessage(error);
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> deleteFlashcard(int id) async {
    _setLoading(true);
    _clearError();

    try {
      await _repository.deleteFlashcard(id);
      _flashcards.removeWhere((item) => item.id == id);
      if (_currentIndex >= _flashcards.length && _flashcards.isNotEmpty) {
        _currentIndex = _flashcards.length - 1;
      }
      if (_flashcards.isEmpty) {
        _currentIndex = 0;
      }
      _showAnswer = false;
      return true;
    } catch (error, stackTrace) {
      AppLogger.error(AppStrings.logDeleteFlashcardFailed, error: error, stackTrace: stackTrace);
      _errorMessage = ErrorHandler.mapToMessage(error);
      return false;
    } finally {
      _setLoading(false);
    }
  }

  void nextCard() {
    if (!canGoNext) {
      return;
    }
    _currentIndex += 1;
    _showAnswer = false;
    notifyListeners();
  }

  void previousCard() {
    if (!canGoPrevious) {
      return;
    }
    _currentIndex -= 1;
    _showAnswer = false;
    notifyListeners();
  }

  void toggleAnswerVisibility() {
    _showAnswer = !_showAnswer;
    notifyListeners();
  }

  void clearErrorMessage() {
    _clearError();
    notifyListeners();
  }

  String? _validateInput({required String question, required String answer}) {
    return Validators.question(question) ?? Validators.answer(answer);
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
  }
}
