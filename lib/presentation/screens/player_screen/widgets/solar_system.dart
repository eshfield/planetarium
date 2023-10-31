import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:planetarium/presentation/cubits/player/player_cubit.dart';

import '../graphics_engine.dart';
import 'play_button.dart';
import 'solar_system_painter.dart';
import 'space_sky_background.dart';

const tickTimeSpan = 20; // milliseconds

class SolarSystem extends StatefulWidget {
  const SolarSystem({super.key});

  @override
  State<SolarSystem> createState() => _SolarSystemState();
}

class _SolarSystemState extends State<SolarSystem> {
  late GraphicsEngine graphicsEngine;
  late SolarSystemPainter solarSystemPainter;
  final timeNotifier = ValueNotifier(0);
  late Stream<int> timeStream;
  late StreamSubscription timeStreamSubscription;

  @override
  void initState() {
    graphicsEngine = GraphicsEngine();
    // time stream to emit timestamps (milliseconds) with a given frequency
    timeStream = Stream.periodic(
      const Duration(milliseconds: tickTimeSpan),
      (count) => count * tickTimeSpan, // → total milliseconds elapsed
    );
    // listen to the stream to update the notifier to redraw CustomPainter
    // and get a subscription to control the simulation (play/pause)
    timeStreamSubscription = timeStream.listen((timestamp) {
      timeNotifier.value = timestamp;
    });
    timeStreamSubscription.pause();
    super.initState();
  }

  @override
  void dispose() {
    timeStreamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PlayerCubit, PlayerState>(
      listenWhen: (previous, current) => previous.planets != current.planets,
      listener: (context, state) => graphicsEngine.updatePlanets(state.planets),
      child: Stack(
        children: [
          CustomPaint(
            foregroundPainter: SolarSystemPainter(
              graphicsEngine: graphicsEngine,
              timeNotifier: timeNotifier,
            ),
            child: const SpaceSkyBackground(),
          ),
          Positioned(
            left: 16,
            bottom: 16,
            child: PlayButton(timeStreamSubscription),
          ),
        ],
      ),
    );
  }
}
