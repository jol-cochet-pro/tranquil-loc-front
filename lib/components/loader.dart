import 'dart:async';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Loader extends StatefulWidget {
  final bool showImediately;

  const Loader({super.key, this.showImediately = false});

  @override
  State<Loader> createState() => _LoaderState();
}

class _LoaderState extends State<Loader> {
  bool showLoader = false;
  late Timer timer;

  @override
  void initState() {
    timer = Timer(
      Duration(seconds: 1),
      () => setState(() => showLoader = true),
    );

    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return widget.showImediately || showLoader
        ? Center(
          child: LoadingAnimationWidget.waveDots(
            color: colorScheme.outline,
            size: 40,
          ),
        )
        : SizedBox.shrink();
  }
}
