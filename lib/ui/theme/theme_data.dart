import 'package:cinema/ui/theme/color_schemes.g.dart';
import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: lightColorScheme,
);

ThemeData createLightTheme() {
  final colorScheme = lightTheme.colorScheme;

  return lightTheme.copyWith(
    appBarTheme: lightTheme.appBarTheme.copyWith(
      backgroundColor: colorScheme.primary,
      titleTextStyle: lightTheme.appBarTheme.titleTextStyle!.copyWith(
        color: colorScheme.onSurface,
      ),
      toolbarTextStyle: lightTheme.appBarTheme.toolbarTextStyle!.copyWith(
        color: colorScheme.onSurface,
      ),
    ),
  );
}

final darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: darkColorScheme,
);

extension ColorX on Color {
  Color withDisabledOpacity(bool isDisabled) => isDisabled ? withOpacity(0.38) : this;
}
