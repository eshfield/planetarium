import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../domain/models/planet.dart';

const sunLabel = 'Sun';
const sunColor = Colors.amber;
const sunDisplayRadius = 10.0; // pixels

const factorLabelLeftPadding = 84.0;
const factorLabelBottomPadding = 16.0;
const factorDecimals = 8;
const factorLabelWidth = 36;
const notApplicable = 'N/A';

const orbitDisplayStrokeWidth = 1.0;
const orbitDisplayGap = 100.0;

const scaleLargestPlanetTo = 40; // radius, pixels
const scaleFastestSpeedTo = 5.0; // period of one full turn, seconds

class GraphicsEngine {
  List<Planet> planets = [];
  late Canvas canvas;
  Size? size;
  late double? distancesToSunScaleFactor;
  late double? planetsRadiusScaleFactor;
  late double? planetsOrbitalSpeedScaleFactor;

  GraphicsEngine();

  void updatePlanets(List<Planet> planets) {
    this.planets = planets;
    _calculateScaleFactors();
  }

  void updatePaintParameters(Canvas canvas, Size size) {
    this.canvas = canvas;
    if (size != this.size) {
      this.size = size;
      _calculateScaleFactors();
    }
  }

  void _calculateScaleFactors() {
    distancesToSunScaleFactor = _calculateOrbitScaleFactor();
    planetsRadiusScaleFactor = _calculatePlanetRadiusScaleFactor();
    planetsOrbitalSpeedScaleFactor = _calculateSpeedScaleFactor();
  }

  double? _calculateOrbitScaleFactor() {
    // fitting the largest planet orbit to the screen size
    if (planets.isEmpty) return null;
    final maxDistanceToSun =
        planets.map((planet) => planet.distanceToSun).reduce(max);
    return (size!.shortestSide - orbitDisplayGap) / (maxDistanceToSun * 2);
  }

  double? _calculatePlanetRadiusScaleFactor() {
    // adjusting planets display size due
    // the huge difference between orbits and planet radii values
    if (planets.isEmpty) return null;
    final maxPlanetRadius = planets.map((planet) => planet.radius).reduce(max);
    return scaleLargestPlanetTo / maxPlanetRadius;
  }

  double? _calculateSpeedScaleFactor() {
    // making the fastest planet with shortest distance to the Sun (if any)
    // to rotate with an easy to watch period
    if (planets.isEmpty) return null;
    final maxPlanetOrbitalSpeed =
        planets.map((planet) => planet.orbitalSpeed).reduce(max);
    final fastPlanets =
        planets.where((planet) => planet.orbitalSpeed == maxPlanetOrbitalSpeed);
    final minFastPlanetsDistanceToSun =
        fastPlanets.map((planet) => planet.distanceToSun).reduce(min);
    final desiredOrbitalSpeed = 2 *
        pi *
        minFastPlanetsDistanceToSun *
        distancesToSunScaleFactor! /
        scaleFastestSpeedTo;
    return desiredOrbitalSpeed / maxPlanetOrbitalSpeed;
  }

  Offset get _center => Offset(size!.width / 2, size!.height / 2);

  void clipVisibleArea() {
    final visibleArea = Rect.fromCenter(
      center: _center,
      width: size!.width,
      height: size!.height,
    );
    canvas.clipRect(visibleArea);
  }

  void drawPlanetOrbits() {
    for (final planet in planets) {
      final displayDistanceToSun =
          planet.distanceToSun * distancesToSunScaleFactor!;
      final paint = Paint()
        ..color = planet.color
        ..style = PaintingStyle.stroke
        ..strokeWidth = orbitDisplayStrokeWidth;
      canvas.drawCircle(_center, displayDistanceToSun, paint);
    }
  }

  void drawPlanets({required int timestamp}) {
    for (final planet in planets) {
      final displayDistanceToSun =
          planet.distanceToSun * distancesToSunScaleFactor!;
      final angle = planet.orbitalSpeed *
              planetsOrbitalSpeedScaleFactor! *
              timestamp /
              1000 /
              displayDistanceToSun -
          pi / 2;
      final x = displayDistanceToSun * cos(angle);
      final y = displayDistanceToSun * sin(angle);
      final planetCenter = Offset(size!.width / 2 + x, size!.height / 2 + y);

      final displayPlanetRadius = planet.radius * planetsRadiusScaleFactor!;
      final paint = Paint()..color = planet.color;
      canvas.drawCircle(planetCenter, displayPlanetRadius, paint);
    }
  }

  void drawSun() {
    final paint = Paint()..color = sunColor;
    canvas.drawCircle(_center, sunDisplayRadius, paint);

    final text = TextSpan(
      text: sunLabel,
      style: GoogleFonts.ptSans(
          textStyle: const TextStyle(fontWeight: FontWeight.bold)),
    );
    final textPainter = TextPainter(
      text: text,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );
    textPainter.layout();

    final textOffset = Offset(
      size!.width / 2 - textPainter.width / 2,
      size!.height / 2 + sunDisplayRadius + 4,
    );
    textPainter.paint(canvas, textOffset);
  }

  void drawScaleFactors() {
    final text = TextSpan(
      text: [
        _stringifyFactor('Distance scale factor', distancesToSunScaleFactor),
        _stringifyFactor('Planet size scale factor', planetsRadiusScaleFactor),
        _stringifyFactor('Speed scale factor', planetsOrbitalSpeedScaleFactor),
      ].join('\n'),
      style: GoogleFonts.ptMono(),
    );
    final textPainter = TextPainter(
      text: text,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();

    final textOffset = Offset(
      factorLabelLeftPadding,
      size!.height - textPainter.height - factorLabelBottomPadding,
    );
    textPainter.paint(canvas, textOffset);
  }

  String _stringifyFactor(String label, double? factor) {
    final factorString =
        factor == null ? notApplicable : factor.toStringAsFixed(factorDecimals);
    final linePads = factorLabelWidth - label.length;
    return '$label: ${factorString.padLeft(linePads)}';
  }
}
