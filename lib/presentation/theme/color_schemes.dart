import 'package:flutter/material.dart';

import 'colors.dart';

class AppColorScheme {
  static get dark => const ColorScheme(
    brightness: Brightness.dark,
    primary: CustomColors.blue,
    onPrimary: Colors.white,
    secondary: CustomColors.grey2,
    onSecondary: Colors.black,
    error: CustomColors.red,
    onError: Colors.white,
    surface: Colors.black,
    onSurface: Colors.white,
    tertiary: CustomColors.grey5,
    onTertiary: Colors.white,
    secondaryContainer: CustomColors.grey6,
    onSecondaryContainer: Colors.white,
    surfaceContainerLow: CustomColors.grey7,
    outline: CustomColors.grey7,
    surfaceContainerHighest: CustomColors.grey7,
  );

  static get light => const ColorScheme(
    brightness: Brightness.light,
    primary: CustomColors.blue,
    onPrimary: Colors.white,
    secondary: CustomColors.grey6,
    onSecondary: Colors.black,
    error: CustomColors.red,
    onError: Colors.white,
    surface: Colors.white,
    onSurface: Colors.black,
    tertiary: CustomColors.grey5,
    onTertiary: Colors.black,
    secondaryContainer: CustomColors.grey2,
    onSecondaryContainer: Colors.black,
    surfaceContainerLow: CustomColors.grey1,
    outline: CustomColors.grey1,
    surfaceContainerHighest: CustomColors.grey1,
  );
}