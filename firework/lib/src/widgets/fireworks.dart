import 'package:flutter/widgets.dart';

import '/src/foundation/controller.dart';
import '/src/rendering/fireworks.dart';

class Fireworks extends LeafRenderObjectWidget {
  const Fireworks({
    Key? key,
    required this.controller,
  }) : super(key: key);

  /// The controller that manages the fireworks and tells the render box what
  /// and when to paint.
  final FireworkController controller;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderFireworks(
      controller: controller,
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderFireworks renderObject) {
    renderObject.controller = controller;
  }
}
