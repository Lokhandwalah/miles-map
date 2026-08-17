import 'package:flutter/material.dart';

/// Design-system color tokens for MilesMap.
///
/// The five constants at the top of this class (`primary`, `secondary`,
/// `tertiary`, `white`, `black`) are the base palette and the single
/// source of truth for color in this app. Every other color below is
/// *derived* from one of those five — never introduce a new raw hex value
/// outside this file.
///
/// RECONCILED against the real Figma color variables published on the
/// Onboarding (`node 79:2/79:21/79:39`), Auth (`node 86:38`), and shared
/// component (`node 77:3`, `node 77:16`) frames of
/// https://www.figma.com/design/wL6jGjyB5BVWt6bZ9J6aBt/Miles-Map. Every
/// constant below whose doc comment references a `color/*` Figma variable
/// name is a direct 1:1 pull — no more approximated/hand-picked hex values
/// for those. [secondary] has no published Figma variable anywhere in the
/// file yet (the closest reference, the "Container" hero on node 112:947,
/// uses a raw unbound hex that doesn't match it) — it remains the
/// pre-Figma placeholder pending a real variable.
abstract final class AppColors {
  // ---------------------------------------------------------------------
  // Base palette (source of truth; confirmed/refined by Figma where noted)
  // ---------------------------------------------------------------------

  /// Brand accent — CTAs, links, highlighted values, best-value badges.
  /// Figma `color/primary`.
  static const Color primary = Color(0xFF00C9A7);

  /// Secondary accents, active/selected chips, info highlights.
  /// No published Figma variable yet — placeholder, unchanged.
  static const Color secondary = Color(0xFF65789C);

  /// Muted/secondary text, labels, disabled/inactive states.
  /// Figma `color/text-secondary`.
  static const Color tertiary = Color(0xFF6B7FA3);

  /// Primary text (an off-white/blue-white, not pure white).
  /// Figma `color/text-primary`.
  static const Color white = Color(0xFFDDE4F0);

  /// App background and dark surfaces (a near-black navy, not pure black).
  /// Figma `color/background`.
  static const Color black = Color(0xFF070B14);

  // ---------------------------------------------------------------------
  // Derived neutrals — direct Figma pulls where a variable exists, or
  // computed from the base palette where Figma doesn't define one.
  // ---------------------------------------------------------------------

  /// Card/panel background, one step up from [black]/[background].
  /// Figma `color/surface`.
  static const Color surface = Color(0xFF0D1526);

  /// Modals / elevated surfaces / dialogs / illustration badges.
  /// Figma `color/surface-elevated`.
  static const Color surfaceElevated = Color(0xFF141D33);

  /// Hairline borders around cards/inputs, inactive dot indicators.
  /// Figma `color/border`.
  static const Color border = Color(0xFF1A2440);

  /// List/section dividers. No dedicated Figma variable — kept at the
  /// same weight as [surfaceElevated], as before reconciliation.
  static const Color divider = surfaceElevated;

  /// Disabled/inactive foreground — [tertiary] at ~40% opacity.
  static const Color disabled = Color(0x666B7FA3);

  // ---------------------------------------------------------------------
  // Semantic aliases — resolve directly to a base token, kept separate so
  // call sites can express intent (e.g. `textPrimary` vs `white`).
  // ---------------------------------------------------------------------

  /// App background. Alias of [black]. Figma `color/background`.
  static const Color background = black;

  /// Primary text color (alias of [white]). Figma `color/text-primary`.
  static const Color textPrimary = white;

  /// Secondary/muted text color (alias of [tertiary]).
  /// Figma `color/text-secondary`.
  static const Color textSecondary = tertiary;

  /// Text/icon color placed on top of [primary]. Figma `color/on-primary`
  /// — happens to equal [black]/[background] exactly.
  static const Color onPrimary = black;

  /// Text/icon color placed on top of [secondary]. No published Figma
  /// variable (mirrors [secondary]'s placeholder status).
  static const Color onSecondary = white;
}
