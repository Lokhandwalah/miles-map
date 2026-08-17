import 'package:equatable/equatable.dart';

/// Base class for events consumed by [OnboardingBloc].
///
/// {@template onboarding_bloc_scope}
/// This bloc is presentation-only navigation state for the onboarding page
/// flow — the pages are static, locally-defined content (see
/// `presentation/widgets/onboarding_slide_data.dart`), so there's no
/// domain/data layer or use case behind it.
/// {@endtemplate}
sealed class OnboardingEvent extends Equatable {
  const OnboardingEvent();

  @override
  List<Object?> get props => [];
}

/// Fired when the primary CTA ("Next") is tapped on a non-last page.
class OnboardingNextPageRequested extends OnboardingEvent {
  const OnboardingNextPageRequested();
}

/// Fired to step back exactly one page.
///
/// NOTE: Figma's onboarding flow (node 79:2/79:21/79:39) only exposes
/// Skip/Next/"Get Started" — there is no back/previous control in the
/// design — so nothing in [OnboardingView] currently dispatches this event.
/// It's kept as part of the bloc's public API so all page-navigation logic
/// lives in one place if a back affordance is added later.
class OnboardingPreviousPageRequested extends OnboardingEvent {
  const OnboardingPreviousPageRequested();
}

/// Fired when "Skip" is tapped — jumps straight to the last page.
class OnboardingSkipRequested extends OnboardingEvent {
  const OnboardingSkipRequested();
}

/// Fired whenever the `PageView` itself reports a page change — a manual
/// swipe in either direction, or the settle callback after a programmatic
/// `animateToPage` — to keep bloc state in sync with the raw page index the
/// `PageView` is actually showing.
class OnboardingPageChanged extends OnboardingEvent {
  const OnboardingPageChanged(this.page);

  /// The page index the `PageView` is now showing.
  final int page;

  @override
  List<Object?> get props => [page];
}
