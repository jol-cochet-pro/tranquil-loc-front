import 'package:dossier_locataire/components/navbar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Dossier locataire', home: const MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          spacing: 8,
          children: [
            Navbar(),
            Column(
              children: [
                Card(
                  child: Row(
                    children: [
                      Row(
                        children: [
                          Column(
                            children: [
                              Text("Hey Jolan !"),
                              Text("Content de vous revoir !"),
                            ],
                          ),
                          Text("👋"),
                        ],
                      ),
                      Text("Vendredi, 6 Décembre 2024"),
                    ],
                  ),
                ),
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
                          Row(
                            children: [Icon(Icons.check), Text("En recherche")],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  children: [
                    Card(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text("Candidat"),
                              IconButton(
                                onPressed: () {
                                  print("candidate +");
                                },
                                icon: Icon(Icons.add),
                              ),
                            ],
                          ),
                          Text("insert data here"),
                        ],
                      ),
                    ),
                    Card(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text("Garants"),
                              IconButton(
                                onPressed: () {
                                  print("warrantor +");
                                },
                                icon: Icon(Icons.add),
                              ),
                            ],
                          ),
                          Text("insert data here"),
                        ],
                      ),
                    ),
                    Card(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text("Mes partages"),
                              IconButton(
                                onPressed: () {
                                  print("share +");
                                },
                                icon: Icon(Icons.add),
                              ),
                            ],
                          ),
                          Text("insert data here"),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
