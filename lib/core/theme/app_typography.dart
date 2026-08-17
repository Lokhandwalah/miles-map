import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_font_config.dart';

/// Design-system type scale for MilesMap.
///
/// Every style is built through [AppFontConfig.font] — never construct
/// [TextStyle] directly here or at call sites — so the active font family
/// stays a single swappable seam. Every style below defaults to
/// [AppFontConfig.defaultFamily] (DM Sans); call sites needing a different
/// bundled family (Sora for display/headline emphasis, JetBrains Mono for
/// numeric/tabular data) use the [AppTypographyFamily] extension below,
/// e.g. `AppTypography.displayLarge.inSora`, `AppTypography.bodySmall.inMono`.
///
/// NOTE: most sizes/weights/letter-spacings below are still the stock
/// Material 3 default type scale — real Figma text styles only exist for
/// the specific slots documented inline below (pulled from the Onboarding,
/// Auth, and shared-component frames of
/// https://www.figma.com/design/wL6jGjyB5BVWt6bZ9J6aBt/Miles-Map). Treat
/// the rest of the scale as still pending reconciliation.
///
/// RECONCILED slots (Figma name -> Dart getter):
/// - `Display/Headline` (Sora Bold 30/38, letterSpacing 0) -> [headlineLarge]
///   (was approximated as the M3 default 32/40; corrected in place since
///   no other call site in the app depends on 32/40).
/// - `Title/Medium` (DM Sans SemiBold 16/22, letterSpacing 0) ->
///   [titleMedium] (was approximated as the M3 default 16/24 weight 500;
///   corrected in place since no other call site depends on the M3 value).
/// - `Body/Large` (DM Sans Regular 16/24, letterSpacing 0) -> [bodyLarge]
///   (size/weight/height already matched the M3 default; only
///   letterSpacing was off — corrected from 0.5 to 0).
/// - `Body/Medium` (DM Sans Regular 14/20, letterSpacing 0) -> [bodyMedium]
///   (same story — letterSpacing corrected from 0.25 to 0).
///
/// All styles default their color to [AppColors.textPrimary] (the app is
/// dark-first). Callers needing a different color should use
/// `AppTypography.bodyLarge.copyWith(color: ...)` rather than reaching for
/// a raw [TextStyle] or hex value.
abstract final class AppTypography {
  // ---------------------------------------------------------------------
  // Display
  // ---------------------------------------------------------------------

  /// M3 default: 57/64, weight 400, letterSpacing -0.25.
  static TextStyle get displayLarge => AppFontConfig.font(
    fontSize: 57,
    fontWeight: FontWeight.w400,
    height: 64 / 57,
    letterSpacing: -0.25,
    color: AppColors.textPrimary,
  );

  /// M3 default: 45/52, weight 400, letterSpacing 0.
  static TextStyle get displayMedium => AppFontConfig.font(
    fontSize: 45,
    fontWeight: FontWeight.w400,
    height: 52 / 45,
    letterSpacing: 0,
    color: AppColors.textPrimary,
  );

  /// M3 default: 36/44, weight 400, letterSpacing 0.
  static TextStyle get displaySmall => AppFontConfig.font(
    fontSize: 36,
    fontWeight: FontWeight.w400,
    height: 44 / 36,
    letterSpacing: 0,
    color: AppColors.textPrimary,
  );

  // ---------------------------------------------------------------------
  // Headline
  // ---------------------------------------------------------------------

  /// Figma `Display/Headline`: 30/38, weight 700 (Bold), letterSpacing 0.
  /// Family stays the default (DM Sans) here — call sites needing the
  /// Figma spec's Sora family apply `.inSora` explicitly (see
  /// [AppTypographyFamily]).
  static TextStyle get headlineLarge => AppFontConfig.font(
    fontSize: 30,
    fontWeight: FontWeight.w700,
    height: 38 / 30,
    letterSpacing: 0,
    color: AppColors.textPrimary,
  );

  /// M3 default: 28/36, weight 400, letterSpacing 0.
  static TextStyle get headlineMedium => AppFontConfig.font(
    fontSize: 28,
    fontWeight: FontWeight.w400,
    height: 36 / 28,
    letterSpacing: 0,
    color: AppColors.textPrimary,
  );

  /// M3 default: 24/32, weight 400, letterSpacing 0.
  static TextStyle get headlineSmall => AppFontConfig.font(
    fontSize: 24,
    fontWeight: FontWeight.w400,
    height: 32 / 24,
    letterSpacing: 0,
    color: AppColors.textPrimary,
  );

