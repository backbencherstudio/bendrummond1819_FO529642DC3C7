import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/color_manger.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/icon_manager.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/balances/view/balances_screen.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/bills/view/bills_screen.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/goals/view/goals_screen.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/home/view/home_screen.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/pay/view/pay_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../viewmodel/bottom_nav_bar_viewmodel.dart';
import 'nav_item.dart';

class BottomNavBarScreen extends ConsumerStatefulWidget {
  const BottomNavBarScreen({super.key});

  @override
  ConsumerState<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends ConsumerState<BottomNavBarScreen> {
  final List<Widget> _screenList = [
    const PayScreen(),
    const BillsScreen(),
    const HomeScreen(),
    const BalancesScreen(),
    const GoalsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final selectedIndex = ref.watch(bottomNavBarProvider);

    return Scaffold(
      body: _screenList[selectedIndex],
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(bottom: 20.h, right: 16.w, left: 16.w),
        padding: EdgeInsets.symmetric(vertical: 6.r, horizontal: 10.r),
        decoration: BoxDecoration(
          color: Colors.white,
          // color: ColorManager
          //     .bottomNavBackGround, // Slightly darker beige/cream bar
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            NavItem(
              index: 0,
              icon: IconManager.payIcon,
              label: "Pay",
              selectedIndex: selectedIndex,
            ),
            NavItem(
              index: 1,
              icon: IconManager.billsIcon,
              label: "Bills",
              selectedIndex: selectedIndex,
            ),
            NavItem(
              index: 2,
              icon: IconManager.homeIcon,
              label: "Home",
              selectedIndex: selectedIndex,
            ),
            NavItem(
              index: 3,
              icon: IconManager.balanceIcon,
              label: "Balances",
              selectedIndex: selectedIndex,
            ),
            NavItem(
              index: 4,
              icon: IconManager.goalsIcon,
              label: "Goals",
              selectedIndex: selectedIndex,
            ),
          ],
        ),
      ),
    );
  }
}
