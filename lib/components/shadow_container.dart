import 'package:flutter/material.dart';

class ShadowContainer extends StatelessWidget {
  final Radius radius;
  final EdgeInsetsGeometry? padding;
  final BoxConstraints? constraints;
  final Widget child;

  const ShadowContainer({
    super.key,
    required this.radius,
    this.padding,
    this.constraints,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: padding,
      constraints: constraints,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(radius),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow,
            blurRadius: 8,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: child,
    );
  }
}
