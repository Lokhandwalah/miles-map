import 'package:equatable/equatable.dart';

/// Base class for events consumed by [AuthBloc].
sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

/// Fired on every keystroke in the mobile number field.
class AuthPhoneNumberChanged extends AuthEvent {
  const AuthPhoneNumberChanged(this.phoneNumber);

  final String phoneNumber;

  @override
  List<Object?> get props => [phoneNumber];
}

/// Fired when "Send OTP" is tapped.
class AuthOtpRequested extends AuthEvent {
  const AuthOtpRequested();
}

/// Fired when "Continue with Google" is tapped.
class AuthGoogleContinueRequested extends AuthEvent {
  const AuthGoogleContinueRequested();
}

/// Fired when "Continue as Guest" is tapped.
class AuthGuestContinueRequested extends AuthEvent {
  const AuthGuestContinueRequested();
}
