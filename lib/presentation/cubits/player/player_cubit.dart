import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/models/planet.dart';

part 'player_state.dart';

class PlayerCubit extends Cubit<PlayerState> {
  PlayerCubit() : super(PlayerState());

  void addPlanet(Planet planet) {
    final newState = state.copyWith(planets: [...state.planets, planet]);
    emit(newState);
  }

  void play() {
    final newState = state.copyWith(playerStatus: PlayerStatus.playing);
    emit(newState);
  }

  void pause() {
    final newState = state.copyWith(playerStatus: PlayerStatus.pause);
    emit(newState);
  }
}
