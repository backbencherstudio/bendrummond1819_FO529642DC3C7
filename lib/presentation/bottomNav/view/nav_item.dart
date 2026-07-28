import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../viewmodel/bottom_nav_bar_viewmodel.dart';

class NavItem extends ConsumerWidget {
  const NavItem({
    super.key,
    required this.index,
    required this.icon,
    required this.label,
    required this.selectedIndex,
  });

  final int index;
  final String icon;
  final String label;
  final int selectedIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSelected = selectedIndex == index;

    const activeColor = Color(0xFFFFFFFF);
    const inactiveColor = Color(0xFF8C7055);
    const activeBgColor = Color(0xFF3B2208);

    return GestureDetector(
      onTap: () => ref.read(bottomNavBarProvider.notifier).onItemTapped(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 62.h,
        width: 62.2.w,
        padding: EdgeInsets.symmetric(horizontal: 1.r, vertical: 10.r),
        decoration: BoxDecoration(
          color: isSelected ? activeBgColor : Colors.transparent,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              icon,
              width: 20.w,
              height: 20.h,
              colorFilter: ColorFilter.mode(
                isSelected ? activeColor : inactiveColor,
                BlendMode.srcIn,
              ),
            ),
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
