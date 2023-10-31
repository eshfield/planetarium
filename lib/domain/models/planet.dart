import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Planet {
  final String id = uuid.v4();
  final Color color;
  final double radius; // km
  final double distanceToSun; // km
  final double orbitalSpeed; // km/s

  Planet({
    required this.color,
    required this.radius,
    required this.distanceToSun,
    required this.orbitalSpeed,
  });

  @override
  String toString() =>
      'Planet [id: $id, color: $color, radius: $radius, distance to sun: $distanceToSun, orbital speed: $orbitalSpeed]';
}
