import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../../../cubits/player/player_cubit.dart';

class PlayButton extends StatefulWidget {
  final StreamSubscription timeStreamSubscription;

  const PlayButton(this.timeStreamSubscription, {super.key});

  @override
  State<PlayButton> createState() => _PlayButtonState();
}

class _PlayButtonState extends State<PlayButton>
    with SingleTickerProviderStateMixin {
  late AnimationController playController;
  late Animation<double> playAnimation;

  @override
  void initState() {
    playController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    playAnimation = Tween(begin: 0.0, end: 1.0).animate(playController);
    super.initState();
  }

  @override
  void dispose() {
    playController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PlayerCubit, PlayerState>(
      listenWhen: (previous, current) =>
          previous.playerStatus != current.playerStatus,
      listener: (context, state) {
        switch (state.playerStatus) {
          case PlayerStatus.pause:
            widget.timeStreamSubscription.pause();
            playController.reverse();
            break;
          case PlayerStatus.playing:
            widget.timeStreamSubscription.resume();
            playController.forward();
            break;
        }
      },
      builder: (context, state) {
        return Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(24),
          child: InkWell(
            onTap: () {
              final cubit = context.read<PlayerCubit>();
              state.playerStatus == PlayerStatus.playing
                  ? cubit.pause()
                  : cubit.play();
            },
            borderRadius: BorderRadius.circular(24),
            child: AnimatedIcon(
              icon: AnimatedIcons.play_pause,
              progress: playAnimation,
              size: 48,
            ),
          ),
        );
      },
    );
  }
}
