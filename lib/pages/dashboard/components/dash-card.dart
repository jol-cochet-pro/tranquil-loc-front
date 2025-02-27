import 'package:dossier_locataire/components/shadow-container.dart';
import 'package:dossier_locataire/shared/text-styles.dart';
import 'package:flutter/material.dart';

class DashCard extends StatelessWidget {
  final String title;
  final String emptyInfo;
  final void Function() onAdd;
  final List<dynamic> items;
  final Widget Function(BuildContext, int) itemBuilder;

  const DashCard({
    super.key,
    required this.title,
    required this.onAdd,
    required this.items,
    required this.itemBuilder,
    required this.emptyInfo,
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
              IconButton(
                onPressed: onAdd,
                icon: Icon(Icons.add),
                style: ButtonStyle(
                  side: WidgetStatePropertyAll(
                    BorderSide(color: Color(0xFFF1F5F9)),
                  ),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child:
                items.isNotEmpty
                    ? ListView.separated(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: items.length,
                      itemBuilder: itemBuilder,
                      separatorBuilder:
                          (context, index) => SizedBox(height: 12),
                    )
                    : Center(child: Text(emptyInfo, style: p1)),
          ),
        ],
      ),
    );
  }
}
