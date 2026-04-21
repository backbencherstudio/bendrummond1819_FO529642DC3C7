import 'package:flutter/material.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  // Color Palette consistent with your other screens
  final Color bgColor = const Color(0xFFF2EEE4);
  final Color darkBrown = const Color(0xFF433428);
  final Color mutedBrown = const Color(0xFF8C8071);
  final Color cardBg = const Color(0xFFFAF8F3);
  final String fontSerif = 'Serif'; // Ensure you use your serif font here

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
                    'About',
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

              // Menu Options
              _buildAboutTile(
                "Terms of Service",
                trailing: Icon(Icons.chevron_right, color: darkBrown),
              ),
              const SizedBox(height: 16),
              _buildAboutTile(
                "Privacy Policy",
                trailing: Icon(Icons.chevron_right, color: darkBrown),
              ),
              const SizedBox(height: 16),
              _buildAboutTile(
                "App Version",
                trailing: Text(
                  "1.0.0",
                  style: TextStyle(
                    fontFamily: fontSerif,
                    color: mutedBrown,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Reusable Widget for the About rows
  Widget _buildAboutTile(String title, {required Widget trailing}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black.withOpacity(0.08)),
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
          trailing,
        ],
      ),
    );
  }
}
