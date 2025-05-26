import 'package:tranquil_loc/components/icon_with_state.dart';
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
            IconWithState(
              state: first.isCompleted ? IconState.valid : IconState.wrong,
            ),
          ],
        ),
        second != null
            ? Row(
              spacing: 4,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(second!.iconData, size: 20),
                IconWithState(
                  state:
                      second!.isCompleted ? IconState.valid : IconState.wrong,
                ),
              ],
            )
            : SizedBox.shrink(),
      ],
    );
  }
}
