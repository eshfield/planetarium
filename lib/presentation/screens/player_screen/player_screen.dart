import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/models/planet.dart';
import '../../../router.dart';
import '../../cubits/player/player_cubit.dart';
import 'widgets/solar_system.dart';

class PlayerScreen extends StatelessWidget {
  const PlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return BlocProvider(
      create: (context) => PlayerCubit(),
      child: BlocBuilder<PlayerCubit, PlayerState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(title: Text(l10n.playerScreenTitle)),
            body: const SolarSystem(),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () async {
                final cubit = context.read<PlayerCubit>();
                final planet =
                    await context.push<Planet>(AppRoutes.addPlanet.path);
                if (planet != null) cubit.addPlanet(planet);
              },
              icon: const Icon(Icons.add),
              label: Text(l10n.playerScreenFABLabel),
            ),
          );
        },
      ),
    );
  }
}