  // ---------------------------------------------------------------------
  // Title
  // ---------------------------------------------------------------------

  /// M3 default: 22/28, weight 400, letterSpacing 0.
  static TextStyle get titleLarge => AppFontConfig.font(
    fontSize: 22,
    fontWeight: FontWeight.w400,
    height: 28 / 22,
    letterSpacing: 0,
    color: AppColors.textPrimary,
  );

  /// Figma `Title/Medium`: 16/22, weight 600 (SemiBold), letterSpacing 0.
  static TextStyle get titleMedium => AppFontConfig.font(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 22 / 16,
    letterSpacing: 0,
    color: AppColors.textPrimary,
  );

  /// M3 default: 14/20, weight 500, letterSpacing 0.1.
  static TextStyle get titleSmall => AppFontConfig.font(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 20 / 14,
    letterSpacing: 0.1,
    color: AppColors.textPrimary,
  );

  // ---------------------------------------------------------------------
  // Body
  // ---------------------------------------------------------------------

  /// Figma `Body/Large`: 16/24, weight 400, letterSpacing 0.
  static TextStyle get bodyLarge => AppFontConfig.font(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 24 / 16,
    letterSpacing: 0,
    color: AppColors.textPrimary,
  );

  /// Figma `Body/Medium`: 14/20, weight 400, letterSpacing 0.
  static TextStyle get bodyMedium => AppFontConfig.font(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 20 / 14,
    letterSpacing: 0,
    color: AppColors.textPrimary,
  );

  /// M3 default: 12/16, weight 400, letterSpacing 0.4.
  static TextStyle get bodySmall => AppFontConfig.font(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 16 / 12,
    letterSpacing: 0.4,
    color: AppColors.textPrimary,
  );

  // ---------------------------------------------------------------------
  // Label
  // ---------------------------------------------------------------------

  /// M3 default: 14/20, weight 500, letterSpacing 0.1.
  static TextStyle get labelLarge => AppFontConfig.font(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 20 / 14,
    letterSpacing: 0.1,
    color: AppColors.textPrimary,
  );

  /// M3 default: 12/16, weight 500, letterSpacing 0.5.
  static TextStyle get labelMedium => AppFontConfig.font(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 16 / 12,
    letterSpacing: 0.5,
    color: AppColors.textPrimary,
  );

  /// M3 default: 11/16, weight 500, letterSpacing 0.5.
  static TextStyle get labelSmall => AppFontConfig.font(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    height: 16 / 11,
    letterSpacing: 0.5,
    color: AppColors.textPrimary,
  );

  // ---------------------------------------------------------------------
  // Aggregate TextTheme — 1:1 with ThemeData.textTheme slots.
  // ---------------------------------------------------------------------

  /// Assembles all 15 styles above into a [TextTheme] for direct use in
  /// `ThemeData(textTheme: AppTypography.textTheme)`.
  static TextTheme get textTheme => TextTheme(
    displayLarge: displayLarge,
    displayMedium: displayMedium,
    displaySmall: displaySmall,
    headlineLarge: headlineLarge,
    headlineMedium: headlineMedium,
    headlineSmall: headlineSmall,
    titleLarge: titleLarge,
    titleMedium: titleMedium,
    titleSmall: titleSmall,
    bodyLarge: bodyLarge,
    bodyMedium: bodyMedium,
    bodySmall: bodySmall,
    labelLarge: labelLarge,
    labelMedium: labelMedium,
    labelSmall: labelSmall,
  );
}

/// Swaps the font family of any [TextStyle] to one of the three bundled
/// families, independent of whatever size/weight/spacing is already set.
/// Use this instead of `copyWith(fontFamily: ...)` directly so every family
/// swap resolves through [AppFontFamily] rather than a raw string.
extension AppTypographyFamily on TextStyle {
  /// Sora — display/headline font.
  TextStyle get inSora => copyWith(fontFamily: AppFontFamily.sora.familyName);

  /// DM Sans — default body/label font. Only needed to override a family
  /// already switched to `.inSora`/`.inMono` back to the default.
  TextStyle get inSans => copyWith(fontFamily: AppFontFamily.sans.familyName);

  /// JetBrains Mono — monospaced font for numeric/tabular data.
  TextStyle get inMono => copyWith(fontFamily: AppFontFamily.mono.familyName);
}
