import 'package:tranquil_loc/pages/dashboard/occupant_dash_card.dart';
import 'package:tranquil_loc/pages/dashboard/shares_dash_card.dart';
import 'package:tranquil_loc/pages/dashboard/warrantor_dash_card.dart';
import 'package:flutter/material.dart';

class DashCards extends StatelessWidget {
  const DashCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        spacing: 24,
        children:
            MediaQuery.of(context).size.width >= 1008
                ? [
                  Expanded(
                    child: Column(
                      spacing: 24,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(child: OccupantsCard()),
                        Expanded(child: WarrantorsCard()),
                      ],
                    ),
                  ),
                  Expanded(child: SharesCard()),
                ]
                : [Expanded(child: SharesCard())],
      ),
    );
  }
}
