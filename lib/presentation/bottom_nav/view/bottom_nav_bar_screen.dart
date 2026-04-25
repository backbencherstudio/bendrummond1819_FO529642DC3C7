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
import 'package:flutter_svg/svg.dart';
import '../viewmodel/bottom_nav_bar_viewmodel.dart';

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
      backgroundColor: const Color.fromARGB(255, 242, 228, 230),
      body: Stack(
        children: [
          _screenList[selectedIndex],
          Positioned(
            bottom: 1,
            left: 20,
            right: 20,
            child: SafeArea(
              child: Container(
                padding:  EdgeInsets.symmetric(vertical: 6.r, horizontal: 10.r),
                decoration: BoxDecoration(
                  color: ColorManager
                      .bottomNavBackGround, // Slightly darker beige/cream bar
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
                    _buildNavItem(0, IconManager.payIcon, "Pay", selectedIndex),
                    _buildNavItem(
                      1,
                      IconManager.billsIcon,
                      "Bills",
                      selectedIndex,
                    ),
                    _buildNavItem(2, IconManager.homeIcon, "Home", selectedIndex),
                    _buildNavItem(
                      3,
                      IconManager.balanceIcon,
                      "Balances",
                      selectedIndex,
                    ),
                    _buildNavItem(
                      4,
                      IconManager.goalsIcon,
                      "Goals",
                      selectedIndex,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ========= Bottom Nav Items ============
  Widget _buildNavItem(
    int index,
    String icon,
    String label,
    int selectedIndex,
  ) {
    final isSelected = selectedIndex == index;
    final activeColor = const Color(
      0xFFF2EEE4,
    ); // Light color for icons when active
    final inactiveColor = const Color(0xFF8B7E6D);
    final activeBgColor = const Color(0xFF2D1E12);

    return GestureDetector(
      onTap: () => ref.read(bottomNavBarProvider.notifier).onItemTapped(index),
      child: AnimatedContainer(
        height: 62.h,
        width: 62.2.w,
        duration: const Duration(milliseconds: 200),
        padding:  EdgeInsets.symmetric(horizontal: 1.r, vertical: 10.r),
        decoration: BoxDecoration(
          color: isSelected ? activeBgColor : Colors.transparent,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              icon,
              color: isSelected ? activeColor : inactiveColor,
              width:20.w ,
              height: 20.h,
            ),
            // Icon(
            //   icon,
            //   color: isSelected ? activeColor : inactiveColor,
            //   size: 24,
            // ),
             SizedBox(height: 4.h),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? activeColor : inactiveColor,
                fontSize: 12.sp,
                fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
