import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/color_manger.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/style_manager.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/splash/viewmodel/splash_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  Future<void> _navigateToNext() async {
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;
    final route = await ref.read(splashProvider.notifier).decideInitialRoute();
    if (mounted) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        route,
        (predicate) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.secondary,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "STABILITY",
              style: getBoldStyle32(
                color: ColorManager.brown,
              ).copyWith(fontFamily: 'Lora', letterSpacing: 8, fontSize: 36.sp),
            ),
            SizedBox(height: 12.h),
            TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0.0, end: 1.0),
              duration: const Duration(seconds: 3),
              builder: (context, value, child) {
                return Container(
                  width: 250.w,
                  height: 12.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.r),
                    border: Border.all(
                      color: ColorManager.brown.withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  child: Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      // The filled path with metallic gradient
                      Container(
                        width: 14.w + ((250.w - 14.w - 4.w) * value),
                        height: 8.h,
                        margin: EdgeInsets.only(left: 2.w),
                        decoration: BoxDecoration(
                          gradient: ColorManager.metallicGradient,
                          borderRadius: BorderRadius.circular(100.r),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            SizedBox(height: 20.h),
            Text(
              "Know what's safe to spend.",
              style: getRegularStyle16_400(
                color: ColorManager.brown,
              ).copyWith(fontFamily: 'Lora', fontSize: 16.sp),
            ),
          ],
        ),
      ),
    );
  }
}
