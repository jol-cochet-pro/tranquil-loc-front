import 'package:dossier_locataire/pages/dashboard/hero-section.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeroSection(),
        Row(
          children: [
            Card(
              child: Column(
                children: [
                  Text("Pourcentage de mail ouverts"),
                  Row(children: [Icon(Icons.mail), Text("80%")]),
                ],
              ),
            ),
            Card(
              child: Row(
                children: [
                  TextButton(
                    onPressed: () {
                      print("share my profile");
                    },
                    child: Text("Partager mon dossier"),
                  ),
                  TextButton(
                    onPressed: () {
                      print("found appartment");
                    },
                    child: Text("J'ai trouvé un appartement !"),
                  ),
                ],
              ),
            ),
            Card(
              child: Column(
                children: [
                  Text("État recherche"),
                  Row(children: [Icon(Icons.check), Text("En recherche")]),
                ],
              ),
            ),
          ],
        ),
        // GridView.count(
        //   crossAxisCount: 2,
        //   shrinkWrap: true,
        //   children: [
        //     Card(
        //       child: Column(
        //         children: [
        //           Row(
        //             children: [
        //               Text("Candidat"),
        //               IconButton(
        //                 onPressed: () {
        //                   print("candidate +");
        //                 },
        //                 icon: Icon(Icons.add),
        //               ),
        //             ],
        //           ),
        //           Text("insert data here"),
        //         ],
        //       ),
        //     ),
        //     Card(
        //       child: Column(
        //         children: [
        //           Row(
        //             children: [
        //               Text("Garants"),
        //               IconButton(
        //                 onPressed: () {
        //                   print("warrantor +");
        //                 },
        //                 icon: Icon(Icons.add),
        //               ),
        //             ],
        //           ),
        //           Text("insert data here"),
        //         ],
        //       ),
        //     ),
        //     Card(
        //       child: Column(
        //         children: [
        //           Row(
        //             children: [
        //               Text("Mes partages"),
        //               IconButton(
        //                 onPressed: () {
        //                   print("share +");
        //                 },
        //                 icon: Icon(Icons.add),
        //               ),
        //             ],
        //           ),
        //           Text("insert data here"),
        //         ],
        //       ),
        //     ),
        //   ],
        // ),
      ],
    );
  }
}
