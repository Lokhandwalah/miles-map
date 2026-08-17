import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/exceptions.dart';
import '../../domain/usecases/continue_as_guest_usecase.dart';
import '../../domain/usecases/continue_with_google_usecase.dart';
import '../../domain/usecases/request_otp_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

/// Drives the "Auth/Continue" screen (Figma node 86:38): mobile-number
/// input/validation, "Send OTP", "Continue with Google", and
/// "Continue as Guest" — calling domain usecases only, never a repo or
/// datasource directly.
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required RequestOtpUseCase requestOtpUseCase,
    required ContinueWithGoogleUseCase continueWithGoogleUseCase,
    required ContinueAsGuestUseCase continueAsGuestUseCase,
  }) : _requestOtpUseCase = requestOtpUseCase,
       _continueWithGoogleUseCase = continueWithGoogleUseCase,
       _continueAsGuestUseCase = continueAsGuestUseCase,
       super(const AuthState()) {
    on<AuthPhoneNumberChanged>(_onPhoneNumberChanged);
    on<AuthOtpRequested>(_onOtpRequested);
    on<AuthGoogleContinueRequested>(_onGoogleContinueRequested);
    on<AuthGuestContinueRequested>(_onGuestContinueRequested);
  }

  final RequestOtpUseCase _requestOtpUseCase;
  final ContinueWithGoogleUseCase _continueWithGoogleUseCase;
  final ContinueAsGuestUseCase _continueAsGuestUseCase;

  void _onPhoneNumberChanged(
    AuthPhoneNumberChanged event,
    Emitter<AuthState> emit,
  ) {
    emit(
      state.copyWith(phoneNumber: event.phoneNumber, status: AuthStatus.idle),
    );
  }

  Future<void> _onOtpRequested(
    AuthOtpRequested event,
    Emitter<AuthState> emit,
  ) async {
    if (!state.canSubmit) return;
    emit(state.copyWith(status: AuthStatus.submitting));
    try {
      await _requestOtpUseCase(state.phoneNumber);
      emit(state.copyWith(status: AuthStatus.otpSent));
    } catch (e) {
      emit(
        state.copyWith(status: AuthStatus.failure, errorMessage: _messageOf(e)),
      );
    }
  }

  Future<void> _onGoogleContinueRequested(
    AuthGoogleContinueRequested event,
    Emitter<AuthState> emit,
  ) async {
    if (state.status == AuthStatus.submitting) return;
    emit(state.copyWith(status: AuthStatus.submitting));
    try {
      final user = await _continueWithGoogleUseCase();
      emit(state.copyWith(status: AuthStatus.signedIn, user: user));
    } catch (e) {
      emit(
        state.copyWith(status: AuthStatus.failure, errorMessage: _messageOf(e)),
      );
    }
  }

  Future<void> _onGuestContinueRequested(
    AuthGuestContinueRequested event,
    Emitter<AuthState> emit,
  ) async {
    if (state.status == AuthStatus.submitting) return;
    emit(state.copyWith(status: AuthStatus.submitting));
    try {
      final user = await _continueAsGuestUseCase();
      emit(state.copyWith(status: AuthStatus.signedIn, user: user));
    } catch (e) {
      emit(
        state.copyWith(status: AuthStatus.failure, errorMessage: _messageOf(e)),
      );
    }
  }

  String _messageOf(Object error) => error is AppException
      ? error.message
      : 'Something went wrong. Please try again.';
}
