import 'package:dossier_locataire/components/navbar.dart';
import 'package:dossier_locataire/pages/occupants/occupants.dart';
import 'package:dossier_locataire/pages/warrantors/warrantors.dart';
import 'package:flutter/material.dart';

class GoRouterObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    String path = "/${route.settings.name!.split('/')[1]}";
    switch (path) {
      case Warrantors.route:
        Navbar.selected = 2;
      case Occupants.route:
        Navbar.selected = 1;
      default:
        Navbar.selected = 0;
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {}

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {}

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {}
}
