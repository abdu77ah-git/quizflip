import 'package:equatable/equatable.dart';

import '../../core/constants/app_constants.dart';
import '../../core/constants/app_strings.dart';

class FlashcardModel extends Equatable {
  const FlashcardModel({
    required this.id,
    required this.question,
    required this.answer,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final String question;
  final String answer;
  final DateTime createdAt;
  final DateTime updatedAt;

  FlashcardModel copyWith({int? id, String? question, String? answer, DateTime? createdAt, DateTime? updatedAt}) {
    return FlashcardModel(
      id: id ?? this.id,
      question: question ?? this.question,
      answer: answer ?? this.answer,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'question': question,
      'answer': answer,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory FlashcardModel.fromMap(Map<String, dynamic> map) {
    return FlashcardModel(
      id: map['id'] as int?,
      question: map['question'] as String? ?? '',
      answer: map['answer'] as String? ?? '',
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
    );
  }

  List<String> validate() {
    final errors = <String>[];
    if (question.trim().length < AppConstants.minQuestionLength) {
      errors.add(AppStrings.questionMinLength(AppConstants.minQuestionLength));
    }
    if (answer.trim().length < AppConstants.minAnswerLength) {
      errors.add(AppStrings.answerMinLength(AppConstants.minAnswerLength));
    }
    return errors;
  }

  bool get isValid => validate().isEmpty;

  @override
  List<Object?> get props => <Object?>[id, question, answer, createdAt, updatedAt];
}
