import 'dart:math';

import 'package:firework/firework.dart';
import 'package:flutter/material.dart';

class FireworksNoRocket extends StatefulWidget {
  const FireworksNoRocket({
    Key? key,
    required this.controller,
    required this.child,
    this.isBackground = true,
    required this.fireworksNumber,
  }) : super(key: key);
  final FireworksNoRocketController controller;
  final int fireworksNumber;
  final Widget child;
  final bool isBackground;
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
    if (widget.controller.state == FireworksNoRocketControllerState.playing) {
      _spawn();
    } else if (widget.controller.state ==
        FireworksNoRocketControllerState.stopped) {}
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
    return Stack(
      children: [
        if (!widget.isBackground) widget.child,
        Fireworks(controller: _controller),
        if (widget.isBackground) widget.child,
      ],
    );
  }
}

class FireworksNoRocketController extends ChangeNotifier {
  FireworksNoRocketControllerState _state =
      FireworksNoRocketControllerState.stopped;
  FireworksNoRocketControllerState get state => _state;

  void play() {
    _state = FireworksNoRocketControllerState.playing;
    notifyListeners();
  }

  void stop() {
    _state = FireworksNoRocketControllerState.stopped;
    notifyListeners();
  }
}

enum FireworksNoRocketControllerState { playing, stopped }
