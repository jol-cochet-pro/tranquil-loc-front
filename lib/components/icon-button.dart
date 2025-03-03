import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final void Function() onPressed;
  final IconData icon;

  const CustomIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon),
      style: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(Colors.black),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
      ),
    );
  }
}
