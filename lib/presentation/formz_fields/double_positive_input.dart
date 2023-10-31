import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:formz/formz.dart';

class DoublePositiveInput extends FormzInput<String, DoublePositiveInputError> {
  const DoublePositiveInput.pure([String value = '']) : super.pure(value);

  const DoublePositiveInput.dirty(String value) : super.dirty(value);

  @override
  DoublePositiveInputError? validator(String value) {
    if (value.isEmpty) return DoublePositiveInputError.empty;
    final number = double.tryParse(value);
    if (number == null) return DoublePositiveInputError.invalid;
    if (number < 0) return DoublePositiveInputError.negative;
    if (number == 0) return DoublePositiveInputError.zero;
    return null;
  }

  String? errorText(AppLocalizations l10n) {
    return switch (displayError) {
      DoublePositiveInputError.empty => l10n.addPlanetFormFieldErrorEmpty,
      DoublePositiveInputError.invalid => l10n.addPlanetFormFieldErrorInvalid,
      DoublePositiveInputError.negative => l10n.addPlanetFormFieldErrorNegative,
      DoublePositiveInputError.zero => l10n.addPlanetFormFieldErrorZero,
      null => null,
    };
  }
}

enum DoublePositiveInputError {
  empty,
  invalid,
  negative,
  zero,
}
