/// Shared input-validation helpers. No Flutter/widget imports here — if a
/// check needs to render something, it belongs in `common/` or a feature's
/// `presentation/widgets/` instead.
abstract final class Validators {
  static final _digitsOnly = RegExp(r'^\d+$');

  /// Whether [phoneNumber] looks like a plausible mobile number: digits
  /// only (ignoring a leading `+`), 10-15 digits long.
  ///
  /// NOTE: intentionally loose — there's no confirmed country-code/format
  /// spec for MilesMap's phone auth yet, so this only guards against
  /// obviously-invalid input rather than fully validating a real number.
  static bool isValidPhoneNumber(String phoneNumber) {
    final digits = phoneNumber.startsWith('+')
        ? phoneNumber.substring(1)
        : phoneNumber;
    if (digits.length < 10 || digits.length > 15) return false;
    return _digitsOnly.hasMatch(digits);
  }
}
