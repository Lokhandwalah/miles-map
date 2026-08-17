import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/primary_button.dart';
import '../../../../core/theme/design_system.dart';
import '../bloc/onboarding_bloc.dart';
import '../bloc/onboarding_event.dart';
import '../bloc/onboarding_state.dart';
import '../widgets/onboarding_dot_indicator.dart';
import '../widgets/onboarding_slide.dart';

/// Onboarding flow — three swipeable pages introducing MilesMap, ending in
/// a "Get Started" CTA.
///
/// Design reference: Figma "Onboarding/Slide 1..3" frames, node ids
/// 79:2, 79:21, 79:39
/// (https://www.figma.com/design/wL6jGjyB5BVWt6bZ9J6aBt/Miles-Map?node-id=79-2).
///
/// NOTE ON LAYOUT: Figma's root frame pads content by 60px on top / 40px on
/// bottom / 24px on left+right (`pt-60 pb-40 px-24`) with no separate
/// safe-area wrapper — those top/bottom values already model the full gap
/// from the physical device edge on the reference frame (a 375x812,
/// iPhone-X-class viewport), so this view applies them as literal padding
/// rather than nesting inside a [SafeArea] (which would double up on top of
/// the notch/home-indicator allowance already baked into 60/40). 60 and 40
/// don't map onto [AppSpacing]'s 4-32 scale, so they're left as raw values;
/// the 24px horizontal padding and 32px section gaps below do map onto
/// [AppSpacing.xl]/[AppSpacing.xxl] and use those tokens.
///
/// NOTE ON COMPLETION: [onOnboardingComplete] is the integration point for
/// whatever comes after onboarding (e.g. an auth/landing screen) — this
/// view never navigates on its own, since that destination isn't built yet.
class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key, required this.onOnboardingComplete});

  /// Called when the user finishes the flow (taps "Get Started" on the
  /// last page). The caller decides where to navigate next.
  final VoidCallback onOnboardingComplete;

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _syncControllerToState(OnboardingState state) {
    if (!_pageController.hasClients) return;
    final controllerPage = _pageController.page?.round();
    if (controllerPage == state.currentPage) return;
    _pageController.animateToPage(
      state.currentPage,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OnboardingBloc(pageCount: onboardingSlides.length),
      child: BlocConsumer<OnboardingBloc, OnboardingState>(
        listenWhen: (previous, current) =>
            previous.currentPage != current.currentPage,
        listener: (context, state) => _syncControllerToState(state),
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.black,
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: AppSpacing.xxl,
                children: [
                  _TopBar(isLastPage: state.isLastPage),
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: onboardingSlides.length,
                      onPageChanged: (page) => context
                          .read<OnboardingBloc>()
                          .add(OnboardingPageChanged(page)),
                      itemBuilder: (context, index) =>
                          OnboardingSlide(data: onboardingSlides[index]),
                    ),
                  ),
                  _Bottom(
                    state: state,
                    onComplete: widget.onOnboardingComplete,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Right-aligned "Skip" affordance, hidden on the last page.
///
/// Design reference: Figma "TopBar" frame (e.g. node 79:3).
class _TopBar extends StatelessWidget {
  const _TopBar({required this.isLastPage});
  final bool isLastPage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: isLastPage
          ? null
          : Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => context.read<OnboardingBloc>().add(
                  const OnboardingSkipRequested(),
                ),
                child: Text(
                  'Skip',
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
    );
  }
}

/// Dot indicator + primary CTA, stacked at the bottom of every page.
///
/// Design reference: Figma "Bottom" frame (e.g. node 79:14).
class _Bottom extends StatelessWidget {
  const _Bottom({required this.state, required this.onComplete});

  final OnboardingState state;
  final VoidCallback onComplete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        spacing: AppSpacing.xl,
        children: [
          OnboardingDotIndicator(
            pageCount: state.pageCount,
            currentPage: state.currentPage,
          ),
          PrimaryButton(
            label: state.isLastPage ? 'Get Started' : 'Next',
            onPressed: () {
              if (state.isLastPage) {
                onComplete();
              } else {
                context.read<OnboardingBloc>().add(
                  const OnboardingNextPageRequested(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

@Preview(name: 'Onboarding View')
Widget onboardingViewPreview() => OnboardingView(onOnboardingComplete: () {});
