/// Base network configuration shared by every feature's remote datasource.
///
/// NOTE: [baseUrl] is a placeholder — no backend API base URL/spec has been
/// confirmed for MilesMap yet. This exists purely so [DioClient] and the
/// auth feature's remote datasource have somewhere to point; swap it for
/// the real environment-specific URL (and likely move it behind proper
/// flavor/env config) once the backend is defined.
abstract final class ApiConfig {
  static const String baseUrl = 'https://api.milesmap.app';

  static const Duration connectTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 15);
}
