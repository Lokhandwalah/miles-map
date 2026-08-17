import '../repos/auth_repository.dart';

/// Requests an OTP be sent to a phone number, via [AuthRepository].
class RequestOtpUseCase {
  const RequestOtpUseCase(this._repository);

  final AuthRepository _repository;

  Future<void> call(String phoneNumber) => _repository.requestOtp(phoneNumber);
}
