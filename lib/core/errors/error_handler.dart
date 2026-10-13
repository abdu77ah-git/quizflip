import '../constants/app_strings.dart';
import 'app_exception.dart';

class ErrorHandler {
  ErrorHandler._();

  static String mapToMessage(Object error) {
    if (error is AppException) {
      return error.message;
    }

    return AppStrings.genericError;
  }
}
