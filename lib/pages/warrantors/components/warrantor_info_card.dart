import 'package:tranquil_loc/components/shadow_container.dart';
import 'package:tranquil_loc/shared/text_styles.dart';
import 'package:flutter/material.dart';

class WarrantorInfo {
  final IconData icon;
  final String name;
  final String info;

  const WarrantorInfo({
    required this.icon,
    required this.name,
    required this.info,
  });
}

class WarrantorInfoCard extends StatelessWidget {
  final String title;
  final WarrantorInfo first;
  final WarrantorInfo second;

  const WarrantorInfoCard({
    super.key,
    required this.first,
    required this.second,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Expanded(
      child: Column(
        spacing: 4,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("$title:", style: h4),
          Expanded(
            child: ShadowContainer(
              padding: EdgeInsets.all(10),
              radius: Radius.circular(10),
              child: Row(
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
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: VerticalDivider(
                      width: 1,
                      color: colorScheme.outline,
                    ),
                  ),
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
      ),
    );
  }
}
