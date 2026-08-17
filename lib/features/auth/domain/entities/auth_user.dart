import 'package:equatable/equatable.dart';

/// A signed-in (or guest) MilesMap user.
///
/// NOTE: This shape is intentionally minimal — scoped to exactly what the
/// "Auth/Continue" screen (Figma node 86:38) needs to hand back after a
/// Google sign-in or guest continue. The backend's real user schema
/// (profile fields, linked loyalty accounts, etc.) hasn't been confirmed
/// anywhere in the app yet — flag to the db-manager agent to check the
/// actual schema before extending or persisting this entity.
class AuthUser extends Equatable {
  const AuthUser({
    required this.id,
    required this.isGuest,
    this.phoneNumber,
    this.displayName,
    this.email,
    this.photoUrl,
  });

  /// Stable identifier for the user (or a locally-generated id for guests).
  final String id;

  /// Whether this user continued without creating an account.
  final bool isGuest;

  final String? phoneNumber;
  final String? displayName;
  final String? email;
  final String? photoUrl;

  @override
  List<Object?> get props => [
    id,
    isGuest,
    phoneNumber,
    displayName,
    email,
    photoUrl,
  ];
}
