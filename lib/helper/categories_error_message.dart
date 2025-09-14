import 'package:flutter/material.dart';

class CategoriesErrorMessage extends StatelessWidget {
  const CategoriesErrorMessage({
    super.key, required this.errorMessage, 
  });
  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error,
            color: Theme.of(context).colorScheme.error,
            size: 24,
          ),
          const SizedBox(width: 8),
          Text(
            'Error: ${errorMessage.length > 50 ? {'${errorMessage.substring(0, 30)} ....'} : errorMessage}',
            style: TextStyle(
              color: Theme.of(context).colorScheme.error,
            ),
          ),
        ],
      ),
    );
  }
}
