part of 'add_planet_cubit.dart';

final random = Random();

class AddPlanetState extends Equatable {
  final Color? color;
  final DoublePositiveInput radius;
  final DoublePositiveInput distanceToSun;
  final DoublePositiveInput orbitalSpeed;
  final AddPlanetStatus addPlanetStatus;

  AddPlanetState({
    color,
    this.radius = const DoublePositiveInput.pure(),
    this.distanceToSun = const DoublePositiveInput.pure(),
    this.orbitalSpeed = const DoublePositiveInput.pure(),
    this.addPlanetStatus = AddPlanetStatus.initial,
  }) : color = color ?? getRandomColor();

  AddPlanetState copyWith({
    Color? color,
    DoublePositiveInput? radius,
    DoublePositiveInput? distanceToSun,
    DoublePositiveInput? orbitalSpeed,
    AddPlanetStatus? addPlanetStatus,
  }) {
    return AddPlanetState(
      color: color ?? this.color,
      radius: radius ?? this.radius,
      distanceToSun: distanceToSun ?? this.distanceToSun,
      orbitalSpeed: orbitalSpeed ?? this.orbitalSpeed,
      addPlanetStatus: addPlanetStatus ?? this.addPlanetStatus,
    );
  }

  @override
  List<Object?> get props => [
        color,
        radius,
        distanceToSun,
        orbitalSpeed,
        addPlanetStatus,
      ];
}

enum AddPlanetStatus {
  initial,
  success,
}

Color getRandomColor() {
  final randomIndex = random.nextInt(ColorTools.primaryColors.length);
  return ColorTools.primaryColors[randomIndex];
}
