import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  const MyTextFormField({
    super.key,
    required this.labelText,
    this.icon,
    this.obscureText,
    this.validator,
    this.controller, this.onPressed,
    this.prefixIcon,
  });
  final String labelText;
  final IconData? icon;
  final bool? obscureText;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final void Function()? onPressed;
  final Widget? prefixIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: TextFormField(
        obscureText: obscureText ?? false,
        controller: controller,
        validator: validator,
        decoration: InputDecoration(
          filled: true,
          fillColor: Theme.of(context).colorScheme.surface,
          border: OutlineInputBorder(),
          hintText: labelText,
          hintStyle: TextStyle(color: Theme.of(context).colorScheme.secondary,fontSize: 16),
          prefixIcon: IconButton(onPressed: onPressed, icon: Icon(icon)),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 1.5),
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 1.5),
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.error,
              width: 1.5,
            ),
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
        ),
      ),
    );
  }
}
