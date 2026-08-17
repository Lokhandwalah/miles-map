import 'package:flutter/material.dart';

import '../../gen/fonts.gen.dart';

/// The three font families bundled under `assets/fonts/` and declared in
/// `pubspec.yaml` (`flutter.fonts`). Never reference a family name as a raw
/// string — go through [familyName] (or the `.inSora`/`.inSans`/`.inMono`
/// [TextStyle] extension in `app_typography.dart`) so a family swap is a
/// one-line change here instead of a find-and-replace across the codebase.
enum AppFontFamily {
  /// Sora — display/headline font.
  sora,

  /// DM Sans — default body/label font.
  sans,

  /// JetBrains Mono — monospaced font for numeric/tabular data (points,
  /// currency values, codes).
  mono;

  /// The `pubspec.yaml`-declared family name, sourced from the generated
  /// [FontFamily] class (lib/gen/fonts.gen.dart) rather than hardcoded here.
  String get familyName => switch (this) {
    AppFontFamily.sora => FontFamily.sora,
    AppFontFamily.sans => FontFamily.dMSans,
    AppFontFamily.mono => FontFamily.jetBrainsMono,
  };
}

/// Single seam for font resolution across the app.
///
/// `app_typography.dart` and any other code that needs a [TextStyle] should
/// call [AppFontConfig.font] rather than constructing [TextStyle] directly.
abstract final class AppFontConfig {
  /// The family every [AppTypography] style uses unless overridden via the
  /// `.inSora`/`.inSans`/`.inMono` extension in `app_typography.dart`.
  static const AppFontFamily defaultFamily = AppFontFamily.sans;

  /// Builds a [TextStyle] for [family] (defaults to [defaultFamily]).
  static TextStyle font({
    AppFontFamily family = defaultFamily,
    double? fontSize,
    FontWeight? fontWeight,
    double? height,
    double? letterSpacing,
    Color? color,
  }) {
    return TextStyle(
      fontFamily: family.familyName,
      fontSize: fontSize,
      fontWeight: fontWeight,
      height: height,
      letterSpacing: letterSpacing,
      color: color,
    );
  }
}
