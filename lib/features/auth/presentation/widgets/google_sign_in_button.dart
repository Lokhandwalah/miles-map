import 'package:flutter/material.dart';

import '../../../../core/theme/design_system.dart';
import '../../../../gen/assets.gen.dart';

/// "Continue with Google" pill button.
///
/// Design reference: Figma "Button/Google" component, node 77:12
/// (https://www.figma.com/design/wL6jGjyB5BVWt6bZ9J6aBt/Miles-Map?node-id=77-12).
/// Kept feature-scoped under `auth/presentation/widgets/` rather than
/// `common/` since no other feature reuses it yet — move it if that
/// changes.
///
/// NOTE ON COLOR: the white background + near-black (`#1f1f1f`) label are
/// Google's own brand-mandated button style, not a MilesMap design token —
/// intentionally hardcoded here rather than routed through [AppColors].
///
/// NOTE ON ICON: the multicolor "G" mark is exported from Figma (node
/// 77:7) as `Assets.images.icons.googleG` — there's no `flutter_svg`
/// dependency in this project, so it's committed as a PNG rather than an
/// SVG asset.
class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({super.key, required this.onPressed});

  final VoidCallback? onPressed;

  static const _labelColor = Color(0xFF1F1F1F);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          disabledBackgroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xl,
            vertical: AppSpacing.lg,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: AppRadius.pillBorderRadius,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: AppSpacing.md,
          children: [
            Assets.images.logos.google.image(width: 20, height: 20),
            Text(
              'Continue with Google',
              // Figma spec: "Title/Medium" (16px SemiBold, 22px line
              // height) — `titleMedium` (16/24, weight 500) is the closest
              // existing scale entry, per the same convention as
              // `common/primary_button.dart`.
              style: AppTypography.titleMedium.copyWith(
                fontWeight: FontWeight.w600,
                color: _labelColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
