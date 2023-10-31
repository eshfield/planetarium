import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/models/planet.dart';
import '../../cubits/add_planet/add_planet_cubit.dart';
import 'widgets/add_planet_form.dart';

class AddPlanetScreen extends StatelessWidget {
  const AddPlanetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return BlocProvider(
      create: (_) => AddPlanetCubit(),
      child: BlocListener<AddPlanetCubit, AddPlanetState>(
        listenWhen: (_, state) =>
            state.addPlanetStatus == AddPlanetStatus.success,
        listener: (context, state) {
          final planet = Planet(
            color: state.color!,
            radius: double.parse(state.radius.value),
            distanceToSun: double.parse(state.distanceToSun.value),
            orbitalSpeed: double.parse(state.orbitalSpeed.value),
          );
          context.pop(planet);
        },
        child: Scaffold(
          appBar: AppBar(title: Text(l10n.addPlanetScreenTitle)),
          body: const Padding(
            padding: EdgeInsets.all(32),
            child: Center(
              child: AddPlanetForm(),
            ),
          ),
        ),
      ),
    );
  }
}
