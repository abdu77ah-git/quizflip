import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/constants/app_constants.dart';
import '../core/di/dependency_injection.dart';
import '../core/theme/app_theme.dart';
import '../presentation/viewmodels/flashcard_view_model.dart';
import '../presentation/viewmodels/theme_view_model.dart';
import '../routing/app_router.dart';
import '../routing/navigation_service.dart';

class AppBootstrap {
  static void run() {
    WidgetsFlutterBinding.ensureInitialized();
    DependencyInjection.init();
    runApp(const QuizFlipApp());
  }
}

class QuizFlipApp extends StatelessWidget {
  const QuizFlipApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeViewModel>(create: (_) => DependencyInjection.themeViewModel),
        ChangeNotifierProvider<FlashcardViewModel>(create: (_) => DependencyInjection.flashcardViewModel),
      ],
      child: Consumer<ThemeViewModel>(
        builder: (context, themeViewModel, _) {
          return MaterialApp(
            title: AppConstants.appName,
            navigatorKey: NavigationService.navigatorKey,
            debugShowCheckedModeBanner: false,
            themeMode: themeViewModel.themeMode,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            initialRoute: AppRouter.initialRoute,
            onGenerateRoute: AppRouter.generateRoute,
          );
        },
      ),
    );
  }
}
