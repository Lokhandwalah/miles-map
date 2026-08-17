import 'package:dio/dio.dart';

import '../../../../../core/error/exceptions.dart';

/// Talks to the (placeholder) auth API. No business logic here — just the
/// HTTP call and mapping a failure into an [AppException].
///
/// NOTE: only `requestOtp` is implemented. Google sign-in isn't — a real
/// implementation needs an ID token from the `google_sign_in` package,
/// which isn't in `pubspec.yaml` yet (flagged separately, not added without
/// confirmation) — see `data/repos/auth_repository_impl.dart`.
abstract class AuthRemoteDataSource {
  Future<void> requestOtp(String phoneNumber);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  const AuthRemoteDataSourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<void> requestOtp(String phoneNumber) async {
    try {
      // NOTE: `/auth/otp/request` and the `phone_number` field name are
      // placeholders — no backend endpoint spec exists for auth yet.
      await _dio.post('/auth/otp/request', data: {'phone_number': phoneNumber});
    } on DioException catch (e) {
      throw AppException(
        e.message ?? 'Failed to send the OTP. Please try again.',
      );
    }
  }
}
