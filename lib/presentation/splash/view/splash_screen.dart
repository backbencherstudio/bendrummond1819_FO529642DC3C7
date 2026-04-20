import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/color_manger.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/style_manager.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/route/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
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
      duration: const Duration(seconds: 4),
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
      if (mounted) {
        setState(() => _showColorEffect = true);

        _progressController.forward().then((_) {
          _punchEffectController.forward().then((_) async {
            await Future.delayed(const Duration(seconds: 3));
            /// *************** on Boarding screen *********************
            if (mounted) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                RoutesName.onBoardingRoute,
                (predicate) => false,
              );
            }
          });
        });
      }
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
                AnimatedBuilder(
                  animation: Listenable.merge([
                    _shimmerController,
                    _punchEffectController,
                  ]),
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, _bounceAnimation.value),
                      child: _showColorEffect
                          ? ShaderMask(
                              shaderCallback: (Rect bounds) {
                                return LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: const [
                                    Color(0xFF4A3A2F),
                                    Color(0xFFB08A70),
                                    Color(0xFF4A3A2F),
                                  ],
                                  stops: [
                                    _shimmerController.value - 0.3,
                                    _shimmerController.value,
                                    _shimmerController.value + 0.3,
                                  ],
                                ).createShader(bounds);
                              },
                              child: _buildText(Colors.white),
                            )
                          : _buildText(const Color(0xFF4A3A2F)),
                    );
                  },
                ),

                AnimatedOpacity(
                  opacity: _showColorEffect ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 600),
                  child: Column(
                    children: [
                      SizedBox(height: 25.h),
                      SizedBox(
                        width: 220.w,
                        child: AnimatedBuilder(
                          animation: _progressController,
                          builder: (context, child) {
                            return ClipRRect(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.r),
                              ),
                              child: ShaderMask(
                                shaderCallback: (Rect bounds) {
                                  return ColorManager.metallicGradient
                                      .createShader(bounds);
                                },
                                blendMode: BlendMode.srcIn,
                                child: LinearProgressIndicator(
                                  value: _progressController.value,
                                  backgroundColor: ColorManager.primary
                                      .withAlpha(30),
                                  valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                        Colors.white,
                                      ),
                                  minHeight: 5.h,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 15.h),
                      Text(
                        "Know what's safe to spend.",
                        textAlign: TextAlign.center,
                        style: getLight300Style16(color: ColorManager.gold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildText(Color color) {
    return Text(
      "STABILITY",
      style: TextStyle(
        fontSize: 42.sp,
        fontWeight: FontWeight.bold,
        letterSpacing: 10,
        color: color,
      ),
    );
  }
}
