import 'package:bendrummond1819_fo529642dc3c7/core/route/routes_name.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Color Palette
  final Color bgColor = const Color(0xFFF2EEE4);
  final Color darkBrown = const Color(
    0xFF2D1E12,
  ); // Deep dark brown for main text
  final Color mutedBrown = const Color(0xFF8B7E6D); // Muted brown for labels
  final String fontSerif = 'Serif'; // Recommended: 'DM Serif Display'

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),

              // =========== Header Section ===========
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'STABILITY',
                        style: TextStyle(
                          fontSize: 28,
                          fontFamily: fontSerif,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                          color: darkBrown,
                        ),
                      ),
                      Text(
                        'Good evening, Yasir',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: fontSerif,
                          fontStyle: FontStyle.italic,
                          color: const Color(0xFFA67C52), // Golden brown
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () => Navigator.pushNamed(
                      context,
                      RoutesName.homeSettingsScreen,
                    ),
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person_outline, color: darkBrown),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 60),

              // --- Main "Safe to Spend" Section with Glow ---
              Stack(
                alignment: Alignment.center,
                children: [
                  // Subtle Radial Glow
                  Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          const Color(0xFFE8D4A2).withOpacity(0.4),
                          bgColor,
                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        'SAFE TO SPEND',
                        style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 1.5,
                          color: const Color(0xFFA67C52),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '\$185',
                        style: TextStyle(
                          fontSize: 100,
                          fontFamily: fontSerif,
                          fontWeight: FontWeight.bold,
                          color: darkBrown,
                        ),
                      ),

                      // Divider with Text
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 40,
                            height: 1,
                            color: Colors.black12,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              'October 1st paycheck',
                              style: TextStyle(
                                color: const Color(0xFFA67C52),
                                fontFamily: fontSerif,
                              ),
                            ),
                          ),
                          Container(
                            width: 40,
                            height: 1,
                            color: Colors.black12,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 100),

              // --- Payday Breakdown Section ---
              Text(
                'Payday Breakdown',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: fontSerif,
                  color: const Color(0xFFA67C52),
                ),
              ),
              const SizedBox(height: 30),

              _buildBreakdownRow("Pay going to bills", "\$1,350"),
              const SizedBox(height: 15),
              _buildBreakdownRow("Bills (2)", "\$865"),

              const SizedBox(height: 15),
              const Divider(color: Colors.black12, thickness: 1),
              const SizedBox(height: 10),

              // Total Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Safe to Spend',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: fontSerif,
                      fontWeight: FontWeight.bold,
                      color: darkBrown,
                    ),
                  ),
                  Text(
                    '\$185',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: fontSerif,
                      fontWeight: FontWeight.bold,
                      color: darkBrown,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 120), // Padding for Bottom Nav
            ],
          ),
        ),
      ),
    );
  }

  // Helper Widget for Dotted Breakdown Rows
  Widget _buildBreakdownRow(String label, String value) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 17,
            fontFamily: fontSerif,
            color: const Color(0xFFA67C52),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: CustomPaint(painter: DottedLinePainter()),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 17,
            fontFamily: fontSerif,
            color: darkBrown,
          ),
        ),
      ],
    );
  }
}

// Custom Painter for the Dotted Line effect
class DottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double dashWidth = 2, dashSpace = 3, startX = 0;
    final paint = Paint()
      ..color = Colors.black26
      ..strokeWidth = 1;
    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, size.height / 1.2),
        Offset(startX + dashWidth, size.height / 1.2),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
