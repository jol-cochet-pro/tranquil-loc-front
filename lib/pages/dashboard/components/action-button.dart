import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final Color color;
  final Widget child;
  final void Function() onPressed;

  const ActionButton({
    super.key,
    required this.onPressed,
    required this.child,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(color),
        foregroundColor: WidgetStatePropertyAll(Colors.white),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        padding: WidgetStatePropertyAll(
          EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        ),
      ),
      child: child,
    );
  }
}
