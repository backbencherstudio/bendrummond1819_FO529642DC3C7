import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/color_manger.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/style_manager.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/widgets/custom_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  // Switch States
  bool billReminders = true;
  bool notificationReminder = true;
  bool emailUpdates = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 20.0.r,vertical: 32.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Bar: Back Button + Title
              Row(
                children: [
                  customBackButton(context,borderColor: ColorManager.borderColor2),
                   SizedBox(width: 12.w),
                  Text(
                    'Notification',
                    style: 
                    getSemiBoldStyle22(color: ColorManager.textPrimary,fontSize: 24)
                  ),
                ],
              ),

               SizedBox(height: 24.h),

              // Notification List Items
              _buildNotificationTile(
                "Bill reminders",
                billReminders,
                (val) => setState(() => billReminders = val),
              ),
              const SizedBox(height: 16),
              _buildNotificationTile(
                "Notification Reminder",
                notificationReminder,
                (val) => setState(() => notificationReminder = val),
              ),
              const SizedBox(height: 16),
              _buildNotificationTile(
                "Email Updates",
                emailUpdates,
                (val) => setState(() => emailUpdates = val),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Reusable Widget for Notification Rows
  Widget _buildNotificationTile(
    String title,
    bool value,
    Function(bool) onChanged,
  ) {
    return Container(
      padding:  EdgeInsets.symmetric(horizontal: 16.r, vertical: 16.r),
      decoration: BoxDecoration(
        color: ColorManager.secondaryBackGround,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: ColorManager.brown.withValues(alpha: .5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: 
            getMediumStyle18(color: ColorManager.c201F2E,fontSize: 16)
          ),
          // Custom Styled Switch
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.white,
            activeTrackColor: ColorManager.brown,
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: Colors.black12,
          ),
        ],
      ),
    );
  }
}
