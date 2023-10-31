import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import '../../../cubits/add_planet/add_planet_cubit.dart';

class ColorChooser extends StatelessWidget {
  const ColorChooser({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final cubit = context.read<AddPlanetCubit>();
    return BlocBuilder<AddPlanetCubit, AddPlanetState>(
      builder: (context, state) {
        return ColorIndicator(
          color: state.color!,
          width: 48,
          height: 48,
          borderRadius: 4,
          onSelectFocus: false,
          onSelect: () async {
            final newColor = await showColorPickerDialog(
              context,
              state.color!,
              width: 48,
              height: 48,
              borderRadius: 4,
              heading: Text(
                l10n.colorChooserHeading,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              showColorName: true,
              colorNameTextStyle: Theme.of(context).textTheme.titleSmall,
              enableShadesSelection: false,
              pickersEnabled: const {
                ColorPickerType.both: true,
                ColorPickerType.primary: false,
                ColorPickerType.accent: false,
              },
              constraints: const BoxConstraints(maxWidth: 320),
            );
            cubit.onColorChange(newColor);
          },
        );
      },
    );
  }
}
