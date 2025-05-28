import 'package:tranquil_loc/components/navbar.dart';
import 'package:flutter/material.dart';

class PageLayout extends StatelessWidget {
  final Widget child;
  final bool? hideNavbar;
  final bool? isScrollable;

  const PageLayout({
    super.key,
    required this.child,
    this.hideNavbar,
    this.isScrollable,
  });

  @override
  Widget build(BuildContext context) {
    final bool isVisiblenav = hideNavbar == null || !hideNavbar!;
    return Material(
      child: DefaultTextStyle(
        style: Theme.of(context).textTheme.bodyMedium!,
        child: Stack(
          fit: isVisiblenav ? StackFit.expand : StackFit.passthrough,
          children: [
            Image(
              image: AssetImage('assets/background_desktop.png'),
              fit: BoxFit.fill,
            ),
            isVisiblenav
                ? Positioned(top: 12, left: 24, right: 24, child: Navbar())
                : SizedBox.shrink(),
            Padding(
              padding: EdgeInsets.only(
                left: 24,
                right: 24,
                top: isVisiblenav ? 74 : 24,
                bottom: 24,
              ),
              child:
                  isScrollable != null && isScrollable!
                      ? SingleChildScrollView(child: child)
                      : child,
            ),
          ],
        ),
      ),
    );
  }
}
