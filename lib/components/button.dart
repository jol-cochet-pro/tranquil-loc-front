import 'package:flutter/material.dart';

enum ButtonType { primary, secondary, success }

class CustomButton extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final void Function() onPressed;
  final ButtonType type;

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.padding,
    required this.child,
    required this.type,
  });

  Color getForegroundColor(ColorScheme colorScheme) {
    switch (type) {
      case ButtonType.primary:
        return colorScheme.onPrimary;
      case ButtonType.secondary:
        return colorScheme.onSecondary;
      case ButtonType.success:
        return Colors.white;
    }
  }

  Color getBackgroundColor(ColorScheme colorScheme) {
    switch (type) {
      case ButtonType.primary:
        return colorScheme.primary;
      case ButtonType.secondary:
        return colorScheme.secondary;
      case ButtonType.success:
        return colorScheme.tertiary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(
          getBackgroundColor(colorScheme),
        ),
        foregroundColor: WidgetStatePropertyAll(
          getForegroundColor(colorScheme),
        ),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            side: BorderSide(
              color:
                  type == ButtonType.secondary
                      ? colorScheme.onSecondary
                      : Colors.transparent,
            ),
          ),
        ),
        padding: WidgetStatePropertyAll(padding),
      ),
      child: child,
    );
  }
}
