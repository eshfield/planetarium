import 'package:flutter/material.dart';

import '../graphics_engine.dart';

class SolarSystemPainter extends CustomPainter {
  final GraphicsEngine graphicsEngine;
  final ValueNotifier timeNotifier;

  SolarSystemPainter({
    required this.graphicsEngine,
    required this.timeNotifier,
  }) : super(repaint: timeNotifier);

  @override
  void paint(Canvas canvas, Size size) {
    graphicsEngine.updatePaintParameters(canvas, size);

    graphicsEngine.clipVisibleArea();

    graphicsEngine.drawPlanetOrbits();
    graphicsEngine.drawPlanets(timestamp: timeNotifier.value);

    graphicsEngine.drawSun();
    graphicsEngine.drawScaleFactors();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
