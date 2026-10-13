import 'dart:math' show pi;

import 'package:flutter/material.dart';

import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_strings.dart';
import '../../domain/models/flashcard_model.dart';
import 'app_button.dart';

class FlashcardWidget extends StatelessWidget {
  const FlashcardWidget({
    required this.flashcard,
    required this.showAnswer,
    required this.onToggleAnswer,
    super.key,
  });

  final FlashcardModel flashcard;
  final bool showAnswer;
  final VoidCallback onToggleAnswer;

  @override
  Widget build(BuildContext context) {
    final targetAngle = showAnswer ? pi : 0.0;

    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: targetAngle),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      builder: (context, angle, child) {
        final isBack = angle >= pi / 2;

        return Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(angle),
          alignment: Alignment.center,
          child: isBack
              ? Transform(
                  transform: Matrix4.identity()..rotateY(pi),
                  alignment: Alignment.center,
                  child: _buildBack(context),
                )
              : _buildFront(context),
        );
      },
    );
  }

  Widget _buildFront(BuildContext context) {
    return Card(
      key: const ValueKey('front'),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSpacing.md)),
      child: Container(
        constraints: const BoxConstraints(minHeight: 250),
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  AppStrings.questionLabel,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  flashcard.question,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            AppButton(
              label: AppStrings.showAnswer,
              onPressed: onToggleAnswer,
              icon: Icons.visibility,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBack(BuildContext context) {
    return Card(
      key: const ValueKey('back'),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSpacing.md)),
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: Container(
        constraints: const BoxConstraints(minHeight: 250),
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  AppStrings.answerLabel,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  flashcard.answer,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 18,
                        height: 1.5,
                      ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            AppButton(
              label: AppStrings.hideAnswer,
              onPressed: onToggleAnswer,
              icon: Icons.visibility_off,
              isSecondary: true,
            ),
          ],
        ),
      ),
    );
  }
}
