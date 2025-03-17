import 'package:flutter/material.dart';

enum IconState { valid, pause, wrong }

class IconWithState extends StatelessWidget {
  final double? size;
  final IconState state;

  const IconWithState({super.key, this.size, required this.state});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    switch (state) {
      case IconState.valid:
        return Icon(
          Icons.task_alt_outlined,
          size: size ?? 20,
          color: colorScheme.tertiary,
        );
      case IconState.wrong:
        return Icon(
          Icons.cancel_outlined,
          size: size ?? 20,
          color: colorScheme.error,
        );
      case IconState.pause:
        return Icon(
          Icons.cancel_outlined,
          size: size ?? 20,
          color: colorScheme.error,
        );
    }
  }
}
