import 'package:flutter/material.dart';

class ShadowContainer extends StatelessWidget {
  final Radius? radius;
  final EdgeInsetsGeometry? padding;
  final BoxConstraints? constraints;
  final BoxShape? shape;
  final Widget child;

  const ShadowContainer({
    super.key,
    this.radius,
    this.padding,
    this.constraints,
    this.shape,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: padding,
      constraints: constraints,
      decoration: BoxDecoration(
        shape: shape ?? BoxShape.rectangle,
        color: Colors.white,
        borderRadius:
            shape != BoxShape.circle
                ? BorderRadius.all(radius ?? Radius.circular(8))
                : null,
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
