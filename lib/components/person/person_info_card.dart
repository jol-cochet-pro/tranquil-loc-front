import 'package:tranquil_loc/components/shadow_container.dart';
import 'package:tranquil_loc/shared/text_styles.dart';
import 'package:flutter/material.dart';

class PersonInfo {
  final IconData icon;
  final String name;
  final String info;

  const PersonInfo({
    required this.icon,
    required this.name,
    required this.info,
  });
}

class PersonInfoCard extends StatelessWidget {
  final String title;
  final PersonInfo first;
  final PersonInfo second;
  final bool isSmall;
  final int flex;

  const PersonInfoCard({
    super.key,
    required this.first,
    required this.second,
    required this.title,
    this.isSmall = false,
    this.flex = 1,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final content = Column(
      spacing: 4,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (!isSmall) Text("$title:", style: h4),
        Expanded(
          child: ShadowContainer(
            padding: EdgeInsets.all(10),
            child: Row(
              spacing: 12,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(first.name, style: p3),
                          Icon(first.icon, size: 20),
                        ],
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            first.info,
                            overflow: TextOverflow.ellipsis,
                            style: p2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                VerticalDivider(color: colorScheme.outline),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(second.name, style: p3),
                          Icon(second.icon, size: 20),
                        ],
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            second.info,
                            overflow: TextOverflow.ellipsis,
                            style: p2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
    return flex != 0 ? Expanded(child: content) : content;
  }
}
