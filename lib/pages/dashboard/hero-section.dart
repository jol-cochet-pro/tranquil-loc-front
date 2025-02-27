import 'package:dossier_locataire/components/shadow-container.dart';
import 'package:dossier_locataire/shared/text-styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('EEEE, dd MMMM yyyy', "fr_FR");
    final String date = formatter.format(DateTime.now());
    return ShadowContainer(
      radius: Radius.circular(10),
      padding: EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            spacing: 4,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Hey Jolan !", style: h1),
                  Text("Content de vous revoir !", style: p1),
                ],
              ),
              Text("👋", style: h1),
            ],
          ),
          Text(date.replaceFirst(date[0], date[0].toUpperCase()), style: p1),
        ],
      ),
    );
  }
}
