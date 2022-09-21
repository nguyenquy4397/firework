import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../firework.dart';

class FireworksBackground extends StatelessWidget {
  const FireworksBackground({
    Key? key,
    required this.controller,
    required this.child,
    required this.fireworksNumber,
    this.size,
    this.hasRocket = true,
  }) : super(key: key);

  final FireworkBackgroundController controller;
  final int fireworksNumber;
  final Widget child;
  final Size? size;
  final bool hasRocket;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        hasRocket
            ? FireworksHaveRocket(
                controller: controller,
                fireworksNumber: fireworksNumber,
                size: size,
              )
            : FireworksNoRocket(
                controller: controller,
                fireworksNumber: fireworksNumber,
              ),
        child,
      ],
    );
  }
}
