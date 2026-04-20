import 'package:bendrummond1819_fo529642dc3c7/core/route/routes_name.dart';
import 'package:flutter/material.dart';

class GoalsScreen extends StatefulWidget {
  const GoalsScreen({super.key});

  @override
  State<GoalsScreen> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen> {
  // Color Palette - Matching your UI design
  final Color bgColor = const Color(0xFFF2EEE4);
  final Color darkBrown = const Color(0xFF433428);
  final Color mutedBrown = const Color(0xFF8C8071);
  final Color cardBg = const Color(0xFFFAF8F3);
  final String fontSerif =
      'Serif'; // Recommended: 'DM Serif Display' from Google Fonts

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
              const SizedBox(height: 40),

              // Header: Goals
              Text(
                'Goals',
                style: TextStyle(
                  fontSize: 36,
                  fontFamily: fontSerif,
                  fontWeight: FontWeight.bold,
                  color: darkBrown,
                ),
              ),

              const SizedBox(height: 20),

              // Sub-header Row: "Your future goals" + Add Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Your future goals',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: fontSerif,
                      color: mutedBrown,
                    ),
                  ),
                  // Small circular plus button
                  InkWell(
                    onTap: () =>
                        Navigator.pushNamed(context, RoutesName.addGoalScreen),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEBE5D8),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.add, color: darkBrown, size: 20),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              // Goals List
              _buildGoalCard("Buy a Iphone 17 Pro", "\$60/monthly"),
              const SizedBox(height: 15),
              _buildGoalCard("Emergency fund", "\$30/monthly"),
            ],
          ),
        ),
      ),
    );
  }

  // Reusable Widget for Goal Cards
  Widget _buildGoalCard(String title, String subtitle) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black.withOpacity(0.08)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: fontSerif,
                    color: darkBrown.withOpacity(0.8),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: fontSerif,
                    color: mutedBrown,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.close, color: darkBrown, size: 24),
        ],
      ),
    );
  }
}
