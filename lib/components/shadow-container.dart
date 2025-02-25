import 'package:flutter/material.dart';

class ShadowContainer extends StatelessWidget {
  final Widget child;
  final Radius radius;
  final BoxConstraints? constraints;
  final EdgeInsetsGeometry? padding;

  const ShadowContainer({
    super.key,
    required this.child,
    required this.radius,
    this.constraints,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      constraints: constraints,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(radius),
        boxShadow: [
          BoxShadow(
            color: Color(0x40AEAEAE),
            blurRadius: 8,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: child,
    );
  }
}
