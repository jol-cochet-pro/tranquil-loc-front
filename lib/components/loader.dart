import 'dart:async';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Loader extends StatefulWidget {
  const Loader({super.key});

  @override
  State<Loader> createState() => _LoaderState();
}

class _LoaderState extends State<Loader> {
  bool showLoader = false;
  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    Timer(Duration(seconds: 1), () => setState(() => showLoader = true));
    return showLoader
        ? Center(
          child: LoadingAnimationWidget.waveDots(
            color: colorScheme.outline,
            size: 40,
          ),
        )
        : SizedBox.shrink();
  }
}
