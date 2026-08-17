import '../entities/auth_user.dart';
import '../repos/auth_repository.dart';

/// Signs the user in with Google, via [AuthRepository].
class ContinueWithGoogleUseCase {
  const ContinueWithGoogleUseCase(this._repository);

  final AuthRepository _repository;

  Future<AuthUser> call() => _repository.continueWithGoogle();
}
