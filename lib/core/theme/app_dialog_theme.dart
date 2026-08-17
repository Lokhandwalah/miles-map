import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_spacing.dart';
import 'app_typography.dart';

/// Design-system dialog theme for MilesMap.
///
/// NOTE: as of the installed Flutter SDK (3.41.3), `ThemeData.dialogTheme`
/// is typed [DialogThemeData] (renamed from the older `DialogTheme`
/// widget-theme-data class across recent Flutter versions) — use
/// [DialogThemeData] here so this compiles against the installed SDK.
abstract final class AppDialogTheme {
  static DialogThemeData get dialogTheme => DialogThemeData(
    backgroundColor: AppColors.surfaceElevated,
    shape: RoundedRectangleBorder(borderRadius: AppRadius.lgBorderRadius),
    titleTextStyle: AppTypography.titleLarge,
    contentTextStyle: AppTypography.bodyMedium,
  );
}
