import 'package:equatable/equatable.dart';

/// Navigation state for the onboarding page flow.
///
/// {@macro onboarding_bloc_scope}
class OnboardingState extends Equatable {
  const OnboardingState({required this.currentPage, required this.pageCount});

  /// The first-run state: page 0 of [pageCount].
  factory OnboardingState.initial({required int pageCount}) =>
      OnboardingState(currentPage: 0, pageCount: pageCount);

  /// Index of the page currently shown by the `PageView`.
  final int currentPage;

  /// Total number of onboarding pages.
  final int pageCount;

  /// Whether [currentPage] is the final page — the CTA reads
  /// "Get Started" instead of "Next", and "Skip" is hidden.
  bool get isLastPage => currentPage == pageCount - 1;

  /// Whether [currentPage] is the first page.
  bool get isFirstPage => currentPage == 0;

  OnboardingState copyWith({int? currentPage, int? pageCount}) =>
      OnboardingState(
        currentPage: currentPage ?? this.currentPage,
        pageCount: pageCount ?? this.pageCount,
      );

  @override
  List<Object?> get props => [currentPage, pageCount];
}
