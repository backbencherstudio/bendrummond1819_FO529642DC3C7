import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/color_manger.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/style_manager.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/provider/user_provider.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/widgets/custom_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationScreen extends ConsumerStatefulWidget {
  const NotificationScreen({super.key});

  @override
  ConsumerState<NotificationScreen> createState() =>
      _NotificationScreenState();
}

class _NotificationScreenState extends ConsumerState<NotificationScreen> {
  bool _billReminders = true;
  bool _notificationReminder = true;
  bool _emailUpdates = true;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final user = ref.read(userProvider).user;
      if (user != null && !_initialized) {
        setState(() {
          _billReminders = user.billRemainders;
          _notificationReminder = user.notificationRemainder;
          _initialized = true;
        });
      } else if (user == null) {
        ref.read(userProvider.notifier).loadUser();
      }
    });
  }

  Future<void> _onBillRemindersChanged(bool val) async {
    setState(() => _billReminders = val);
    final success = await ref
        .read(userProvider.notifier)
        .updateProfile(billRemainders: val);
    if (!mounted) return;
    if (!success) {
      setState(() => _billReminders = !val);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to update bill reminders")),
      );
    }
  }

  Future<void> _onNotificationReminderChanged(bool val) async {
    setState(() => _notificationReminder = val);
    final success = await ref
        .read(userProvider.notifier)
        .updateProfile(notificationRemainder: val);
    if (!mounted) return;
    if (!success) {
      setState(() => _notificationReminder = !val);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to update notification reminder")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<UserState>(userProvider, (previous, next) {
      if (next.user != null && !_initialized) {
        setState(() {
          _billReminders = next.user!.billRemainders;
          _notificationReminder = next.user!.notificationRemainder;
          _initialized = true;
        });
      }
    });

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0.r, vertical: 32.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Bar: Back Button + Title
              Row(
                children: [
                  customBackButton(
                    context,
                    borderColor: ColorManager.backgroundPressed100,
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    'Notification',
                    style: getSemiBoldStyle22(
                      color: ColorManager.textPrimary,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 24.h),

              // Notification List Items
              _buildNotificationTile(
                "Bill reminders",
                _billReminders,
                _onBillRemindersChanged,
              ),
              const SizedBox(height: 16),
              _buildNotificationTile(
                "Notification Reminder",
                _notificationReminder,
                _onNotificationReminderChanged,
              ),
              const SizedBox(height: 16),
              _buildNotificationTile(
                "Email Updates",
                _emailUpdates,
                (val) => setState(() => _emailUpdates = val),
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
      padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 16.r),
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
            style: getMediumStyle18(color: ColorManager.c201F2E, fontSize: 16),
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
