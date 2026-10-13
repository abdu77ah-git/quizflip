import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:quizflip/core/constants/app_strings.dart';
import 'package:quizflip/domain/models/flashcard_model.dart';
import 'package:quizflip/domain/repositories/flashcard_repository.dart';
import 'package:quizflip/presentation/viewmodels/flashcard_view_model.dart';
import 'package:quizflip/presentation/viewmodels/theme_view_model.dart';
import 'package:quizflip/presentation/views/home_screen.dart';

class EmptyRepository implements FlashcardRepository {
  @override
  Future<FlashcardModel> createFlashcard(FlashcardModel flashcard) {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteFlashcard(int id) async {}

  @override
  Future<List<FlashcardModel>> getAllFlashcards() async => <FlashcardModel>[];

  @override
  Future<FlashcardModel> updateFlashcard(FlashcardModel flashcard) {
    throw UnimplementedError();
  }
}

void main() {
  testWidgets('HomeScreen shows empty state when no flashcards', (tester) async {
    final vm = FlashcardViewModel(EmptyRepository());
    final themeVm = ThemeViewModel();

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<ThemeViewModel>.value(value: themeVm),
          ChangeNotifierProvider<FlashcardViewModel>.value(value: vm),
        ],
        child: MaterialApp(
          themeMode: themeVm.themeMode,
          home: const HomeScreen(),
        ),
      ),
    );

    await tester.pump();
    await tester.pump(const Duration(milliseconds: 50));

    expect(find.text(AppStrings.emptyTitle), findsOneWidget);
  });
}
