import '../entities/auth_user.dart';

/// Contract for the auth feature's data operations. Domain and
/// presentation code (usecases, [AuthBloc]) depend on this abstraction,
/// never on `data/repos/auth_repository_impl.dart` directly.
abstract class AuthRepository {
  /// Requests an OTP be sent to [phoneNumber].
  ///
  /// Throws an [AppException] (see `core/error/exceptions.dart`) on
  /// failure — callers should catch and surface `.message`.
  Future<void> requestOtp(String phoneNumber);

  /// Signs the user in with their Google account, returning the resulting
  /// [AuthUser].
  ///
  /// NOTE: not wired to a real Google OAuth flow yet — see
  /// `data/repos/auth_repository_impl.dart` for why.
  Future<AuthUser> continueWithGoogle();

  /// Continues into the app without creating an account.
  Future<AuthUser> continueAsGuest();
}
