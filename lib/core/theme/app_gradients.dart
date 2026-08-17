import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Design-system gradients for MilesMap.
///
/// Built exclusively from [AppColors] tokens — no new raw hex values.
/// Both gradients here are *inferred/anticipatory*: the fintech reference
/// screenshot (dark navy "points/miles transfer" dashboard) uses flat
/// teal CTAs and flat card surfaces with no visible gradient, so these are
/// motivated by likely near-term use cases (primary CTA depth, subtle
/// card elevation) rather than pulled from an actual Figma gradient
/// style. Reconcile against real Figma gradient styles once MCP access
/// is restored; don't add further gradients beyond these two without a
/// concrete visible use case.
abstract final class AppGradients {
  /// Deeper teal derived from [AppColors.primary] by blending 20% toward
  /// [AppColors.black]: `Color.lerp(AppColors.primary, AppColors.black, 0.2)`.
  /// Recomputed after the color reconciliation against real Figma
  /// variables (`AppColors.primary`/`AppColors.black` both changed).
  static const Color _primaryDeep = Color(0xFF01A38A);

  /// Top-left to bottom-right teal gradient for primary CTA buttons and
  /// the "best value" badge treatment.
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.primary, _primaryDeep],
  );

  /// Subtle top-to-bottom gradient from [AppColors.surface] to
  /// [AppColors.surfaceElevated] for elevated cards that want depth
  /// instead of a flat fill.
  static const LinearGradient surfaceGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [AppColors.surface, AppColors.surfaceElevated],
  );
}
