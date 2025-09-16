import 'package:flutter/material.dart';

showSnackBar(BuildContext context, { required String message}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Theme.of(context).colorScheme.onSurface,
      duration: const Duration(seconds: 1),
    ),
  );
}
