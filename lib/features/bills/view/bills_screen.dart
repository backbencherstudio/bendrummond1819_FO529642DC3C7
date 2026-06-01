import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/color_manger.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/style_manager.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/route/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BillsScreen extends StatefulWidget {
  const BillsScreen({super.key});

  @override
  State<BillsScreen> createState() => _BillsScreenState();
}

class _BillsScreenState extends State<BillsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0.r, vertical: 32.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header: Bills
              Text(
                'Bills',
                style: getSemiBoldStyle22(
                  color: ColorManager.textPrimary,
                  fontSize: 32,
                ),
              ),

              SizedBox(height: 24.h),

              // Sub-header Row: Total per month + Add Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$1,100/month',
                    style: getRegularStyle16_400(color: ColorManager.brown400),
                  ),
                  // Small circular plus button
                  InkWell(
                    onTap: () =>
                        Navigator.pushNamed(context, RoutesName.addBillScreen),
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

              // Bills List
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    _buildBillCard("Car payment", "Monthly", "\$500"),
                    SizedBox(height: 12.h),
                    _buildBillCard("Rent", "Monthly", "\$500"),
                    SizedBox(height: 12.h),
                    _buildBillCard("Rent", "Due day 4", "\$100"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper Widget for Bill Cards
  Widget _buildBillCard(String title, String subtitle, String amount) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: ColorManager.secondaryBackGround,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: ColorManager.borderE0D9D1, width: 2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: getMediumStyle18(color: ColorManager.brown500),
                ),
                SizedBox(height: 12.h),
                Text(
                  subtitle,
                  style: getRegularStyle16_400(
                    color: ColorManager.grayBlack400,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Text(
            amount,
            style: getMediumStyle18(color: ColorManager.textPrimary),
          ),
        ],
      ),
    );
  }
}
