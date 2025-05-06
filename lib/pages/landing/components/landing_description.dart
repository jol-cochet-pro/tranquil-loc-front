import 'package:dossier_locataire/components/shadow_container.dart';
import 'package:dossier_locataire/shared/text_styles.dart';
import 'package:flutter/material.dart';

class LandingDescription extends StatelessWidget {
  final String text;
  const LandingDescription({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return ShadowContainer(
      shape: BoxShape.circle,
      constraints: BoxConstraints(minHeight: 200, minWidth: 200),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(text, style: p2, textAlign: TextAlign.center),
          Icon(Icons.task_alt_outlined, size: 40, color: colorScheme.tertiary),
        ],
      ),
    );
  }
}
