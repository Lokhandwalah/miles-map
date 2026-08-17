import 'package:flutter/material.dart';

import '../../../../core/theme/design_system.dart';

/// A horizontal rule on either side of an "or continue with" label.
///
/// Design reference: Figma "Divider/OrLabel" component, node 85:5
/// (https://www.figma.com/design/wL6jGjyB5BVWt6bZ9J6aBt/Miles-Map?node-id=85-5).
/// Kept feature-scoped under `auth/presentation/widgets/` rather than
/// `common/` since no other feature reuses it yet — move it if that
/// changes.
class OrContinueWithDivider extends StatelessWidget {
  const OrContinueWithDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider(color: AppColors.border, height: 1)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: Text(
            'or continue with',
            style: AppTypography.labelMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ),
        const Expanded(child: Divider(color: AppColors.border, height: 1)),
      ],
    );
  }
}
