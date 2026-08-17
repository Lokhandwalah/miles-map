import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

import '../../../../core/theme/design_system.dart';
import '../../../../gen/assets.gen.dart';

/// Renders a single onboarding page's illustration badge, headline, and
/// supporting copy — the "Content" section of each onboarding slide.
///
/// Design reference: Figma "Content" frame within each
/// `Onboarding/Slide *` frame (e.g. node 79:5)
/// (https://www.figma.com/design/wL6jGjyB5BVWt6bZ9J6aBt/Miles-Map?node-id=79-5).
///
/// NOTE ON COLOR TOKENS: [AppColors.surfaceElevated] and
/// [AppColors.textSecondary] are the closest existing tokens, but this
/// Figma screen publishes exact variables (`color/surface-elevated:#141d33`,
/// `color/text-secondary:#6b7fa3`) that don't match either precisely
/// (current tokens: `#1E2631`, `#5C6470`) — flagged back for the
/// app-designer agent to reconcile `AppColors` against real Figma
/// variables now that they're available.
///
/// NOTE ON TYPE STYLE: the headline uses Figma's "Display/Headline" style
/// (Sora Bold, 30px/38 line-height), which doesn't exist verbatim in
/// [AppTypography]'s scale. Per project convention, the closest existing
/// named style is used instead ([AppTypography.headlineLarge], 32px/40) with
/// only family (`.inSora`) and weight overridden — flag to the app-designer
/// agent if a dedicated "headline"-scale token should be added.
class OnboardingSlide extends StatelessWidget {
  const OnboardingSlide({super.key, required this.data});

  final OnboardingSlideData data;

  static const _badgeSize = 160.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: AppSpacing.xl,
      children: [
        Container(
          width: _badgeSize,
          height: _badgeSize,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: AppRadius.lgBorderRadius,
            boxShadow: [
              BoxShadow(color: AppColors.primary, blurRadius: AppRadius.md),
            ],
          ),
          padding: EdgeInsets.all(4),
          child: ClipRRect(
            borderRadius: AppRadius.lgBorderRadius,
            child: Image.asset(data.imageAssetPath, fit: BoxFit.cover),
          ),
        ),
        Text(
          data.title,
          textAlign: TextAlign.center,
          style: AppTypography.headlineLarge.inSora
        ),
        Text(
          data.description,
          textAlign: TextAlign.center,
          style: AppTypography.bodyLarge.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}

@Preview(name: 'Onboarding Slide')
Widget onboardingSlidePreview() => ColoredBox(
  color: AppColors.black,
  child: OnboardingSlide(data: onboardingSlides[0]),
);


/// Static content for a single onboarding page.
///
/// Design reference: Figma "Onboarding/Slide 1..3" frames, node ids
/// 79:2, 79:21, 79:39
/// (https://www.figma.com/design/wL6jGjyB5BVWt6bZ9J6aBt/Miles-Map?node-id=79-2).
@immutable
class OnboardingSlideData {
  const OnboardingSlideData({
    required this.imageAssetPath,
    required this.title,
    required this.description,
  });

  /// Path to the bundled illustration icon, exported from the Figma
  /// "IllustrationBadge" > "Frame" icon layer at 4x for retina sharpness.
  final String imageAssetPath;

  /// Headline copy, with an explicit `\n` where Figma manually breaks the
  /// line (both lines share the same text style).
  final String title;

  /// Supporting paragraph copy shown below the headline.
  final String description;
}

/// The three onboarding pages, in display order, straight from Figma.
final onboardingSlides = <OnboardingSlideData>[
  OnboardingSlideData(
    imageAssetPath: Assets.images.onboarding.icon1.path,
    title: 'Compare Every\nTransfer Rate',
    description:
        'See real transfer values across\n'
        'all airline and hotel partners',
  ),
  OnboardingSlideData(
    imageAssetPath: Assets.images.onboarding.icon2.path,
    title: 'Track Every\nPoint You Own',
    description:
        'Connect your cards once and always know\n'
        'exactly how many points and miles you have.',
  ),
  OnboardingSlideData(
    imageAssetPath: Assets.images.onboarding.icon3.path,
    title: 'Get The Best Value,\nEvery Time',
    description:
        'Get smart, ranked recommendations on\n'
        'where to transfer for maximum value.',
  ),
];
