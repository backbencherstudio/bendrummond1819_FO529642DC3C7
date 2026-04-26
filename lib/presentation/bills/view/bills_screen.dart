import 'package:bendrummond1819_fo529642dc3c7/core/route/routes_name.dart';
import 'package:flutter/material.dart';

class BillsScreen extends StatefulWidget {
  const BillsScreen({super.key});

  @override
  State<BillsScreen> createState() => _BillsScreenState();
}

class _BillsScreenState extends State<BillsScreen> {
  // Color Palette - Matches your UI design
  final Color bgColor = const Color(0xFFF2EEE4);
  final Color darkBrown = const Color(0xFF433428);
  final Color mutedBrown = const Color(0xFF8C8071);
  final Color cardBg = const Color(0xFFFAF8F3);
  final String fontSerif = 'Serif'; // Recommended: 'DM Serif Display'

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

              // Header: Bills
              Text(
                'Bills',
                style: TextStyle(
                  fontSize: 40,
                  fontFamily: fontSerif,
                  fontWeight: FontWeight.bold,
                  color: darkBrown,
                ),
              ),

              const SizedBox(height: 10),

              // Sub-header Row: Total per month + Add Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$1,100/month',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: fontSerif,
                      color: mutedBrown,
                    ),
                  ),
                  // Small circular plus button
                  InkWell(
                    onTap: () =>
                        Navigator.pushNamed(context, RoutesName.addBillScreen),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEBE5D8), // Slightly darker beige
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.add, color: darkBrown, size: 20),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // Bills List
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    _buildBillCard("Car payment", "Monthly", "\$500"),
                    const SizedBox(height: 16),
                    _buildBillCard("Rent", "Monthly", "\$500"),
                    const SizedBox(height: 16),
                    _buildBillCard("Rent", "Due day 4", "\$100"),
                    const SizedBox(height: 100), // Space for Bottom Nav
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper Widget for Bill Cards
  Widget _buildBillCard(String title, String subtitle, String amount) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black.withValues(alpha: 0.08)),
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
                    fontWeight: FontWeight.w600,
                    color: darkBrown,
                  ),
                ),
                const SizedBox(height: 6),
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
          Text(
            amount,
            style: TextStyle(
              fontSize: 20,
              fontFamily: fontSerif,
              fontWeight: FontWeight.w600,
              color: darkBrown,
            ),
          ),
        ],
      ),
    );
  }
}
