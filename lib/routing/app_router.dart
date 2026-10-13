import 'package:flutter/material.dart';

import '../core/constants/app_strings.dart';
import '../domain/models/flashcard_model.dart';
import '../presentation/views/add_edit_flashcard_screen.dart';
import '../presentation/views/home_screen.dart';
import 'route_names.dart';

class AppRouter {
  AppRouter._();

  static const String initialRoute = RouteNames.home;

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.home:
        return MaterialPageRoute<void>(builder: (_) => const HomeScreen());
      case RouteNames.addFlashcard:
        return MaterialPageRoute<void>(builder: (_) => const AddEditFlashcardScreen());
      case RouteNames.editFlashcard:
        final card = settings.arguments as FlashcardModel;
        return MaterialPageRoute<void>(builder: (_) => AddEditFlashcardScreen(card: card));
      default:
        return MaterialPageRoute<void>(
          builder: (_) => const Scaffold(body: Center(child: Text(AppStrings.routeNotFound))),
        );
    }
  }
}
