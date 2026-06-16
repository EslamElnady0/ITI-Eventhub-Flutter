import 'package:flutter/material.dart';

import '../../../../../core/assets/app_strings.dart';

Future<bool> showRemoveFavoriteConfirmationDialog(BuildContext context) async {
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text(AppStrings.removeFavoriteTitle),
        content: const Text(AppStrings.removeFavoriteMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text(AppStrings.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text(
              AppStrings.remove,
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      );
    },
  );
  return confirmed ?? false;
}
