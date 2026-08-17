import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/primary_button.dart';
import '../../../../core/services/service_locator.dart';
import '../../../../core/theme/design_system.dart';
import '../../domain/entities/auth_user.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../widgets/google_sign_in_button.dart';
import '../widgets/or_continue_with_divider.dart';
import '../widgets/phone_number_field.dart';

/// "Auth/Continue" screen — mobile-number entry, Google sign-in, and guest
/// continue.
///
/// Design reference: Figma "Auth/Continue" frame, node 86:38
/// (https://www.figma.com/design/wL6jGjyB5BVWt6bZ9J6aBt/Miles-Map?node-id=86-38).
///
/// NOTE ON LAYOUT: Figma's root frame pads content by a fixed 72px
/// top / 32px bottom / 24px horizontal, with a flexible spacer (Figma
/// "Frame", node 86:61) pinning the footer copy to the bottom of a fixed
/// 812px-tall viewport. This view reproduces that with an `Expanded`
/// spacer, but — unlike the static Figma frame — wraps everything in a
/// scroll view sized to at least fill the viewport (`ConstrainedBox` +
/// `IntrinsicHeight`) so the screen degrades to scrollable instead of
/// overflowing on shorter devices or when the keyboard opens over the
/// mobile-number field.
///
/// NOTE ON NEXT SCREENS: only "Auth/Continue" exists in the Figma file —
/// there's no OTP-verification screen and no post-auth landing screen
/// designed yet. [onOtpSent] and [onSignedIn] are the integration points
/// for whichever screens end up covering those; this view never navigates
/// on its own, mirroring `OnboardingView.onOnboardingComplete`.
class AuthView extends StatefulWidget {
  const AuthView({
    super.key,
    required this.onOtpSent,
    required this.onSignedIn,
  });

  /// Called after an OTP is successfully requested, with the phone number
  /// it was sent to. The caller decides where to navigate next (once an
  /// OTP-verification screen exists).
  final ValueChanged<String> onOtpSent;

  /// Called after a successful Google sign-in or guest continue.
  final ValueChanged<AuthUser> onSignedIn;

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  late final TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AuthBloc>(),
      child: BlocConsumer<AuthBloc, AuthState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          switch (state.status) {
            case AuthStatus.otpSent:
              widget.onOtpSent(state.phoneNumber);
            case AuthStatus.signedIn:
              if (state.user != null) widget.onSignedIn(state.user!);
            case AuthStatus.failure:
              if (state.errorMessage != null) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
              }
            case AuthStatus.idle:
            case AuthStatus.submitting:
              break;
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.black,
            body: SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.xl,
                      48,
                      AppSpacing.xl,
                      AppSpacing.xxl,
                    ),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight - 48 - AppSpacing.xxl,
                      ),
                      child: IntrinsicHeight(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          spacing: AppSpacing.xl,
                          children: [
                            const _WelcomeHeader(),
                            PhoneNumberField(
                              controller: _phoneController,
                              onChanged: (value) => context
                                  .read<AuthBloc>()
                                  .add(AuthPhoneNumberChanged(value)),
                            ),
                            PrimaryButton(
                              label: 'Send OTP',
                              onPressed: state.canSubmit
                                  ? () => context.read<AuthBloc>().add(
                                      const AuthOtpRequested(),
                                    )
                                  : null,
                            ),
                            const OrContinueWithDivider(),
                            GoogleSignInButton(
                              onPressed: state.status == AuthStatus.submitting
                                  ? null
                                  : () => context.read<AuthBloc>().add(
                                      const AuthGoogleContinueRequested(),
                                    ),
                            ),
                            _GuestContinueLink(
                              onTap: state.status == AuthStatus.submitting
                                  ? null
                                  : () => context.read<AuthBloc>().add(
                                      const AuthGuestContinueRequested(),
                                    ),
                            ),
                            const Expanded(child: SizedBox()),
                            const _TermsFooter(),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

/// "Welcome to MilesMap" heading + supporting copy.
///
/// Design reference: Figma "Frame", node 86:42.
class _WelcomeHeader extends StatelessWidget {
  const _WelcomeHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppSpacing.sm,
      children: [
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: AppTypography.headlineMedium
                .copyWith(fontWeight: FontWeight.w700)
                .inSora,
            children: [
              TextSpan(text: 'Welcome to '),
              TextSpan(
                text: 'Miles',
                style: TextStyle(color: AppColors.primary),
              ),
              TextSpan(
                text: 'Map',
                style: TextStyle(color: AppColors.secondary),
              ),
            ],
          ),
        ),
        Text(
          'Enter your number to sign in or create an account.',
          textAlign: TextAlign.center,
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}

/// "Continue as Guest" tap target.
///
/// Design reference: Figma text node 86:60.
class _GuestContinueLink extends StatelessWidget {
  const _GuestContinueLink({required this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Text(
          'Continue as Guest',
          style: AppTypography.bodyMedium.copyWith(color: AppColors.primary),
        ),
      ),
    );
  }
}

/// Terms & Privacy Policy footer copy, pinned to the bottom of the screen.
///
/// Design reference: Figma text node 93:28.
///
/// NOTE: Figma spec is 12px/20, DM Sans Regular — `bodySmall` (12/16,
/// weight 400) is the closest existing scale entry (size and weight match
/// exactly; only the 16-vs-20 line height differs) — flag to the
/// app-designer agent if this line-height variant is worth its own token.
///
/// NOTE: "Terms" and "Privacy Policy" render as plain text, not tappable
/// links — there's no terms/privacy URL or route defined anywhere in the
/// app yet to link them to.
class _TermsFooter extends StatelessWidget {
  const _TermsFooter();

  @override
  Widget build(BuildContext context) {
    return Text(
      'By continuing, you agree to our Terms & Privacy Policy.',
      textAlign: TextAlign.center,
      style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary),
    );
  }
}

@Preview(name: 'Auth View')
Widget authViewPreview() => AuthView(onOtpSent: (_) {}, onSignedIn: (_) {});
