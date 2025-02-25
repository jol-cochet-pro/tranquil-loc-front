import 'package:dossier_locataire/pages/dashboard/components/action-card.dart';
import 'package:dossier_locataire/pages/dashboard/components/dash-card.dart';
import 'package:dossier_locataire/pages/dashboard/components/dash-state-cell.dart';
import 'package:dossier_locataire/shared/text-styles.dart';
import 'package:flutter/material.dart';

class CandidatesCard extends StatelessWidget {
  const CandidatesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return DashCard(
      title: "Candidat",
      onAdd: () {
        print("add candidate.");
      },
      rows: [
        TableRow(
          children: [
            TableCell(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Jolan Cochet",
                    overflow: TextOverflow.ellipsis,
                    style: h3,
                  ),
                  Text(
                    "27/03/2003 - 21 ans",
                    overflow: TextOverflow.ellipsis,
                    style: p2,
                  ),
                ],
              ),
            ),
            TableCell(
              child: DashStateCell(
                first: StateStatus(
                  iconData: Icons.euro_outlined,
                  isCompleted: false,
                ),
                second: StateStatus(
                  iconData: Icons.person_outline,
                  isCompleted: true,
                ),
              ),
            ),
            TableCell(
              child: DashStateCell(
                first: StateStatus(
                  iconData: Icons.drafts_outlined,
                  isCompleted: false,
                ),
                second: StateStatus(
                  iconData: Icons.call_outlined,
                  isCompleted: true,
                ),
              ),
            ),
            TableCell(
              child: DashStateCell(
                first: StateStatus(
                  iconData: Icons.folder_outlined,
                  isCompleted: false,
                ),
              ),
            ),
            TableCell(
              child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.settings_outlined),
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
            ),
          ],
        ),
      ],
    );
  }
}

class WarrantorsCard extends StatelessWidget {
  const WarrantorsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return DashCard(
      title: "Garant",
      onAdd: () {
        print("add warrantor.");
      },
      rows: [
        TableRow(
          children: [
            TableCell(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Jolan Cochet",
                    overflow: TextOverflow.ellipsis,
                    style: h3,
                  ),
                  Text(
                    "27/03/2003 - 21 ans",
                    overflow: TextOverflow.ellipsis,
                    style: p2,
                  ),
                ],
              ),
            ),
            TableCell(
              child: DashStateCell(
                first: StateStatus(
                  iconData: Icons.euro_outlined,
                  isCompleted: false,
                ),
                second: StateStatus(
                  iconData: Icons.person_outline,
                  isCompleted: true,
                ),
              ),
            ),
            TableCell(
              child: DashStateCell(
                first: StateStatus(
                  iconData: Icons.drafts_outlined,
                  isCompleted: false,
                ),
                second: StateStatus(
                  iconData: Icons.call_outlined,
                  isCompleted: true,
                ),
              ),
            ),
            TableCell(
              child: DashStateCell(
                first: StateStatus(
                  iconData: Icons.folder_outlined,
                  isCompleted: false,
                ),
              ),
            ),
            TableCell(
              child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.settings_outlined),
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
            ),
          ],
        ),
      ],
    );
  }
}

class SharesCard extends StatelessWidget {
  const SharesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return DashCard(
      title: "Mes partages",
      onAdd: () {
        print("add shares.");
      },
      rows: [
        TableRow(
          children: [
            TableCell(
              child: Text(
                "Serge Cochet",
                overflow: TextOverflow.ellipsis,
                style: h3,
              ),
            ),
            TableCell(child: Text("1 jour", style: p2)),
            TableCell(child: Text("serge.cochet@gmail.com", style: p2)),
            TableCell(
              child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.settings_outlined),
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
            ),
          ],
        ),
      ],
    );
  }
}

class DashCards extends StatelessWidget {
  const DashCards({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: MediaQuery.of(context).size.width < 1008 ? 1 : 2,
      childAspectRatio: 3,
      mainAxisSpacing: 24,
      crossAxisSpacing: 24,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [CandidatesCard(), WarrantorsCard(), SharesCard()],
    );
  }
}
