import 'package:equatable/equatable.dart';

import '../../../../core/utils/validators.dart';
import '../../domain/entities/auth_user.dart';

/// Lifecycle of the current auth action (OTP request, Google, or guest).
enum AuthStatus {
  /// Nothing in flight; no result to show yet.
  idle,

  /// A request is in flight — buttons should show a loading/disabled state.
  submitting,

  /// `requestOtp` succeeded. There's no OTP-verification screen in the
  /// Figma file yet (only "Auth/Continue" was designed), so this is a
  /// terminal state for now — see the `AuthOtpSent` TODO in `auth_view.dart`
  /// for where that next screen will plug in once it's designed.
  otpSent,

  /// Google or guest continue succeeded; [AuthState.user] is populated.
  signedIn,

  /// The last action failed; [AuthState.errorMessage] describes why.
  failure,
}

/// State for [AuthBloc] — the "Auth/Continue" screen (Figma node 86:38).
class AuthState extends Equatable {
  const AuthState({
    this.phoneNumber = '',
    this.status = AuthStatus.idle,
    this.errorMessage,
    this.user,
  });

  final String phoneNumber;
  final AuthStatus status;
  final String? errorMessage;
  final AuthUser? user;

  bool get isPhoneNumberValid => Validators.isValidPhoneNumber(phoneNumber);

  /// Whether "Send OTP" should be enabled.
  bool get canSubmit => isPhoneNumberValid && status != AuthStatus.submitting;

  AuthState copyWith({
    String? phoneNumber,
    AuthStatus? status,
    String? errorMessage,
    AuthUser? user,
  }) => AuthState(
    phoneNumber: phoneNumber ?? this.phoneNumber,
    status: status ?? this.status,
    errorMessage: errorMessage,
    user: user ?? this.user,
  );

  @override
  List<Object?> get props => [phoneNumber, status, errorMessage, user];
}
