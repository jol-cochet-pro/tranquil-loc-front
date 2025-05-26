import 'package:tranquil_loc/components/icon_button.dart';
import 'package:tranquil_loc/components/loader.dart';
import 'package:tranquil_loc/components/shadow_container.dart';
import 'package:tranquil_loc/shared/text_styles.dart';
import 'package:flutter/material.dart';

class DashCard extends StatelessWidget {
  final String title;
  final String emptyInfo;
  final void Function() onAdd;
  final List<dynamic>? items;
  final Widget Function(BuildContext, int) itemBuilder;
  final bool hasData;

  const DashCard({
    super.key,
    required this.title,
    required this.onAdd,
    required this.items,
    required this.itemBuilder,
    required this.emptyInfo,
    required this.hasData,
  });

  @override
  Widget build(BuildContext context) {
    return ShadowContainer(
      padding: EdgeInsets.all(10),
      radius: Radius.circular(10),
      child: Column(
        spacing: 16,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: h3),
              CustomIconButton(onPressed: onAdd, icon: Icons.add),
            ],
          ),
          Expanded(
            child:
                hasData
                    ? items != null && items!.isNotEmpty
                        ? ListView.separated(
                          shrinkWrap: true,
                          primary: false,
                          itemCount: items!.length,
                          itemBuilder: itemBuilder,
                          separatorBuilder:
                              (context, index) => SizedBox(height: 12),
                        )
                        : Center(child: Text(emptyInfo, style: p2))
                    : Loader(),
          ),
        ],
      ),
    );
  }
}
