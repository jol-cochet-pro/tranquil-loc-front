import 'package:dossier_locataire/components/navbar.dart';
import 'package:flutter/material.dart';

class PageLayout extends StatelessWidget {
  final Widget child;
  final bool? hideNavbar;

  const PageLayout({super.key, required this.child, this.hideNavbar});

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.bodyMedium!,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image(
            image: AssetImage('assets/background_desktop.png'),
            fit: BoxFit.fill,
          ),
          hideNavbar == null || !hideNavbar!
              ? Positioned(top: 12, left: 24, right: 24, child: Navbar())
              : SizedBox.shrink(),
          Padding(
            padding: EdgeInsets.only(left: 24, right: 24, top: 74, bottom: 24),
            child: child,
          ),
        ],
      ),
    );
  }
}
