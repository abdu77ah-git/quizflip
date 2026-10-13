import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_strings.dart';
import '../../core/helpers/validators.dart';
import '../../domain/models/flashcard_model.dart';
import '../viewmodels/flashcard_view_model.dart';
import '../widgets/app_button.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/loading_widget.dart';
import '../widgets/snackbar_helper.dart';

class AddEditFlashcardScreen extends StatefulWidget {
  const AddEditFlashcardScreen({this.card, super.key});

  final FlashcardModel? card;

  @override
  State<AddEditFlashcardScreen> createState() => _AddEditFlashcardScreenState();
}

class _AddEditFlashcardScreenState extends State<AddEditFlashcardScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _questionController;
  late final TextEditingController _answerController;

  bool get _isEdit => widget.card != null;

  @override
  void initState() {
    super.initState();
    _questionController = TextEditingController(text: widget.card?.question ?? '');
    _answerController = TextEditingController(text: widget.card?.answer ?? '');
  }

  @override
  void dispose() {
    _questionController.dispose();
    _answerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FlashcardViewModel>(
      builder: (context, vm, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text(_isEdit ? AppStrings.editFlashcardTitle : AppStrings.addFlashcardTitle),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    CustomTextField(
                      controller: _questionController,
                      label: AppStrings.questionFieldLabel,
                      hintText: AppStrings.questionHint,
                      maxLines: 3,
                      validator: Validators.question,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    CustomTextField(
                      controller: _answerController,
                      label: AppStrings.answerFieldLabel,
                      hintText: AppStrings.answerHint,
                      maxLines: 4,
                      validator: Validators.answer,
                    ),
                    const SizedBox(height: 20),
                    if (vm.isLoading) const LoadingWidget(),
                    if (!vm.isLoading)
                      SizedBox(
                        width: double.infinity,
                        child: AppButton(
                          label: _isEdit ? AppStrings.update : AppStrings.save,
                          icon: _isEdit ? Icons.save_as : Icons.save,
                          onPressed: () => _onSubmit(context, vm),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _onSubmit(BuildContext context, FlashcardViewModel vm) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final question = _questionController.text;
    final answer = _answerController.text;

    final success = _isEdit
        ? await vm.updateFlashcard(id: widget.card!.id!, question: question, answer: answer)
        : await vm.addFlashcard(question: question, answer: answer);

    if (!context.mounted) {
      return;
    }

    if (success) {
      SnackbarHelper.showSuccess(
        context,
        _isEdit ? AppStrings.flashcardUpdated : AppStrings.flashcardCreated,
      );
      Navigator.of(context).pop();
      return;
    }

    SnackbarHelper.showError(context, vm.errorMessage ?? AppStrings.couldNotSaveFlashcard);
  }
}
