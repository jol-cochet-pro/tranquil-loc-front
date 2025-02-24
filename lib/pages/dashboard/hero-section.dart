import 'package:dossier_locataire/shared/text-styles.dart';
import 'package:flutter/material.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x40AEAEAE),
            blurRadius: 8,
            offset: Offset(0, 8),
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            spacing: 4,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Hey Jolan !", style: h1),
                  Text("Content de vous revoir !", style: p1),
                ],
              ),
              Text("👋", style: h1),
            ],
          ),
          Text("Vendredi, 6 Décembre 2024", style: p1),
        ],
      ),
    );
  }
}
