import 'package:dossier_locataire/components/shadow-container.dart';
import 'package:flutter/material.dart';

class ActionCard extends StatelessWidget {
  final Widget child;
  final int flex;

  const ActionCard({super.key, required this.flex, required this.child});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: ShadowContainer(
        constraints: BoxConstraints.expand(),
        padding: EdgeInsets.all(12),
        radius: Radius.circular(10),
        child: child,
      ),
    );
  }
}
