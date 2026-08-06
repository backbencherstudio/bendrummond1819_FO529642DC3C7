import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/color_manger.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/splash/viewmodel/splash_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/splash_logo.dart';
import '../widgets/splash_progress_section.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _progressController;
  late AnimationController _shimmerController;
  late AnimationController _punchEffectController;
  late Animation<double> _bounceAnimation;

  bool _moveUp = false;
  bool _showColorEffect = false;

  @override
  void initState() {
    super.initState();

    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat();

    _punchEffectController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _bounceAnimation =
        TweenSequence<double>([
          TweenSequenceItem(tween: Tween(begin: 0.0, end: 15.0), weight: 50),
          TweenSequenceItem(tween: Tween(begin: 15.0, end: 0.0), weight: 50),
        ]).animate(
          CurvedAnimation(
            parent: _punchEffectController,
            curve: Curves.easeInOut,
          ),
        );

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() => _moveUp = true);
      }
    });

    Future.delayed(const Duration(milliseconds: 2000), () {
      if (!mounted) return;
      setState(() => _showColorEffect = true);
      _progressController.forward().then((_) async {
        await _punchEffectController.forward();
        await Future.delayed(const Duration(seconds: 3));
        if (!mounted) return;
        final route = await ref
            .read(splashProvider.notifier)
            .decideInitialRoute();
        if (mounted) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            route,
            (predicate) => false,
          );
        }
      });
    });
  }

  @override
  void dispose() {
    _progressController.dispose();
    _shimmerController.dispose();
    _punchEffectController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.secondary,
      body: SizedBox(
        width: double.infinity,
        child: Center(
          child: AnimatedPadding(
            duration: const Duration(milliseconds: 1200),
            curve: Curves.easeOutCubic,
            padding: EdgeInsets.only(bottom: _moveUp ? 100.h : 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SplashLogo(
                  showColorEffect: _showColorEffect,
                  shimmerController: _shimmerController,
                  punchEffectController: _punchEffectController,
                  bounceAnimation: _bounceAnimation,
                ),
                SplashProgressSection(
                  showColorEffect: _showColorEffect,
                  progressController: _progressController,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
