import '../../domain/entities/auth_user.dart';

/// Maps the raw JSON shape returned by the (placeholder) auth API into an
/// [AuthUser].
///
/// NOTE: the field names below (`id`/`phone_number`/`display_name`/`email`/
/// `photo_url`/`is_guest`) are guessed, snake_case-by-convention names —
/// there's no confirmed backend API response spec for auth yet. Flag to the
/// db-manager agent to check the real schema before relying on this.
class AuthUserModel {
  const AuthUserModel({
    required this.id,
    required this.isGuest,
    this.phoneNumber,
    this.displayName,
    this.email,
    this.photoUrl,
  });

  factory AuthUserModel.fromJson(Map<String, dynamic> json) => AuthUserModel(
    id: json['id'] as String,
    isGuest: json['is_guest'] as bool? ?? false,
    phoneNumber: json['phone_number'] as String?,
    displayName: json['display_name'] as String?,
    email: json['email'] as String?,
    photoUrl: json['photo_url'] as String?,
  );

  final String id;
  final bool isGuest;
  final String? phoneNumber;
  final String? displayName;
  final String? email;
  final String? photoUrl;

  AuthUser toEntity() => AuthUser(
    id: id,
    isGuest: isGuest,
    phoneNumber: phoneNumber,
    displayName: displayName,
    email: email,
    photoUrl: photoUrl,
  );
}
