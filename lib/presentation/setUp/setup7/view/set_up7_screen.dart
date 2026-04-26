import 'dart:ui';
import 'package:bendrummond1819_fo529642dc3c7/presentation/setUp/setup8/view/set_up8_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:bendrummond1819_fo529642dc3c7/presentation/setUp/viewmodel/set_up_screen_riverpod.dart';

class SetUp7Screen extends ConsumerStatefulWidget {
  const SetUp7Screen({super.key});

  @override
  ConsumerState<SetUp7Screen> createState() => _SetUp7ScreenState();
}

class _SetUp7ScreenState extends ConsumerState<SetUp7Screen> {
  // --- Exact Theme Colors from UI ---
  final Color bgColor = const Color(0xFFF9F6F1);
  final Color darkBrown = const Color(0xFF514139);
  final Color mutedBrown = const Color(0xFF7A7067);
  final Color accentTan = const Color(0xFFEFE6D8);
  final Color progressTrack = const Color(0xFFE8E4D8);
  final Color inputBg = const Color(0xFFFDFCF9);

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

              // --- Title ---
              Text(
                "Any debts to account\nfor?",
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
                "Student loans, credit cards, personal loans —\nwhat you pay regularly.",
                style: TextStyle(fontSize: 18, color: mutedBrown, height: 1.3),
              ),

              const SizedBox(height: 35),

              // --- Dashed "Add a debt" Button ---
              CustomPaint(
                painter: DashedRectPainter(
                  color: Colors.black.withValues(alpha: 0.25),
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
                    decoration: BoxDecoration(
                      color: inputBg.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(18),
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
                          "Add a debt",
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

              const Spacer(),

              // --- Action Buttons ---
              SizedBox(
                width: double.infinity,
                height: 65,
                child: ElevatedButton(
                  onPressed: () {
                    notifier.nextStep();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SetUp8Screen(),
                      ),
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
                    "Continue",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'serif',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 65,
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                      color: Colors.black.withValues(alpha: 0.08),
                    ),
                    backgroundColor: inputBg,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    "No debts right now",
                    style: TextStyle(
                      color: darkBrown,
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

// Custom Painter for the dashed rounded rectangle border
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
