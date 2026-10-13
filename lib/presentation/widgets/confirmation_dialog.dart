import 'package:flutter/material.dart';

import '../../core/constants/app_strings.dart';

class ConfirmationDialog {
  ConfirmationDialog._();

  static Future<bool> show({required BuildContext context, required String title, required String message}) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text(AppStrings.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text(AppStrings.confirm),
          ),
        ],
      ),
    );

    return result ?? false;
  }
}
