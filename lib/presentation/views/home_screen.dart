import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_strings.dart';
import '../../domain/models/flashcard_model.dart';
import '../../routing/navigation_service.dart';
import '../../routing/route_names.dart';
import '../viewmodels/flashcard_view_model.dart';
import '../viewmodels/theme_view_model.dart';
import '../widgets/app_button.dart';
import '../widgets/confirmation_dialog.dart';
import '../widgets/empty_state_widget.dart';
import '../widgets/flashcard_widget.dart';
import '../widgets/loading_widget.dart';
import '../widgets/snackbar_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FlashcardViewModel>().loadFlashcards();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FlashcardViewModel>(
      builder: (context, vm, _) {
        final card = vm.currentCard;

        if (vm.errorMessage != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            SnackbarHelper.showError(context, vm.errorMessage!);
            vm.clearErrorMessage();
          });
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text(AppStrings.homeTitle),
            actions: <Widget>[
              Consumer<ThemeViewModel>(
                builder: (context, themeViewModel, _) {
                  final isDark = Theme.of(context).brightness == Brightness.dark;

                  return IconButton(
                    icon: Icon(isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined),
                    tooltip: isDark ? AppStrings.lightMode : AppStrings.darkMode,
                    onPressed: () => themeViewModel.toggleTheme(isCurrentlyDark: isDark),
                  );
                },
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => NavigationService.pushNamed(RouteNames.addFlashcard),
            icon: const Icon(Icons.add),
            label: const Text(AppStrings.add),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: vm.isLoading
                  ? const LoadingWidget()
                  : !vm.hasCards
                      ? const EmptyStateWidget(
                          title: AppStrings.emptyTitle,
                          message: AppStrings.emptyMessage,
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            _CounterRow(current: vm.currentIndex + 1, total: vm.flashcards.length),
                            const SizedBox(height: AppSpacing.sm),
                            FlashcardWidget(
                              flashcard: card!,
                              showAnswer: vm.showAnswer,
                              onToggleAnswer: vm.toggleAnswerVisibility,
                            ),
                            const SizedBox(height: AppSpacing.sm),
                            _buildActionRow(context, vm, card),
                            const SizedBox(height: AppSpacing.sm),
                            _buildNavigationRow(vm),
                          ],
                        ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildActionRow(BuildContext context, FlashcardViewModel vm, FlashcardModel card) {
    return Row(
      children: <Widget>[
        Expanded(
          child: AppButton(
            label: AppStrings.edit,
            isSecondary: true,
            icon: Icons.edit,
            onPressed: () => NavigationService.pushNamed(RouteNames.editFlashcard, arguments: card),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: AppButton(
            label: AppStrings.delete,
            icon: Icons.delete,
            onPressed: () async {
              final confirm = await ConfirmationDialog.show(
                context: context,
                title: AppStrings.deleteFlashcardTitle,
                message: AppStrings.deleteFlashcardMessage,
              );
              if (!confirm) {
                return;
              }
              final success = await vm.deleteFlashcard(card.id!);
              if (!context.mounted) {
                return;
              }
              if (success) {
                SnackbarHelper.showSuccess(context, AppStrings.flashcardDeleted);
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildNavigationRow(FlashcardViewModel vm) {
    return Row(
      children: <Widget>[
        Expanded(
          child: AppButton(
            label: AppStrings.previous,
            isSecondary: true,
            icon: Icons.arrow_back,
            onPressed: vm.canGoPrevious ? vm.previousCard : null,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: AppButton(
            label: AppStrings.next,
            icon: Icons.arrow_forward,
            onPressed: vm.canGoNext ? vm.nextCard : null,
          ),
        ),
      ],
    );
  }
}

class _CounterRow extends StatelessWidget {
  const _CounterRow({required this.current, required this.total});

  final int current;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(AppStrings.cardCounter(current, total), style: Theme.of(context).textTheme.titleMedium),
      ],
    );
  }
}
