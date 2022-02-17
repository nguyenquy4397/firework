import 'dart:math';

import 'package:firework/firework.dart';
import 'package:flutter/material.dart';

class FireworksHaveRocket extends StatefulWidget {
  const FireworksHaveRocket({
    Key? key,
    required this.controller,
    required this.child,
    required this.fireworksNumber,
  }) : super(key: key);
  final FireworksHaveRocketController controller;
  final int fireworksNumber;
  final Widget child;
  @override
  _FireworksHaveRocketState createState() => _FireworksHaveRocketState();
}

class _FireworksHaveRocketState extends State<FireworksHaveRocket>
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
    if (widget.controller.state == FireworksHaveRocketControllerState.playing) {
      _spawn();
    } else if (widget.controller.state ==
        FireworksHaveRocketControllerState.stopped) {}
  }

  void _spawn() {
    for (int i = 0; i < widget.fireworksNumber; i++) {
      _controller.spawnRocket(
        Point(
          _random.nextDouble() * _controller.windowSize.width,
          _random.nextDouble() * _controller.windowSize.height,
        ),
        forceSpawn: true,
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
        Fireworks(controller: _controller),
        widget.child,
      ],
    );
  }
}

class FireworksHaveRocketController extends ChangeNotifier {
  FireworksHaveRocketControllerState _state =
      FireworksHaveRocketControllerState.stopped;
  FireworksHaveRocketControllerState get state => _state;
  void play() {
    _state = FireworksHaveRocketControllerState.playing;
    notifyListeners();
  }

  void stop() {
    _state = FireworksHaveRocketControllerState.stopped;
    notifyListeners();
  }
}

enum FireworksHaveRocketControllerState { playing, stopped }
