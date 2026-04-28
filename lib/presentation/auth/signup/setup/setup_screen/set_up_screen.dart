import 'package:bendrummond1819_fo529642dc3c7/core/route/routes_name.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/widgets/outline_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/color_manger.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/style_manager.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/widgets/custom_back_button.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/widgets/primary_button.dart';
import '../widgets/set_up1_screen.dart';
import '../widgets/set_up2_screen.dart';
import '../widgets/set_up3_screen.dart';
import '../widgets/set_up4_screen.dart';
import '../widgets/set_up5_screen.dart';
import '../widgets/set_up6_screen.dart';
import '../widgets/set_up7_screen.dart';
import '../widgets/set_up8_screen.dart';
import '../viewmodel/set_up_screen_riverpod.dart';

class SetUpScreen extends ConsumerStatefulWidget {
  const SetUpScreen({super.key});

  @override
  ConsumerState<SetUpScreen> createState() => _SetUpMainViewState();
}

class _SetUpMainViewState extends ConsumerState<SetUpScreen> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    final initialPage = ref.read(setupStepProvider) - 1;
    _pageController = PageController(initialPage: initialPage);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNext() {
    if (_pageController.page! < totalSteps - 1) {
      ref.read(setupStepProvider.notifier).nextStep();
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {}
  }

  void _onBack() {
    if (_pageController.page! > 0) {
      ref.read(setupStepProvider.notifier).previousStep();
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentStep = ref.watch(setupStepProvider);

    return Scaffold(
      backgroundColor: ColorManager.secondary,
      body: SafeArea(
        child: Column(
          children: [
            /// ========== Progress Bar ============
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Row(
                children: [
                  customBackButton(
                    context,
                    onPressed: _onBack,
                    color: ColorManager.backGroundCard,
                    borderColor: ColorManager.borderColor3,
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "$currentStep of $totalSteps",
                          style: getLightStyle14_400(
                            color: ColorManager.brown400,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(99.r),
                            border: Border.all(
                              color: ColorManager.backgroundPressed100,
                              width: 1,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(99.r),
                            child: LinearProgressIndicator(
                              minHeight: 6.h,
                              backgroundColor: ColorManager.backgroundSecondary,
                              borderRadius: BorderRadius.circular(99.r),
                              value: currentStep / totalSteps,
                              valueColor: AlwaysStoppedAnimation(
                                ColorManager.textPrimary,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // ========== PageView Content ============
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  SetUp1Screen(),
                  SetUp2Screen(),
                  SetUp3Screen(),
                  SetUp4Screen(),
                  SetUp5Screen(),
                  SetUp6Screen(),
                  SetUp7Screen(),
                  SetUp8Screen(),
                ],
              ),
            ),

            // ========== Fixed Bottom Button ============
            Padding(
              padding: EdgeInsets.all(24.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (currentStep < 4) ...[
                    PrimaryButton(title: "Continue", onTap: _onNext),
                  ],

                  if (currentStep == 4 ||
                      currentStep == 5 ||
                      currentStep == 6 ||
                      currentStep == 7) ...[
                    PrimaryButton(title: "Continue", onTap: _onNext),
                    SizedBox(height: 12.h),
                    CustomOutlinedButton(
                      title: "No rent right now",
                      onTap: _onNext,
                    ),
                  ],
                  if (currentStep == 8) ...[
                    PrimaryButton(
                      title: "Continue",
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          RoutesName.chooseYourPlainScreen,
                        );
                      },
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
