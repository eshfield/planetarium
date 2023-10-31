import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import '../../../cubits/add_planet/add_planet_cubit.dart';
import 'color_chooser.dart';

class AddPlanetForm extends StatefulWidget {
  const AddPlanetForm({super.key});

  @override
  State<AddPlanetForm> createState() => _AddPlanetFormState();
}

class _AddPlanetFormState extends State<AddPlanetForm> {
  late AppLocalizations l10n;
  late AddPlanetCubit cubit;

  @override
  void didChangeDependencies() {
    l10n = AppLocalizations.of(context);
    cubit = context.read<AddPlanetCubit>();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddPlanetCubit, AddPlanetState>(
      builder: (context, state) {
        return ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _formHeader(),
                _radiusField(),
                _distanceToSunField(),
                _orbitalSpeedField(),
                _submitButton(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _formHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          l10n.addPlanetFormTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const ColorChooser(),
      ],
    );
  }

  Widget _radiusField() {
    return FieldPadding(
      child: Focus(
        onFocusChange: (hasFocus) {
          if (!hasFocus) cubit.onRadiusUnfocus();
        },
        child: TextField(
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: l10n.addPlanetFormRadius,
            suffixText: l10n.addPlanetFormRadiusUnits,
            errorText: cubit.state.radius.errorText(l10n),
          ),
          onChanged: cubit.onRadiusChange,
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.next,
        ),
      ),
    );
  }

  Widget _distanceToSunField() {
    return FieldPadding(
      child: Focus(
        onFocusChange: (hasFocus) {
          if (!hasFocus) cubit.onDistanceToSunUnfocus();
        },
        child: TextField(
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: l10n.addPlanetFormDistanceToSun,
            suffixText: l10n.addPlanetFormDistanceToSunUnits,
            errorText: cubit.state.distanceToSun.errorText(l10n),
          ),
          onChanged: cubit.onDistanceToSunChange,
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.next,
        ),
      ),
    );
  }

  Widget _orbitalSpeedField() {
    return FieldPadding(
      child: Focus(
        onFocusChange: (hasFocus) {
          if (!hasFocus) cubit.onOrbitalSpeedUnfocus();
        },
        child: TextField(
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: l10n.addPlanetFormOrbitalSpeed,
            suffixText: l10n.addPlanetFormOrbitalSpeedUnits,
            errorText: cubit.state.orbitalSpeed.errorText(l10n),
          ),
          onChanged: cubit.onOrbitalSpeedChange,
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.done,
        ),
      ),
    );
  }

  Widget _submitButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FilledButton(
            onPressed: cubit.onSubmit,
            child: Text(l10n.addPlanetFormSubmitButtonTitle),
          ),
        ],
      ),
    );
  }
}

class FieldPadding extends StatelessWidget {
  final Widget child;
  const FieldPadding({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: child,
    );
  }
}
