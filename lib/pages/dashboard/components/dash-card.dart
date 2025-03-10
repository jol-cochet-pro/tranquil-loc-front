import 'package:dossier_locataire/components/icon-button.dart';
import 'package:dossier_locataire/components/loader.dart';
import 'package:dossier_locataire/components/shadow-container.dart';
import 'package:dossier_locataire/shared/text-styles.dart';
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
              Text(title, style: h2),
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
                        : Center(child: Text(emptyInfo, style: p1))
                    : Loader(),
          ),
        ],
      ),
    );
  }
}
