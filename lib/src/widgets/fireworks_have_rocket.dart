import 'dart:math';

import 'package:firework/firework.dart';
import 'package:flutter/material.dart';

class FireworksHaveRocket extends StatefulWidget {
  const FireworksHaveRocket({
    Key? key,
    required this.controller,
    required this.fireworksNumber,
    this.size,
  }) : super(key: key);
  final FireworkBackgroundController controller;
  final int fireworksNumber;
  final Size? size;
  @override
  _FireworksHaveRocketState createState() => _FireworksHaveRocketState();
}

class _FireworksHaveRocketState extends State<FireworksHaveRocket>
    with SingleTickerProviderStateMixin {
  late final FireworkController _controller = FireworkController(
    vsync: this,
  )
    ..start()
    ..windowSize = widget.size ?? Size.zero
    ..autoLaunchDuration = Duration.zero
    ..rocketSpawnTimeout = Duration.zero;

  void _handleChange() {
    if (widget.controller.state == FireworkBackgroundState.playing) {
      _spawn();
    } else if (widget.controller.state == FireworkBackgroundState.stopped) {
      _controller.stop();
    }
  }

  void _spawn() {
    final _random = Random();
    for (int i = 0; i < widget.fireworksNumber; i++) {
      var x = _random.nextDouble() * _controller.windowSize.width;
      var y = _random.nextDouble() * _controller.windowSize.height;
      _controller.spawnRocket(
        Point(x, y),
        forceSpawn: true,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_handleChange);
    _controller.addListener(() {
      if (_controller.isStop.value) {}
    });
  }

  @override
  void dispose() {
    widget.controller.removeListener(_handleChange);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Fireworks(
      controller: _controller,
    );
  }
}

class FireworkBackgroundController extends ChangeNotifier {
  FireworkBackgroundState _state = FireworkBackgroundState.stopped;
  FireworkBackgroundState get state => _state;
  void play() {
    _state = FireworkBackgroundState.playing;
    notifyListeners();
  }

  void stop() {
    _state = FireworkBackgroundState.stopped;
    notifyListeners();
  }
}

enum FireworkBackgroundState { playing, stopped }
