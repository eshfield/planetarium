import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final theme = ThemeData(
  brightness: Brightness.dark,
  colorSchemeSeed: Colors.blue,
  textTheme: GoogleFonts.ptSansTextTheme(ThemeData.dark().textTheme),
  useMaterial3: true,
);
