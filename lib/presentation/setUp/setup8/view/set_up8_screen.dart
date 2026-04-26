import 'dart:ui';
import 'package:bendrummond1819_fo529642dc3c7/core/route/routes_name.dart';
import 'package:bendrummond1819_fo529642dc3c7/presentation/setUp/viewmodel/set_up_screen_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SetUp8Screen extends ConsumerStatefulWidget {
  const SetUp8Screen({super.key});

  @override
  ConsumerState<SetUp8Screen> createState() => _SetUp8ScreenState();
}

class _SetUp8ScreenState extends ConsumerState<SetUp8Screen> {
  // --- Exact Theme Colors from the Image ---
  final Color bgColor = const Color(0xFFF9F6F1); // Light cream background
  final Color darkBrown = const Color(0xFF514139); // Main dark text & button
  final Color mutedBrown = const Color(0xFF8B7A70); // Subtext color
  final Color accentTan = const Color(0xFFEFE6D8); // Circle background color
  final Color progressTrack = const Color(0xFFE8E4D8); // Progress bar track

  @override
  Widget build(BuildContext context) {
    final currentStep = ref.watch(setupStepProvider);
    final notifier = ref.read(setupStepProvider.notifier);

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),

              // --- Header: Back Button & Progress ---
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      notifier.previousStep();
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: accentTan,
                        border: Border.all(
                          color: Colors.brown.withValues(alpha: 0.1),
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.chevron_left,
                          color: darkBrown,
                          size: 28,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "$currentStep of $totalSteps",
                          style: TextStyle(
                            color: mutedBrown,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: LinearProgressIndicator(
                            value: currentStep / totalSteps,
                            minHeight: 6,
                            backgroundColor: progressTrack,
                            color: darkBrown,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),

              // --- Title (Serif Style) ---
              Text(
                "Saving for anything?",
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w700,
                  color: darkBrown,
                  fontFamily: 'serif',
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 15),

              // --- Subtext ---
              Text(
                "Start small — even a little helps. You can add\nmore later.",
                style: TextStyle(fontSize: 18, color: mutedBrown, height: 1.3),
              ),

              const SizedBox(height: 35),

              // --- Dashed "Add a goal" Button ---
              CustomPaint(
                painter: DashedRectPainter(
                  color: Colors.black.withValues(alpha: 0.2),
                  radius: 18,
                ),
                child: InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(18),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      vertical: 22,
                      horizontal: 20,
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: accentTan,
                          ),
                          child: Icon(Icons.add, color: darkBrown, size: 20),
                        ),
                        const SizedBox(width: 15),
                        Text(
                          "Add a goal",
                          style: TextStyle(
                            fontSize: 20,
                            color: mutedBrown,
                            fontFamily: 'serif',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const Spacer(), // Pushes button to bottom
              // --- Action Button: Skip for now ---
              SizedBox(
                width: double.infinity,
                height: 65,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      RoutesName.bottomNavRoute,
                      (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: darkBrown,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    "Skip for now",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'serif',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

// Custom Painter to draw the dashed rounded border
class DashedRectPainter extends CustomPainter {
  final Color color;
  final double radius;

  DashedRectPainter({required this.color, required this.radius});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    const double dashWidth = 4;
    const double dashSpace = 3;

    final RRect rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(radius),
    );

    final Path path = Path()..addRRect(rrect);

    for (final PathMetric metric in path.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        canvas.drawPath(
          metric.extractPath(distance, distance + dashWidth),
          paint,
        );
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
