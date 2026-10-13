import 'package:flutter/foundation.dart';
import '../../data/datasources/flashcard_data_source.dart';
import '../../data/datasources/local_flashcard_data_source.dart';
import '../../data/datasources/web_flashcard_data_source.dart';
import '../../data/repositories/flashcard_repository_impl.dart';
import '../../domain/repositories/flashcard_repository.dart';
import '../../presentation/viewmodels/flashcard_view_model.dart';
import '../../presentation/viewmodels/theme_view_model.dart';

class DependencyInjection {
  DependencyInjection._();

  static late FlashcardDataSource _flashcardDataSource;
  static late FlashcardRepository _flashcardRepository;
  static late FlashcardViewModel _flashcardViewModel;
  static late ThemeViewModel _themeViewModel;

  static void init() {
    if (kIsWeb) {
      _flashcardDataSource = WebFlashcardDataSource();
    } else {
      _flashcardDataSource = LocalFlashcardDataSource();
    }
    _flashcardRepository = FlashcardRepositoryImpl(_flashcardDataSource);
    _flashcardViewModel = FlashcardViewModel(_flashcardRepository);
    _themeViewModel = ThemeViewModel();
  }

  static FlashcardViewModel get flashcardViewModel => _flashcardViewModel;
  static ThemeViewModel get themeViewModel => _themeViewModel;
}
