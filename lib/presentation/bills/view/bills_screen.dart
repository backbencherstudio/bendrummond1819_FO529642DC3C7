import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/color_manger.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/style_manager.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/route/routes_name.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/provider/setup_data_api_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BillsScreen extends ConsumerStatefulWidget {
  const BillsScreen({super.key});

  @override
  ConsumerState<BillsScreen> createState() => _BillsScreenState();
}

class _BillsScreenState extends ConsumerState<BillsScreen> {
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
                    state.data != null
                        ? '\$${state.data!.financialCommitments.fold<double>(0, (sum, c) => sum + c.amount).toStringAsFixed(0)}/month'
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
                    ? Center(child: CircularProgressIndicator(color: ColorManager.textPrimary))
                    : state.data == null || state.data!.financialCommitments.isEmpty
                        ? Center(
                            child: Text(
                              "No bills yet",
                              style: getRegularStyle16_400(color: ColorManager.brown400),
                            ),
                          )
                        : ListView(
                            padding: EdgeInsets.zero,
                            children: state.data!.financialCommitments.map((c) {
                              final subtitle = c.dueDay != null ? "Due day ${c.dueDay}" : (c.frequency ?? "Monthly");
                              return Column(
                                children: [
                                  _buildBillCard(c.name, subtitle, "\$${c.amount.toStringAsFixed(0)}"),
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
