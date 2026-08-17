import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'api_config.dart';

/// Single seam for constructing the app's [Dio] client, so every feature's
/// remote datasource shares the same base URL, timeouts, and interceptors
/// instead of building its own [Dio] instance ad hoc.
///
/// This is intentionally minimal — scaffolded for the auth feature's
/// "Send OTP" call, not a full-blown network layer (no auth-token
/// interceptor, retry policy, or error-mapping interceptor yet). Extend it
/// here as more features need real network calls, rather than duplicating
/// `Dio()` construction elsewhere.
Dio createDioClient() {
  final dio = Dio(
    BaseOptions(
      baseUrl: ApiConfig.baseUrl,
      connectTimeout: ApiConfig.connectTimeout,
      receiveTimeout: ApiConfig.receiveTimeout,
    ),
  );

  if (kDebugMode) {
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
  }

  return dio;
}
