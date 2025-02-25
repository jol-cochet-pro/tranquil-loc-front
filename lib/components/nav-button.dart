import 'package:flutter/material.dart';

class NavButton extends StatelessWidget {
  final bool isSelected;
  final Widget child;
  final void Function() onPressed;

  const NavButton({
    super.key,
    required this.onPressed,
    required this.child,
    required this.isSelected,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: EdgeInsets.all(10),
        backgroundColor:
            (isSelected) ? Theme.of(context).colorScheme.primary : Colors.white,
        foregroundColor:
            (isSelected) ? Colors.white : Color.fromARGB(255, 1, 15, 29),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(100)),
        ),
        splashFactory: NoSplash.splashFactory,
        fixedSize: Size(110, 44),
      ),
      child: child,
    );
  }
}
