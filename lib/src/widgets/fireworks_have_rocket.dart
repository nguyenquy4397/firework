import 'dart:math';

import 'package:firework/firework.dart';
import 'package:flutter/material.dart';

class FireworksHaveRocket extends StatefulWidget {
  const FireworksHaveRocket({
    Key? key,
    required this.controller,
    required this.child,
    required this.fireworksNumber,
    this.size,
  }) : super(key: key);
  final FireworksHaveRocketController controller;
  final int fireworksNumber;
  final Widget child;
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
    if (widget.controller.state == FireworksHaveRocketControllerState.playing) {
      setState(() {
        _isVisible = true;
      });
      _spawn();
    } else if (widget.controller.state ==
        FireworksHaveRocketControllerState.stopped) {
      setState(() {
        _isVisible = false;
      });
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
  }

  @override
  void dispose() {
    widget.controller.removeListener(_handleChange);
    _controller.dispose();
    super.dispose();
  }

  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        ValueListenableBuilder<bool>(
          valueListenable: _controller.isStop,
          builder: (context, value, _) => Visibility(
            child: Fireworks(controller: _controller),
            visible: _isVisible && !value,
          ),
        ),
        ValueListenableBuilder<bool>(
          valueListenable: _controller.isStop,
          builder: (context, value, _) => Visibility(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isVisible = false;
                });
              },
            ),
            visible: _isVisible && !value,
          ),
        ),
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
