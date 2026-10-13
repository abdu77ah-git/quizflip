import 'app_constants.dart';

class AppStrings {
  AppStrings._();

  // App
  static const String homeTitle = 'QuizFlip Flashcards';

  // Flashcard labels
  static const String questionLabel = 'QUESTION';
  static const String answerLabel = 'ANSWER';
  static const String showAnswer = 'Show Answer';
  static const String hideAnswer = 'Hide Answer';

  // Actions
  static const String add = 'Add';
  static const String edit = 'Edit';
  static const String delete = 'Delete';
  static const String previous = 'Previous';
  static const String next = 'Next';
  static const String darkMode = 'Dark mode';
  static const String lightMode = 'Light mode';
  static const String save = 'Save';
  static const String update = 'Update';
  static const String cancel = 'Cancel';
  static const String confirm = 'Confirm';

  // Screens
  static const String addFlashcardTitle = 'Add Flashcard';
  static const String editFlashcardTitle = 'Edit Flashcard';
  static const String questionFieldLabel = 'Question';
  static const String answerFieldLabel = 'Answer';
  static const String questionHint = 'Enter your question';
  static const String answerHint = 'Enter the answer';

  // Empty state
  static const String emptyTitle = 'No Flashcards Yet';
  static const String emptyMessage = 'Tap Add to create your first study card.';

  // Dialogs
  static const String deleteFlashcardTitle = 'Delete Flashcard';
  static const String deleteFlashcardMessage = 'Are you sure you want to remove this card?';

  // Snackbars
  static const String flashcardDeleted = 'Flashcard deleted.';
  static const String flashcardCreated = 'Flashcard created.';
  static const String flashcardUpdated = 'Flashcard updated.';
  static const String couldNotSaveFlashcard = 'Could not save flashcard.';

  // Navigation
  static const String routeNotFound = 'Route not found';

  static String cardCounter(int current, int total) => 'Card $current of $total';

  // Validation
  static const String questionRequired = 'Question is required.';
  static const String answerRequired = 'Answer is required.';

  static String questionMinLength(int min) => 'Question must be at least $min characters.';
  static String answerMinLength(int min) => 'Answer must be at least $min character.';

  // Errors
  static const String genericError = 'Something went wrong. Please try again.';
  static const String flashcardNotFound = 'Flashcard not found.';
  static const String failedToLoadFlashcards = 'Failed to load flashcards.';
  static const String failedToAddFlashcard = 'Failed to add flashcard.';
  static const String failedToUpdateFlashcard = 'Failed to update flashcard.';
  static const String failedToDeleteFlashcard = 'Failed to delete flashcard.';
  static const String cannotUpdateWithoutId = 'Cannot update flashcard without an id.';

  // Logger context
  static String get logTag => AppConstants.appName;

  // Log messages
  static const String logLoadFlashcardsFailed = 'loadFlashcards failed';
  static const String logAddFlashcardFailed = 'addFlashcard failed';
  static const String logUpdateFlashcardFailed = 'updateFlashcard failed';
  static const String logDeleteFlashcardFailed = 'deleteFlashcard failed';
}
