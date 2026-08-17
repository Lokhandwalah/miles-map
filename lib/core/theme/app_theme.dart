import 'package:flutter/material.dart';

import 'app_button_theme.dart';
import 'app_colors.dart';
import 'app_dialog_theme.dart';
import 'app_theme_extension.dart';
import 'app_typography.dart';

/// Assembles all MilesMap design tokens into a [ThemeData].
///
/// This is the *only* place `ThemeData` should be constructed — screens
/// and widgets consume `Theme.of(context)` (or
/// `Theme.of(context).extension<AppThemeExtension>()`), never the raw
/// token files directly.
///
/// NOTE: only a dark theme is provided. The only reference available for
/// this app so far is a dark-mode screenshot, so a light theme would mean
/// inventing colors with no source of truth. Add `AppTheme.light` once
/// Figma publishes real light-mode variables/modes.
abstract final class AppTheme {
  static ThemeData get dark => ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.surfaceElevated,
    colorScheme: ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      tertiary: AppColors.tertiary,
      surface: AppColors.surface,
      onPrimary: AppColors.onPrimary,
      onSecondary: AppColors.onSecondary,
      onSurface: AppColors.textPrimary,
      outline: AppColors.border,
    ),
    textTheme: AppTypography.textTheme,
    dividerColor: AppColors.divider,
    disabledColor: AppColors.disabled,
    elevatedButtonTheme: AppButtonTheme.elevatedButtonTheme,
    outlinedButtonTheme: AppButtonTheme.outlinedButtonTheme,
    textButtonTheme: AppButtonTheme.textButtonTheme,
    dialogTheme: AppDialogTheme.dialogTheme,
    extensions: const [AppThemeExtension.standard],
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: AppColors.primary,
    ),
  );

  // Pending real Figma light-mode tokens (variables/modes) — do not
  // fabricate light colors in the meantime.
  // static ThemeData get light => ...
}
