import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({required this.label, required this.onPressed, this.icon, this.isSecondary = false, super.key});

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isSecondary;

  @override
  Widget build(BuildContext context) {
    if (isSecondary) {
      return OutlinedButton.icon(onPressed: onPressed, icon: Icon(icon ?? Icons.chevron_left), label: Text(label));
    }

    return FilledButton.icon(onPressed: onPressed, icon: Icon(icon ?? Icons.check), label: Text(label));
  }
}
