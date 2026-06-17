import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/color_manger.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/style_manager.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/route/routes_name.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/provider/setup_data_api_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GoalsScreen extends ConsumerStatefulWidget {
  const GoalsScreen({super.key});

  @override
  ConsumerState<GoalsScreen> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends ConsumerState<GoalsScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(setupApiDataProvider.notifier).fetchData());
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(setupApiDataProvider);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 32.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Goals',
                style: getSemiBoldStyle22(
                  color: ColorManager.textPrimary,
                  fontSize: 32.sp,
                ),
              ),

              SizedBox(height: 24.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Your future goals',
                    style: getRegularStyle16_400(color: ColorManager.brown400),
                  ),
                  InkWell(
                    onTap: () =>
                        Navigator.pushNamed(context, RoutesName.addGoalScreen),
                    child: Container(
                      padding: EdgeInsets.all(6.r),
                      decoration: BoxDecoration(
                        color: ColorManager.backgroundCard,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.add,
                        color: ColorManager.primaryButton,
                        size: 20.sp,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 16.h),

              if (state.isLoading)
                Center(
                  child: CircularProgressIndicator(
                    color: ColorManager.textPrimary,
                  ),
                )
              else if (state.data == null || state.data!.savingsGoals.isEmpty)
                Padding(
                  padding: EdgeInsets.only(top: 40.h),
                  child: Center(
                    child: Text(
                      "No goals yet",
                      style: getRegularStyle16_400(
                        color: ColorManager.brown400,
                      ),
                    ),
                  ),
                )
              else
                ...state.data!.savingsGoals.map(
                  (g) => Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: _buildGoalCard(
                      g.goalName,
                      "\$${g.contribution.toStringAsFixed(0)}/${g.frequency.toLowerCase()}",
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGoalCard(String title, String subtitle) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: ColorManager.secondaryBackGround,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: ColorManager.borderColor1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: getRegularStyle16_400(color: ColorManager.brown400),
                ),
                SizedBox(height: 12.h),
                Text(
                  subtitle,
                  style: getRegularStyle16_400(
                    color: ColorManager.grayBlack400,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.close, color: ColorManager.primaryButton, size: 20.sp),
        ],
      ),
    );
  }
}
