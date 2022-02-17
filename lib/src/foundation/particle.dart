import 'dart:math';

import '/src/foundation/object.dart';

/// Firework particle that is part of an explosion.
///
/// Inspired by https://codepen.io/whqet/pen/Auzch.
class FireworkParticle extends FireworkObjectWithTrail {
  FireworkParticle({
    required Random random,
    required Point<double> position,
    required double hueBaseValue,
    required double size,
    required bool isGravity,
  })  : angle = random.nextDouble() * 2 * pi,
        velocity = random.nextDouble() * 12 + 1,
        hue = hueBaseValue - 50 + random.nextDouble() * 100,
        brightness = .5 + random.nextDouble() * .3,
        alphaDecay = random.nextDouble() * .007 + .013,
        sourcePoint = position,
        gravity = isGravity ? 2.35 : 0,
        super(
          trailCount: size.toInt() * 2,
          position: position,
          random: random,
          size: size,
        );

  final double angle;

  double velocity;
  final double friction = .96;
  final double gravity;

  final double hue;
  final double brightness;
  final Point<double> sourcePoint;

  double alpha = 1;
  final double alphaDecay;

  @override
  void update() {
    super.update();

    velocity *= friction;

    position += Point(
      cos(angle) * velocity,
      sin(angle) * velocity + gravity,
    );

    alpha -= alphaDecay;
  }
}
