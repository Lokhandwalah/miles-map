import 'package:flutter_bloc/flutter_bloc.dart';

import 'onboarding_event.dart';
import 'onboarding_state.dart';

/// Presentation-only navigation state for the onboarding page flow.
///
/// {@macro onboarding_bloc_scope}
class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc({required int pageCount})
    : super(OnboardingState.initial(pageCount: pageCount)) {
    on<OnboardingNextPageRequested>(_onNextPageRequested);
    on<OnboardingPreviousPageRequested>(_onPreviousPageRequested);
    on<OnboardingSkipRequested>(_onSkipRequested);
    on<OnboardingPageChanged>(_onPageChanged);
  }

  void _onNextPageRequested(
    OnboardingNextPageRequested event,
    Emitter<OnboardingState> emit,
  ) {
    if (state.isLastPage) return;
    emit(state.copyWith(currentPage: state.currentPage + 1));
  }

  void _onPreviousPageRequested(
    OnboardingPreviousPageRequested event,
    Emitter<OnboardingState> emit,
  ) {
    if (state.isFirstPage) return;
    emit(state.copyWith(currentPage: state.currentPage - 1));
  }

  void _onSkipRequested(
    OnboardingSkipRequested event,
    Emitter<OnboardingState> emit,
  ) {
    emit(state.copyWith(currentPage: state.pageCount - 1));
  }

  void _onPageChanged(
    OnboardingPageChanged event,
    Emitter<OnboardingState> emit,
  ) {
    if (event.page < 0 || event.page >= state.pageCount) return;
    emit(state.copyWith(currentPage: event.page));
  }
}
