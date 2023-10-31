import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';

import '../../formz_fields/double_positive_input.dart';

part 'add_planet_state.dart';

class AddPlanetCubit extends Cubit<AddPlanetState> {
  AddPlanetCubit() : super(AddPlanetState());

  void onColorChange(Color color) {
    final newState = state.copyWith(color: color);
    emit(newState);
  }

  void onRadiusChange(String value) {
    final newState = state.copyWith(radius: DoublePositiveInput.pure(value));
    emit(newState);
  }

  void onRadiusUnfocus() {
    final newState =
        state.copyWith(radius: DoublePositiveInput.dirty(state.radius.value));
    emit(newState);
  }

  void onDistanceToSunChange(String value) {
    final newState =
        state.copyWith(distanceToSun: DoublePositiveInput.pure(value));
    emit(newState);
  }

  void onDistanceToSunUnfocus() {
    final newState = state.copyWith(
        distanceToSun: DoublePositiveInput.dirty(state.distanceToSun.value));
    emit(newState);
  }

  void onOrbitalSpeedChange(String value) {
    final newState =
        state.copyWith(orbitalSpeed: DoublePositiveInput.pure(value));
    emit(newState);
  }

  void onOrbitalSpeedUnfocus() {
    final newState = state.copyWith(
        orbitalSpeed: DoublePositiveInput.dirty(state.orbitalSpeed.value));
    emit(newState);
  }

  void onSubmit() {
    final isFormValid = Formz.validate([
      state.radius,
      state.distanceToSun,
      state.orbitalSpeed,
    ]);
    if (!isFormValid) {
      final newState = state.copyWith(
        radius: DoublePositiveInput.dirty(state.radius.value),
        distanceToSun: DoublePositiveInput.dirty(state.distanceToSun.value),
        orbitalSpeed: DoublePositiveInput.dirty(state.orbitalSpeed.value),
      );
      emit(newState);
      return;
    }

    final newState = state.copyWith(addPlanetStatus: AddPlanetStatus.success);
    emit(newState);
  }
}
