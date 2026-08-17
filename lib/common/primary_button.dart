import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

import '../core/theme/design_system.dart';

/// Full-width, pill-shaped primary CTA button.
///
/// Shared across features (onboarding today; the Figma "Auth/Continue"
/// frame, node 86:38, reuses the same "Button/Primary" component) — lives
/// under `common/` rather than a single feature's `presentation/widgets/`.
///
/// Design reference: Figma "Button/Primary" component, node 77:3
/// (https://www.figma.com/design/wL6jGjyB5BVWt6bZ9J6aBt/Miles-Map?node-id=77-3).
///
/// NOTE: deliberately not routed through `ThemeData.elevatedButtonTheme`
/// ([AppButtonTheme.elevatedButtonTheme]) — that app-wide theme uses a 12px
/// radius and [AppTypography.labelLarge] text, whereas this component is a
/// full 999px pill with a 16px semibold label, so it's built as its own
/// widget instead of overriding the shared button theme per call site.
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  /// The button's label, e.g. "Next" or "Get Started".
  final String label;

  /// Pass `null` to render the button in its disabled state (e.g. while a
  /// form is invalid or a request is in flight).
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.onPrimary,
          disabledBackgroundColor: AppColors.disabled,
          disabledForegroundColor: AppColors.textSecondary,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xl,
            vertical: AppSpacing.lg,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: AppRadius.pillBorderRadius,
          ),
          textStyle: AppTypography.titleMedium
        ),
        child: Text(label),
      ),
    );
  }
}

@Preview(name: 'Primary Button')
Widget primaryButtonPreview() => ColoredBox(
  color: AppColors.black,
  child: Padding(
    padding: const EdgeInsets.all(16),
    child: PrimaryButton(label: 'Get Started', onPressed: () {}),
  ),
);
