import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/color_manger.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/icon_manager.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/style_manager.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/route/routes_name.dart';
import 'package:bendrummond1819_fo529642dc3c7/data/models/setup_models.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/provider/bills_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BillsScreen extends ConsumerStatefulWidget {
  const BillsScreen({super.key});

  @override
  ConsumerState<BillsScreen> createState() => _BillsScreenState();
}

class _BillsScreenState extends ConsumerState<BillsScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(billsProvider.notifier).fetchBills());
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(billsProvider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0.r, vertical: 32.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Bills',
                style: getSemiBoldStyle22(
                  color: ColorManager.textPrimary,
                  fontSize: 32,
                ),
              ),

              SizedBox(height: 24.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    state.bills.isNotEmpty
                        ? '\$${state.bills.fold<double>(0, (sum, c) => sum + c.amount).toStringAsFixed(0)}/month'
                        : '\$0/month',
                    style: getRegularStyle16_400(color: ColorManager.brown400),
                  ),
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

              Expanded(
                child: state.isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: ColorManager.textPrimary,
                        ),
                      )
                    : state.error != null
                    ? Center(
                        child: Text(
                          "Error loading bills",
                          style: getRegularStyle16_400(
                            color: ColorManager.errorColor,
                          ),
                        ),
                      )
                    : state.bills.isEmpty
                    ? Center(
                        child: Text(
                          "No bills yet",
                          style: getRegularStyle16_400(
                            color: ColorManager.brown400,
                          ),
                        ),
                      )
                    : ListView(
                        padding: EdgeInsets.zero,
                        children: state.bills.map((c) {
                          final subtitle = c.dueDay != null
                              ? "Due day ${c.dueDay}"
                              : (c.frequency ?? "Monthly");
                          return Column(
                            children: [
                              _buildBillCard(c, subtitle),
                              SizedBox(height: 12.h),
                            ],
                          );
                        }).toList(),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBillCard(FinancialCommitmentData bill, String subtitle) {
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
                  bill.name,
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
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "\$${bill.amount.toStringAsFixed(0)}",
                style: getMediumStyle18(color: ColorManager.textPrimary),
              ),
              SizedBox(width: 8.w),
              InkWell(
                onTap: () => Navigator.pushNamed(
                  context,
                  RoutesName.editBillScreen,
                  arguments: bill,
                ),
                child: Container(
                  padding: EdgeInsets.all(8.r),
                  decoration: BoxDecoration(
                    color: ColorManager.backgroundCard,
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(
                    IconManager.editIcon,
                    width: 16.sp,
                    height: 16.sp,
                    colorFilter: ColorFilter.mode(
                      ColorManager.primaryButton,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
