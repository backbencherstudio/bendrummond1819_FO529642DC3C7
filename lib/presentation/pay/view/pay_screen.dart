import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/color_manger.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/widgets/custom_from_field.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PayScreen extends StatefulWidget {
  const PayScreen({super.key});

  @override
  State<PayScreen> createState() => _PayScreenState();
}

class _PayScreenState extends State<PayScreen> {
  final Color bgColor = const Color(0xFFF2EEE4);
  final Color darkBrown = const Color(0xFF433428);
  final Color mutedBrown = const Color(0xFF8C8071);
  final Color inputBg = const Color(0xFFFAF8F3);
  final String fontSerif = 'Serif';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.secondaryBackGround,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              //========= Header Section ==========
              Text(
                'Pay & Income',
                style: TextStyle(
                  fontSize: 32.sp,
                  fontFamily: fontSerif,
                  fontWeight: FontWeight.bold,
                  color: darkBrown,
                ),
              ),
              SizedBox(height: 25.h),

              // ======= Safe to spend Card =========
              Container(
                width: double.infinity.w,
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: Colors.black.withValues(alpha: 0.05),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Safe to spend',
                          style: TextStyle(color: mutedBrown, fontSize: 16.sp),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          '\$185',
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontFamily: fontSerif,
                            color: darkBrown,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Text(
                        'Updates when you save',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: mutedBrown,
                          fontFamily: fontSerif,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 25.h),

              // ========= Pay schedule section =========
              _buildLabel('Pay schedule'),
              SizedBox(height: 10.h),
              Wrap(
                spacing: 8,
                runSpacing: 10,
                children: [
                  _buildChip('Weekly', isActive: true),
                  _buildChip('Every 2 weeks'),
                  _buildChip('Monthly'),
                  _buildChip('Twice a month'),
                  _buildChip('It\'s inconsistent'),
                ],
              ),
              SizedBox(height: 25.h),

              // ======== One paycheck amount ==========
              _buildLabel('One paycheck amount'),
              SizedBox(height: 10.h),
              CustomFromField(hintText: '\$ 1400'),
              SizedBox(height: 25.h),

              // ======== Rent / mortgage ============
              _buildLabel('Rent / mortgage (monthly)'),
              SizedBox(height: 10.h),
              CustomFromField(hintText: '\$ 500'),

              SizedBox(height: 40.h),

              // ========== Save Changes Button ======
              PrimaryButton(title: 'Save changes', onTap: () {}),
              SizedBox(height: 120.h),
            ],
          ),
        ),
      ),
    );
  }

  // ======= Helper widget for Labels ========
  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(color: mutedBrown, fontSize: 16, fontFamily: fontSerif),
    );
  }

  // ===== Helper widget for Schedule Chips ======
  Widget _buildChip(String label, {bool isActive = false}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: isActive ? darkBrown : Colors.white,
        borderRadius: BorderRadius.circular(30.r),
        border: Border.all(color: isActive ? darkBrown : Colors.black12),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isActive ? Colors.white : darkBrown,
          fontSize: 16,
          fontFamily: fontSerif,
        ),
      ),
    );
  }
}
