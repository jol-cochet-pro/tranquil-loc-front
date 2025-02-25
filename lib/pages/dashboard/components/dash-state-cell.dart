import 'package:flutter/material.dart';

class StateStatus {
  final IconData iconData;
  final bool isCompleted;

  StateStatus({required this.iconData, required this.isCompleted});
}

class DashStateCell extends StatelessWidget {
  final StateStatus first;
  final StateStatus? second;

  const DashStateCell({super.key, required this.first, this.second});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 4,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          spacing: 4,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(first.iconData, size: 20),
            first.isCompleted
                ? Icon(
                  Icons.task_alt_outlined,
                  size: 20,
                  color: Color(0xFF0A9A00),
                )
                : Icon(
                  Icons.cancel_outlined,
                  size: 20,
                  color: Color(0xFFDF1A1A),
                ),
          ],
        ),
        second != null
            ? Row(
              spacing: 4,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(second!.iconData, size: 20),
                second!.isCompleted
                    ? Icon(
                      Icons.task_alt_outlined,
                      size: 20,
                      color: Color(0xFF0A9A00),
                    )
                    : Icon(
                      Icons.cancel_outlined,
                      size: 20,
                      color: Color(0xFFDF1A1A),
                    ),
              ],
            )
            : SizedBox.shrink(),
      ],
    );
  }
}
