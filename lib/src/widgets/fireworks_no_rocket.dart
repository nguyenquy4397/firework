import 'dart:math';

import 'package:firework/firework.dart';
import 'package:flutter/material.dart';

class FireworksNoRocket extends StatefulWidget {
  const FireworksNoRocket({
    Key? key,
    required this.controller,
    required this.fireworksNumber,
  }) : super(key: key);
  final FireworkBackgroundController controller;
  final int fireworksNumber;
  @override
  _FireworksNoRocketState createState() => _FireworksNoRocketState();
}

class _FireworksNoRocketState extends State<FireworksNoRocket>
    with SingleTickerProviderStateMixin {
  late final FireworkController _controller = FireworkController(
    vsync: this,
    radius: 70,
  )
    ..start()
    ..autoLaunchDuration = Duration.zero
    ..rocketSpawnTimeout = Duration.zero;
  final _random = Random();

  void _handleChange() {
    if (widget.controller.state == FireworkBackgroundState.playing) {
      _spawn();
    } else if (widget.controller.state == FireworkBackgroundState.stopped) {}
  }

  void _spawn() {
    for (int i = 0; i < widget.fireworksNumber; i++) {
      _controller.spawnExplosion(
        Point(
          _random.nextDouble() * _controller.windowSize.width,
          _random.nextDouble() * _controller.windowSize.height,
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_handleChange);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_handleChange);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Fireworks(controller: _controller);
  }
}
