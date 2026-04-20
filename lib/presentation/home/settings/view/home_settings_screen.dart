import 'package:bendrummond1819_fo529642dc3c7/core/route/routes_name.dart';
import 'package:flutter/material.dart';

class HomeSettingsScreen extends StatefulWidget {
  const HomeSettingsScreen({super.key});

  @override
  State<HomeSettingsScreen> createState() => _HomeSettingsScreenState();
}

class _HomeSettingsScreenState extends State<HomeSettingsScreen> {
  // Color Palette matching previous screens
  final Color bgColor = const Color(0xFFF2EEE4);
  final Color darkBrown = const Color(0xFF433428);
  final Color mutedBrown = const Color(0xFF8C8071);
  final Color cardBg = Colors.white;
  final Color menuBg = const Color(0xFFFAF8F3);
  final String fontSerif = 'Serif'; // Recommended: 'DM Serif Display'

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              // Header
              Text(
                'Settings',
                style: TextStyle(
                  fontSize: 36,
                  fontFamily: fontSerif,
                  fontWeight: FontWeight.bold,
                  color: darkBrown,
                ),
              ),
              const SizedBox(height: 25),

              // Profile Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: cardBg,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.black.withOpacity(0.05)),
                ),
                child: Row(
                  children: [
                    // Profile Image
                    const CircleAvatar(
                      radius: 35,
                      backgroundImage: NetworkImage(
                        'https://pbs.twimg.com/profile_images/1564398871996174336/M-N6gu7M_400x400.jpg', // Placeholder for Yasir
                      ),
                    ),
                    const SizedBox(width: 15),
                    // Profile Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Yasir Abed Rabbu',
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: fontSerif,
                              fontWeight: FontWeight.bold,
                              color: darkBrown,
                            ),
                          ),
                          Text(
                            'yasirabedrabbu@gmail.com',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: fontSerif,
                              color: mutedBrown,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Member since January 2024',
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: fontSerif,
                              color: mutedBrown.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Menu Items
              _buildMenuTile(Icons.person_outline, "Account", () {
                Navigator.pushNamed(context, RoutesName.accountScreen);
              }),
              const SizedBox(height: 15),
              _buildMenuTile(Icons.notifications_none, "Notifications", () {
                Navigator.pushNamed(context, RoutesName.notificationScreen);
              }),
              const SizedBox(height: 15),
              _buildMenuTile(Icons.help_outline, "About", () {
                Navigator.pushNamed(context, RoutesName.aboutScreen);
              }),

              const SizedBox(height: 30),

              // Bottom Action Buttons
              Row(
                children: [
                  // Delete Button
                  Expanded(
                    child: _buildActionButton(
                      label: "Account Delete",
                      icon: Icons.delete_outline,
                      color: const Color(0xFFE53935), // Red
                      textColor: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 15),
                  // Sign out Button
                  Expanded(
                    child: _buildActionButton(
                      label: "Sign out",
                      icon: Icons.logout,
                      color: const Color(0xFFCFD1D3), // Grey
                      textColor: darkBrown,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Helper Widget for Menu Tiles
  Widget _buildMenuTile(IconData icon, String title, VoidCallback onTap) {
    return Container(
      decoration: BoxDecoration(
        color: menuBg,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.black.withOpacity(0.05)),
      ),
      child: ListTile(
        leading: Icon(icon, color: darkBrown, size: 24),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontFamily: fontSerif,
            color: darkBrown.withOpacity(0.8),
          ),
        ),
        trailing: Icon(Icons.chevron_right, color: darkBrown, size: 24),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        onTap: onTap,
      ),
    );
  }

  // Helper Widget for Bottom Action Buttons
  Widget _buildActionButton({
    required String label,
    required IconData icon,
    required Color color,
    required Color textColor,
  }) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: textColor, size: 22),
              const SizedBox(width: 10),
              Text(
                label,
                style: TextStyle(
                  color: textColor,
                  fontSize: 16,
                  fontFamily: fontSerif,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
