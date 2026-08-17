/// Thrown by a feature's repository layer to surface a human-readable
/// failure message up to the presentation layer (a bloc catches this and
/// maps [message] straight into its error state) — features shouldn't
/// throw raw [Exception]/[DioException] past their data layer.
class AppException implements Exception {
  const AppException(this.message);

  /// User-facing description of what went wrong.
  final String message;

  @override
  String toString() => message;
}
