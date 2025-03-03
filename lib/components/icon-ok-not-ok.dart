import 'package:flutter/material.dart';

class IconOkNoOk extends StatelessWidget {
  final double? size;
  final bool isOk;

  const IconOkNoOk({super.key, this.size, required this.isOk});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return isOk
        ? Icon(
          Icons.task_alt_outlined,
          size: size ?? 20,
          color: colorScheme.tertiary,
        )
        : Icon(
          Icons.cancel_outlined,
          size: size ?? 20,
          color: colorScheme.error,
        );
  }
}
