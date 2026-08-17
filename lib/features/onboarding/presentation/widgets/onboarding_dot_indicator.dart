import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

import '../../../../core/theme/design_system.dart';

/// A row of paged dots for the onboarding flow — a wide teal pill marks the
/// active page, plain outline-colored dots mark the rest.
///
/// Design reference: Figma "Indicator/Dots" component, node 77:16
/// (https://www.figma.com/design/wL6jGjyB5BVWt6bZ9J6aBt/Miles-Map?node-id=77-16).
/// Active dot: `color/primary` (`#00c9a7`, matches [AppColors.primary]
/// closely) at 24x8, `radius/pill` (999, matches [AppRadius.pill] exactly).
/// Inactive dot: `color/border` (`#1a2440`, matches [AppColors.border]
/// closely) at 8x8.
class OnboardingDotIndicator extends StatelessWidget {
  const OnboardingDotIndicator({
    super.key,
    required this.pageCount,
    required this.currentPage,
  });

  /// Total number of pages to render a dot for.
  final int pageCount;

  /// Index of the currently active page.
  final int currentPage;

  static const _dotSize = 8.0;
  static const _activeDotWidth = 24.0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: AppSpacing.sm,
      children: List.generate(pageCount, (index) {
        final isActive = index == currentPage;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          width: isActive ? _activeDotWidth : _dotSize,
          height: _dotSize,
          decoration: BoxDecoration(
            color: isActive ? AppColors.primary : AppColors.border,
            borderRadius: AppRadius.pillBorderRadius,
          ),
        );
      }),
    );
  }
}

@Preview(name: 'Onboarding Dot Indicator')
Widget onboardingDotIndicatorPreview() => const ColoredBox(
  color: AppColors.black,
  child: Padding(
    padding: EdgeInsets.all(16),
    child: OnboardingDotIndicator(pageCount: 3, currentPage: 1),
  ),
);
