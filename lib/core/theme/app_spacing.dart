import 'package:flutter/material.dart';

/// Design-system spacing scale for MilesMap.
///
/// A standard 4px-based scale. Screens/widgets should reference these
/// constants instead of hardcoding raw spacing numbers (paddings, gaps,
/// `SizedBox` sizes, etc.).
///
/// NOTE: Figma access was unavailable for this phase, so these are a
/// conventional 4px-based scale, not values pulled from Figma spacing
/// variables. Reconcile against real Figma spacing tokens once MCP access
/// is restored.
abstract final class AppSpacing {
  /// 4px — tightest spacing, e.g. icon-to-label gaps.
  static const double xs = 4;

  /// 8px — compact spacing, e.g. chip padding.
  static const double sm = 8;

  /// 12px — default gap between related elements.
  static const double md = 12;

  /// 16px — standard content padding.
  static const double lg = 16;

  /// 24px — section spacing.
  static const double xl = 24;

  /// 32px — large section/page spacing.
  static const double xxl = 32;
}

/// Design-system corner-radius scale for MilesMap.
///
/// Exposes both the raw `double` values and [BorderRadius] convenience
/// getters, since most call sites (containers, buttons, cards) want a
/// [BorderRadius] directly.
abstract final class AppRadius {
  /// 8px — small controls (chips, inputs).
  static const double sm = 8;

  /// 12px — default card/button radius.
  static const double md = 12;

  /// 16px — large surfaces (dialogs, sheets).
  static const double lg = 16;

  /// 999px — fully rounded/pill shapes.
  static const double pill = 999;

  /// [BorderRadius.circular] of [sm].
  static BorderRadius get smBorderRadius => BorderRadius.circular(sm);

  /// [BorderRadius.circular] of [md].
  static BorderRadius get mdBorderRadius => BorderRadius.circular(md);

  /// [BorderRadius.circular] of [lg].
  static BorderRadius get lgBorderRadius => BorderRadius.circular(lg);

  /// [BorderRadius.circular] of [pill].
  static BorderRadius get pillBorderRadius => BorderRadius.circular(pill);
}

/// Minimal elevation scale for MilesMap, for use with `Material`/`Card`
/// `elevation` params or custom `BoxShadow` blur radii.
abstract final class AppElevation {
  /// 2px — subtle resting elevation (e.g. chips).
  static const double sm = 2;

  /// 4px — default card elevation.
  static const double md = 4;

  /// 8px — elevated surfaces (dialogs, menus).
  static const double lg = 8;
}
