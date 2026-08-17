import 'package:flutter/material.dart';

import '../../../../core/theme/design_system.dart';

/// Mobile-number entry field for the "Auth/Continue" screen.
///
/// Design reference: Figma "Input/Field" component, node 77:14
/// (https://www.figma.com/design/wL6jGjyB5BVWt6bZ9J6aBt/Miles-Map?node-id=77-14).
/// Kept feature-scoped under `auth/presentation/widgets/` rather than
/// `common/` since no other feature reuses it yet — move it if that
/// changes.
///
/// NOTE ON COLOR: the Figma component's surface/border hex values
/// (`#0d1526` / `#1a2440`) don't exactly match the closest existing
/// [AppColors.surface]/[AppColors.border] tokens — flagged for the
/// app-designer agent to reconcile; this uses the closest existing tokens
/// rather than introducing new raw hex values.
class PhoneNumberField extends StatelessWidget {
  const PhoneNumberField({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.border),
        borderRadius: AppRadius.mdBorderRadius,
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        keyboardType: TextInputType.phone,
        style: AppTypography.bodyLarge,
        cursorColor: AppColors.primary,
        decoration: InputDecoration(
          border: InputBorder.none,
          isCollapsed: false,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: 14,
          ),
          hintText: 'Enter mobile number',
          hintStyle: AppTypography.bodyLarge.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}
