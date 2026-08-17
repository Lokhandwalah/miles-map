import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/views/auth_view.dart';
import '../../features/onboarding/presentation/views/onboarding_view.dart';
import '../../features/splash/presentation/views/splash_view.dart';

abstract final class AppRoutes {
  static const splash = '/';
  static const onboarding = '/onboarding';
  static const auth = '/auth';
}

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.splash,
  routes: [
    GoRoute(
      path: AppRoutes.splash,
      name: 'splash',
      builder: (context, state) => const SplashView(),
    ),
    GoRoute(
      path: AppRoutes.onboarding,
      name: 'onboarding',
      builder: (context, state) => OnboardingView(
        onOnboardingComplete: () => context.go(AppRoutes.auth),
      ),
    ),
    GoRoute(
      path: AppRoutes.auth,
      name: 'auth',
      // TODO(app-router): wire these to the real OTP-verification and
      // post-auth (home/landing) destinations once those screens exist —
      // the Figma file only has "Auth/Continue" (node 86:38) designed so
      // far. Left as no-op placeholders so the route stays buildable.
      builder: (context, state) =>
          AuthView(onOtpSent: (phoneNumber) {}, onSignedIn: (user) {}),
    ),
  ],
);
