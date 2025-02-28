import 'package:flutter/material.dart';

class IconOkNoOk extends StatelessWidget {
  final double? size;
  final bool isOk;

  const IconOkNoOk({super.key, this.size, required this.isOk});

  @override
  Widget build(BuildContext context) {
    return isOk
        ? Icon(
          Icons.task_alt_outlined,
          size: size ?? 20,
          color: Color(0xFF0A9A00),
        )
        : Icon(
          Icons.cancel_outlined,
          size: size ?? 20,
          color: Color(0xFFDF1A1A),
        );
  }
}
