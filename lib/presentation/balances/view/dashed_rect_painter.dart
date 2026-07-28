import 'dart:ui';
import 'package:flutter/material.dart';

class DashedRectPainter extends CustomPainter {
  final Color color;
  final double dashWidth;
  final double dashSpace;
  final double strokeWidth;
  final double borderRadius;

  const DashedRectPainter({
    required this.color,
    this.dashWidth = 5,
    this.dashSpace = 3,
    this.strokeWidth = 1,
    this.borderRadius = 20,
  });

  @override
  void paint(Canvas canvas, Size size) {
    double startX = 0;
    final paint = Paint()
      ..color = color.withValues(alpha: 0.5)
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, size.width, size.height),
          Radius.circular(borderRadius),
        ),
      );

    for (final pathMetric in path.computeMetrics()) {
      while (startX < pathMetric.length) {
        canvas.drawPath(
          pathMetric.extractPath(startX, startX + dashWidth),
          paint,
        );
        startX += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant DashedRectPainter oldDelegate) =>
      oldDelegate.color != color ||
      oldDelegate.dashWidth != dashWidth ||
      oldDelegate.dashSpace != dashSpace ||
      oldDelegate.strokeWidth != strokeWidth ||
      oldDelegate.borderRadius != borderRadius;
}
