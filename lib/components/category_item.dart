import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    super.key,
    required this.title,
    this.color,
    this.onTap,
    required this.titleColor,
  });
  final String title;
  final Color titleColor;
  final Color? color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 4, end: 4),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(8.0),
          height: 40,
          width: 80,
          decoration: BoxDecoration(
            color: color ?? Theme.of(context).colorScheme.primary,
            border: Border.all(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: titleColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}