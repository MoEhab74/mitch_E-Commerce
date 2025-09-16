import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({super.key, required this.title, required this.snackBarMessage, this.onPressed});
  final String title;
  final String snackBarMessage;
  final  void Function()? onPressed;
  

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: 100,
        height: 55,
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(
                color: Theme.of(context).colorScheme.primary,
                width: 2,
              ),
            ),
            backgroundColor: Theme.of(context).colorScheme.surface,
            elevation: 4,
          ),
          label: Text(
            title,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
