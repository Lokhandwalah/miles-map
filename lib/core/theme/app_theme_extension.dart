import 'package:flutter/material.dart';

import 'app_gradients.dart';
import 'app_spacing.dart';

/// [ThemeExtension] for design tokens `ThemeData` has no built-in slot for.
///
/// Gradients have no `ThemeData` field, so they live here. The radius scale
/// is also exposed for convenience since call sites already reach for
/// `Theme.of(context)` when styling — but the plain [AppSpacing]/[AppRadius]
/// static constants remain the simpler path for most call sites and are
/// not duplicated here wholesale.
@immutable
class AppThemeExtension extends ThemeExtension<AppThemeExtension> {
  const AppThemeExtension({
    required this.primaryGradient,
    required this.surfaceGradient,
    required this.radiusMd,
    required this.radiusLg,
  });

  /// Primary CTA / "best value" badge gradient.
  final LinearGradient primaryGradient;

  /// Subtle elevated-card gradient.
  final LinearGradient surfaceGradient;

  /// Mirrors [AppRadius.md] for widgets that only have `Theme.of(context)`
  /// in scope.
  final double radiusMd;

  /// Mirrors [AppRadius.lg] for widgets that only have `Theme.of(context)`
  /// in scope.
  final double radiusLg;

  /// The standard (and currently only) instance, built from [AppGradients]
  /// and [AppRadius].
  static const AppThemeExtension standard = AppThemeExtension(
    primaryGradient: AppGradients.primaryGradient,
    surfaceGradient: AppGradients.surfaceGradient,
    radiusMd: AppRadius.md,
    radiusLg: AppRadius.lg,
  );

  @override
  AppThemeExtension copyWith({
    LinearGradient? primaryGradient,
    LinearGradient? surfaceGradient,
    double? radiusMd,
    double? radiusLg,
  }) {
    return AppThemeExtension(
      primaryGradient: primaryGradient ?? this.primaryGradient,
      surfaceGradient: surfaceGradient ?? this.surfaceGradient,
      radiusMd: radiusMd ?? this.radiusMd,
      radiusLg: radiusLg ?? this.radiusLg,
    );
  }

  @override
  AppThemeExtension lerp(ThemeExtension<AppThemeExtension>? other, double t) {
    if (other is! AppThemeExtension) return this;
    return AppThemeExtension(
      primaryGradient:
          LinearGradient.lerp(primaryGradient, other.primaryGradient, t) ??
          primaryGradient,
      surfaceGradient:
          LinearGradient.lerp(surfaceGradient, other.surfaceGradient, t) ??
          surfaceGradient,
      radiusMd: lerpDouble(radiusMd, other.radiusMd, t),
      radiusLg: lerpDouble(radiusLg, other.radiusLg, t),
    );
  }

  static double lerpDouble(double a, double b, double t) => a + (b - a) * t;
}
