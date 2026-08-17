import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_spacing.dart';
import 'app_typography.dart';

/// Design-system button themes for MilesMap.
///
/// Composed entirely from [AppColors], [AppTypography], and
/// [AppSpacing]/[AppRadius] tokens — no raw hex/number values here.
abstract final class AppButtonTheme {
  /// Filled teal primary button — CTAs.
  static ElevatedButtonThemeData get elevatedButtonTheme =>
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.onPrimary,
          disabledBackgroundColor: AppColors.disabled,
          disabledForegroundColor: AppColors.textSecondary,
          textStyle: AppTypography.labelLarge,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          shape: RoundedRectangleBorder(borderRadius: AppRadius.mdBorderRadius),
        ),
      );

  /// Outlined secondary button.
  static OutlinedButtonThemeData get outlinedButtonTheme =>
      OutlinedButtonThemeData(
        style:
            OutlinedButton.styleFrom(
              foregroundColor: AppColors.textPrimary,
              disabledForegroundColor: AppColors.textSecondary,
              side: const BorderSide(color: AppColors.border),
              textStyle: AppTypography.labelLarge,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.md,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: AppRadius.mdBorderRadius,
              ),
            ).copyWith(
              side: WidgetStateProperty.resolveWith(
                (states) => BorderSide(
                  color: states.contains(WidgetState.disabled)
                      ? AppColors.disabled
                      : AppColors.border,
                ),
              ),
            ),
      );

  /// Flat text button — links, low-emphasis actions.
  static TextButtonThemeData get textButtonTheme => TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: AppColors.primary,
      disabledForegroundColor: AppColors.textSecondary,
      textStyle: AppTypography.labelLarge,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      shape: RoundedRectangleBorder(borderRadius: AppRadius.mdBorderRadius),
    ),
  );
}
