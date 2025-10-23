import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff6a548d),
      surfaceTint: Color(0xff6a548d),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffecdcff),
      onPrimaryContainer: Color(0xff513c73),
      secondary: Color(0xff645a70),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffeadef7),
      onSecondaryContainer: Color(0xff4c4357),
      tertiary: Color(0xff7f525c),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffffd9df),
      onTertiaryContainer: Color(0xff643b44),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfffef7ff),
      onSurface: Color(0xff1d1a20),
      onSurfaceVariant: Color(0xff4a454e),
      outline: Color(0xff7b757f),
      outlineVariant: Color(0xffcbc4cf),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff322f35),
      inversePrimary: Color(0xffd5bbfc),
      primaryFixed: Color(0xffecdcff),
      onPrimaryFixed: Color(0xff250e45),
      primaryFixedDim: Color(0xffd5bbfc),
      onPrimaryFixedVariant: Color(0xff513c73),
      secondaryFixed: Color(0xffeadef7),
      onSecondaryFixed: Color(0xff1f182a),
      secondaryFixedDim: Color(0xffcec2db),
      onSecondaryFixedVariant: Color(0xff4c4357),
      tertiaryFixed: Color(0xffffd9df),
      onTertiaryFixed: Color(0xff32101a),
      tertiaryFixedDim: Color(0xfff1b7c3),
      onTertiaryFixedVariant: Color(0xff643b44),
      surfaceDim: Color(0xffdfd8e0),
      surfaceBright: Color(0xfffef7ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff9f1f9),
      surfaceContainer: Color(0xfff3ecf4),
      surfaceContainerHigh: Color(0xffede6ee),
      surfaceContainerHighest: Color(0xffe7e0e8),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff402b61),
      surfaceTint: Color(0xff6a548d),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff79629c),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff3b3346),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff73697f),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff512a34),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff8f606a),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff740006),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffcf2c27),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffef7ff),
      onSurface: Color(0xff131015),
      onSurfaceVariant: Color(0xff39343d),
      outline: Color(0xff55515a),
      outlineVariant: Color(0xff706b75),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff322f35),
      inversePrimary: Color(0xffd5bbfc),
      primaryFixed: Color(0xff79629c),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff604a82),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff73697f),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff5a5166),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff8f606a),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff744852),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffcbc4cc),
      surfaceBright: Color(0xfffef7ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff9f1f9),
      surfaceContainer: Color(0xffede6ee),
      surfaceContainerHigh: Color(0xffe1dbe3),
      surfaceContainerHighest: Color(0xffd6cfd7),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff362156),
      surfaceTint: Color(0xff6a548d),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff543e76),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff30293c),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff4e455a),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff46212a),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff673d47),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff600004),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff98000a),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffef7ff),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff000000),
      outline: Color(0xff2e2b33),
      outlineVariant: Color(0xff4c4750),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff322f35),
      inversePrimary: Color(0xffd5bbfc),
      primaryFixed: Color(0xff543e76),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff3d275d),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff4e455a),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff372f42),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff673d47),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff4d2730),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffbdb7be),
      surfaceBright: Color(0xfffef7ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff6eef7),
      surfaceContainer: Color(0xffe7e0e8),
      surfaceContainerHigh: Color(0xffd9d2da),
      surfaceContainerHighest: Color(0xffcbc4cc),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffd5bbfc),
      surfaceTint: Color(0xffd5bbfc),
      onPrimary: Color(0xff3a255b),
      primaryContainer: Color(0xff513c73),
      onPrimaryContainer: Color(0xffecdcff),
      secondary: Color(0xffcec2db),
      onSecondary: Color(0xff352d40),
      secondaryContainer: Color(0xff4c4357),
      onSecondaryContainer: Color(0xffeadef7),
      tertiary: Color(0xfff1b7c3),
      onTertiary: Color(0xff4b252e),
      tertiaryContainer: Color(0xff643b44),
      onTertiaryContainer: Color(0xffffd9df),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xFF11071F),
      onSurface: Color(0xffe7e0e8),
      onSurfaceVariant: Color(0xffcbc4cf),
      outline: Color(0xff958e99),
      outlineVariant: Color(0xff4a454e),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe7e0e8),
      inversePrimary: Color(0xff6a548d),
      primaryFixed: Color(0xffecdcff),
      onPrimaryFixed: Color(0xff250e45),
      primaryFixedDim: Color(0xffd5bbfc),
      onPrimaryFixedVariant: Color(0xff513c73),
      secondaryFixed: Color(0xffeadef7),
      onSecondaryFixed: Color(0xff1f182a),
      secondaryFixedDim: Color(0xffcec2db),
      onSecondaryFixedVariant: Color(0xff4c4357),
      tertiaryFixed: Color(0xffffd9df),
      onTertiaryFixed: Color(0xff32101a),
      tertiaryFixedDim: Color(0xfff1b7c3),
      onTertiaryFixedVariant: Color(0xff643b44),
      surfaceDim: Color(0xff151218),
      surfaceBright: Color(0xFF1A0B2E),
      surfaceContainerLowest: Color(0xff100d12),
      surfaceContainerLow: Color(0xff1d1a20),
      surfaceContainer: Color(0xff211e24),
      surfaceContainerHigh: Color(0xff2c292f),
      surfaceContainerHighest: Color(0xff37333a),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffe7d5ff),
      surfaceTint: Color(0xffd5bbfc),
      onPrimary: Color(0xff2f1a4f),
      primaryContainer: Color(0xff9e86c3),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffe4d7f1),
      onSecondary: Color(0xff2a2235),
      secondaryContainer: Color(0xff978ca4),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffffd1d9),
      onTertiary: Color(0xff3e1a24),
      tertiaryContainer: Color(0xffb7838d),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffd2cc),
      onError: Color(0xff540003),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff151218),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffe2dae5),
      outline: Color(0xffb6afba),
      outlineVariant: Color(0xff948e98),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe7e0e8),
      inversePrimary: Color(0xff533d74),
      primaryFixed: Color(0xffecdcff),
      onPrimaryFixed: Color(0xff1a023a),
      primaryFixedDim: Color(0xffd5bbfc),
      onPrimaryFixedVariant: Color(0xff402b61),
      secondaryFixed: Color(0xffeadef7),
      onSecondaryFixed: Color(0xff150e1f),
      secondaryFixedDim: Color(0xffcec2db),
      onSecondaryFixedVariant: Color(0xff3b3346),
      tertiaryFixed: Color(0xffffd9df),
      onTertiaryFixed: Color(0xff25060f),
      tertiaryFixedDim: Color(0xfff1b7c3),
      onTertiaryFixedVariant: Color(0xff512a34),
      surfaceDim: Color(0xff151218),
      surfaceBright: Color(0xff474349),
      surfaceContainerLowest: Color(0xff08070b),
      surfaceContainerLow: Color(0xff1f1c22),
      surfaceContainer: Color(0xff2a272d),
      surfaceContainerHigh: Color(0xff353137),
      surfaceContainerHighest: Color(0xff403c43),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xfff7ecff),
      surfaceTint: Color(0xffd5bbfc),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffd1b7f8),
      onPrimaryContainer: Color(0xff13002f),
      secondary: Color(0xfff7ecff),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffcabed7),
      onSecondaryContainer: Color(0xff0f0819),
      tertiary: Color(0xffffebee),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffedb4bf),
      onTertiaryContainer: Color(0xff1d020a),
      error: Color(0xffffece9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffaea4),
      onErrorContainer: Color(0xff220001),
      surface: Color(0xff151218),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xfff5edf9),
      outlineVariant: Color(0xffc7c0cb),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe7e0e8),
      inversePrimary: Color(0xff533d74),
      primaryFixed: Color(0xffecdcff),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffd5bbfc),
      onPrimaryFixedVariant: Color(0xff1a023a),
      secondaryFixed: Color(0xffeadef7),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffcec2db),
      onSecondaryFixedVariant: Color(0xff150e1f),
      tertiaryFixed: Color(0xffffd9df),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xfff1b7c3),
      onTertiaryFixedVariant: Color(0xff25060f),
      surfaceDim: Color(0xff151218),
      surfaceBright: Color(0xff524f55),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff211e24),
      surfaceContainer: Color(0xff322f35),
      surfaceContainerHigh: Color(0xff3d3a40),
      surfaceContainerHighest: Color(0xff49454c),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }


  ThemeData theme(ColorScheme colorScheme) => ThemeData(
     useMaterial3: true,
     brightness: colorScheme.brightness,
     colorScheme: colorScheme,
     textTheme: textTheme.apply(
       bodyColor: colorScheme.onSurface,
       displayColor: colorScheme.onSurface,
     ),
     scaffoldBackgroundColor: colorScheme.background,
     canvasColor: colorScheme.surface,
  );


  List<ExtendedColor> get extendedColors => [
  ];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
