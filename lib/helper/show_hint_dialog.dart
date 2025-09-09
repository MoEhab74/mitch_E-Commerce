import 'package:flutter/material.dart';

void showHintDialog(
  BuildContext context, {
  required String title,
  required String content,
  required String buttonText,
  VoidCallback? onPressedAction,
}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            onPressedAction?.call();
            Navigator.of(context).pop();
          },
          child: Text(buttonText), 
        ),
      ],
    ),
  );
}
