part of 'player_cubit.dart';

class PlayerState extends Equatable {
  final List<Planet> planets;
  final PlayerStatus playerStatus;

  PlayerState({
    planets,
    this.playerStatus = PlayerStatus.pause,
  }) : planets = planets ?? [];

  PlayerState copyWith({
    List<Planet>? planets,
    PlayerStatus? playerStatus,
  }) {
    return PlayerState(
      planets: planets ?? this.planets,
      playerStatus: playerStatus ?? this.playerStatus,
    );
  }

  @override
  List<Object?> get props => [
        planets,
        playerStatus,
      ];
}

enum PlayerStatus {
  playing,
  pause,
}
