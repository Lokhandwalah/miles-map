import '../entities/auth_user.dart';
import '../repos/auth_repository.dart';

/// Continues into the app as a guest, via [AuthRepository].
class ContinueAsGuestUseCase {
  const ContinueAsGuestUseCase(this._repository);

  final AuthRepository _repository;

  Future<AuthUser> call() => _repository.continueAsGuest();
}
