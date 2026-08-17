import '../../../../core/error/exceptions.dart';
import '../../domain/entities/auth_user.dart';
import '../../domain/repos/auth_repository.dart';
import '../datasources/remote/auth_remote_datasource.dart';

/// Concrete [AuthRepository], wired to [AuthRemoteDataSource].
class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this._remoteDataSource);

  final AuthRemoteDataSource _remoteDataSource;

  @override
  Future<void> requestOtp(String phoneNumber) =>
      _remoteDataSource.requestOtp(phoneNumber);

  @override
  Future<AuthUser> continueWithGoogle() async {
    // TODO(auth): wire a real Google OAuth flow once the `google_sign_in`
    // package is approved and added — see the flutter-developer agent's
    // report for this feature. Deliberately not faking a network call
    // against `AuthRemoteDataSource` here, since there's no real ID token
    // to send without that package.
    throw const AppException('Google sign-in is not available yet.');
  }

  @override
  Future<AuthUser> continueAsGuest() async {
    return AuthUser(
      id: 'guest-${DateTime.now().microsecondsSinceEpoch}',
      isGuest: true,
    );
  }
}
