import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/color_manger.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/style_manager.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/route/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GoalsScreen extends StatefulWidget {
  const GoalsScreen({super.key});

  @override
  State<GoalsScreen> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding:  EdgeInsets.symmetric(horizontal: 20.0,vertical: 32.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             

              // Header: Goals
              Text(
                'Goals',
                style: getSemiBoldStyle22(
                  color: ColorManager.textPrimary,
                  fontSize: 32.sp,
                ),

              ),

               SizedBox(height: 24.h),

              // Sub-header Row: "Your future goals" + Add Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Your future goals',
                    style: getRegularStyle16_400(color: ColorManager.brown400),
           
                  ),
                  // Small circular plus button
                  InkWell(
                    onTap: () =>
                        Navigator.pushNamed(context, RoutesName.addGoalScreen),
                    child: Container(
                      padding: EdgeInsets.all(6.r),
                      decoration: BoxDecoration(
                        color: ColorManager.backButtonColor,
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

              SizedBox(height: 16.h,),

              // Goals List
              _buildGoalCard("Buy a Iphone 17 Pro", "\$60/monthly"),
               SizedBox(height: 12.h),
              _buildGoalCard("Emergency fund", "\$30/monthly"),
            ],
          ),
        ),
      ),
    );
  }

  // Reusable Widget for Goal Cards
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
                    color: ColorManager.black400,
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
