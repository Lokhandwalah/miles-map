import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/design_system.dart';
import '../../../../gen/assets.gen.dart';

/// Design reference: Figma "splash-screen" frame, node 126:20
/// (https://www.figma.com/design/wL6jGjyB5BVWt6bZ9J6aBt/Miles-Map?node-id=126-20).
///
/// The Figma frame is an iPhone mockup and includes two pieces of OS chrome
/// that are deliberately NOT reproduced here since the real device already
/// renders them: the "iOS_Status_Bar" row (node 126:21, the 9:41/signal/
/// wifi/battery row) and the "Home_Indicator" bar (node 126:37). Everything
/// else — the glowing globe icon, the "MilesMap" wordmark, the subtitle, and
/// the loading dots — is real app content and is reproduced 1:1.
///
/// The "MilesMap" wordmark (Sora ExtraBold 36/44) and subtitle (DM Sans
/// Medium 14/20) both match an existing [AppTypography] scale slot exactly
/// on size/line-height ([AppTypography.displaySmall] and
/// [AppTypography.bodyMedium] respectively) but use a heavier weight than
/// that slot's default — per this app's typography convention, weight is a
/// permitted `copyWith` override for emphasis, so no new token is needed.
class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _redirectTimer;

  @override
  void initState() {
    super.initState();
    _redirectTimer = Timer(const Duration(seconds: 2), () {
      if (mounted) context.go(AppRoutes.onboarding);
    });
  }

  @override
  void dispose() {
    _redirectTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          const Positioned.fill(child: _BackgroundGlow()),
          SafeArea(
            child: Container(
              alignment: Alignment.center,
              // padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
              child: Column(
                children: [
                  const SizedBox(height: AppSpacing.lg),
                  const Expanded(child: _BrandContainer()),
                  const SizedBox(height: AppSpacing.xl),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsGeometry.only(
              bottom: MediaQuery.of(context).viewPadding.bottom + 10,
            ),
            child: const _Loader(),
          ),
        ],
      ),
    );
  }
}

/// Subtle teal radial glow centered on the screen, behind the brand content.
/// Figma: a radial gradient fill on the outer "splash-screen" frame, fading
/// from `rgba(0,201,167,0.12)` at the center to transparent by 70% radius.
class _BackgroundGlow extends StatelessWidget {
  const _BackgroundGlow();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          radius: 0.9,
          colors: [
            AppColors.primary.withValues(alpha: .16),
            AppColors.primary.withValues(alpha: 0),
          ],
          stops: const [0, 0.7],
        ),
      ),
    );
  }
}

/// Figma "Brand_Container" (node 126:27): glowing globe icon + wordmark +
/// subtitle, stacked with a 32px gap.
class _BrandContainer extends StatelessWidget {
  const _BrandContainer();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const _GlobeGlowIcon(),
        const SizedBox(height: AppSpacing.xxl),
        _buildWordmark(),
        const SizedBox(height: AppSpacing.md),
        Text(
          'Maximize Every Point You Earn',
          textAlign: TextAlign.center,
          style: AppTypography.bodyMedium.copyWith(fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _buildWordmark() {
    final wordmarkStyle = AppTypography.displaySmall.inSora.copyWith(
      fontWeight: FontWeight.w800,
      height: 44 / 36,
    );
    return RichText(
      text: TextSpan(
        style: wordmarkStyle,
        children: [
          TextSpan(
            text: 'Miles',
            style: TextStyle(color: AppColors.primary),
          ),
          TextSpan(
            text: 'Map',
            style: TextStyle(color: AppColors.tertiary),
          ),
        ],
      ),
    );
  }
}

/// Figma "Globe_Glow_Wrapper" (node 126:28): a 160x160 rounded surface with
/// a translucent teal border and glow shadow, holding the 120x120
/// "Globe_3D_Icon" (node 126:29) image.
class _GlobeGlowIcon extends StatelessWidget {
  const _GlobeGlowIcon();

  static const _wrapperSize = 160.0;
  static const _iconSize = 120.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _wrapperSize,
      height: _wrapperSize,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.surfaceElevated.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(40),
        border: Border.all(
          width: 1.5,
          color: AppColors.primary.withValues(alpha: 0.15),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.12),
            blurRadius: 40,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Assets.images.icons.appIcon.image(
          width: _iconSize,
          height: _iconSize,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

/// Figma "Splash_Footer" (node 126:33): the loading dots, at 40% opacity.
/// The "Home_Indicator" bar beneath it in Figma is OS chrome and is
/// intentionally omitted (see file-level doc comment).
class _Loader extends StatefulWidget {
  const _Loader();

  @override
  State<_Loader> createState() => _LoaderState();
}

class _LoaderState extends State<_Loader> with SingleTickerProviderStateMixin {
  static const List<double> _dotOpacities = [0.8, 0.4, 0.4];
  static const List<double> _dotSizes = [10, 6 , 6];
  static const _stepDuration = Duration(milliseconds: 300);

  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: _stepDuration * _dotOpacities.length,
  );

  @override
  void initState() {
    super.initState();
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final step =
            (_controller.value * _dotOpacities.length).floor() %
            _dotOpacities.length;
        return Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 6,
          children: [
            for (var i = 0; i < _dotOpacities.length; i++)
              AnimatedContainer(
                width: _dotSizes[(i - step) % _dotOpacities.length],
                height: _dotSizes[(i - step) % _dotOpacities.length],
                duration: Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary.withValues(
                    alpha: _dotOpacities[(i - step) % _dotOpacities.length],
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

@Preview(name: 'Splash View')
Widget splashViewPreview() => const SplashView();
