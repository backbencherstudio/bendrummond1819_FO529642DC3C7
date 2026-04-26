import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  // Color Palette
  final Color bgColor = const Color(0xFFF2EEE4);
  final Color darkBrown = const Color(0xFF433428);
  final Color cardBg = Colors.white;
  final String fontSerif = 'Serif'; // Recommended: 'DM Serif Display'

  // Switch States
  bool billReminders = true;
  bool notificationReminder = true;
  bool emailUpdates = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              // Top Bar: Back Button + Title
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(
                        color: Color(0xFFEBE5D8), // Slightly darker beige
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.chevron_left,
                        color: darkBrown,
                        size: 24,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Text(
                    'Notification',
                    style: TextStyle(
                      fontSize: 32,
                      fontFamily: fontSerif,
                      fontWeight: FontWeight.bold,
                      color: darkBrown,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),

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
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black.withValues(alpha: 0.08)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontFamily: fontSerif,
              color: darkBrown,
              fontWeight: FontWeight.w500,
            ),
          ),
          // Custom Styled Switch
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.white,
            activeTrackColor: darkBrown,
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: Colors.black12,
          ),
        ],
      ),
    );
  }
}
