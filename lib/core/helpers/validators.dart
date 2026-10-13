import '../constants/app_constants.dart';
import '../constants/app_strings.dart';

class Validators {
  Validators._();

  static String? question(String? value) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) {
      return AppStrings.questionRequired;
    }
    if (v.length < AppConstants.minQuestionLength) {
      return AppStrings.questionMinLength(AppConstants.minQuestionLength);
    }
    return null;
  }

  static String? answer(String? value) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) {
      return AppStrings.answerRequired;
    }
    if (v.length < AppConstants.minAnswerLength) {
      return AppStrings.answerMinLength(AppConstants.minAnswerLength);
    }
    return null;
  }
}
