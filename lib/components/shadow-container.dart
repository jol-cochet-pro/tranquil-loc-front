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
        border: Border.all(color: Color(0xFFE5E7EB)),
      ),
      child: child,
    );
  }
}
