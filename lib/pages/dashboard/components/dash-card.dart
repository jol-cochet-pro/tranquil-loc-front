import 'package:dossier_locataire/components/shadow-container.dart';
import 'package:dossier_locataire/shared/text-styles.dart';
import 'package:flutter/material.dart';

class DashCard extends StatelessWidget {
  final String title;
  final void Function() onAdd;
  final List<TableRow> rows;

  const DashCard({
    super.key,
    required this.title,
    required this.onAdd,
    required this.rows,
  });

  @override
  Widget build(BuildContext context) {
    return ShadowContainer(
      padding: EdgeInsets.all(10),
      radius: Radius.circular(10),
      child: Column(
        spacing: 8,
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
          ShadowContainer(
            radius: Radius.circular(10),
            padding: EdgeInsets.all(10),
            child: SingleChildScrollView(
              clipBehavior: Clip.hardEdge,
              child: Table(children: rows),
            ),
          ),
        ],
      ),
    );
  }
}
