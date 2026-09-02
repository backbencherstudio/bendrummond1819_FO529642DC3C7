import 'package:flutter/material.dart';

class SplashWavyLines extends StatelessWidget {
  final double width;
  final double height;

  const SplashWavyLines({super.key, required this.width, this.height = 70});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: CustomPaint(painter: _WavyLinesPainter()),
    );
  }
}

class _WaveSpec {
  final Color color;
  final double yFactor; // 0.0-1.0, vertical position as a fraction of height
  final double amplitude;
  final double opacity;

  const _WaveSpec({
    required this.color,
    required this.yFactor,
    required this.amplitude,
    required this.opacity,
  });
}

class _WavyLinesPainter extends CustomPainter {
  static const _waves = [
    _WaveSpec(
      color: Color(0xFFC9A876),
      yFactor: 0.30,
      amplitude: 5,
      opacity: 0.55,
    ),
    _WaveSpec(
      color: Color(0xFFB08A70),
      yFactor: 0.42,
      amplitude: 7,
      opacity: 0.65,
    ),
    _WaveSpec(
      color: Color(0xFF8B6F52),
      yFactor: 0.62,
      amplitude: 7,
      opacity: 0.65,
    ),
    _WaveSpec(
      color: Color(0xFF6B5645),
      yFactor: 0.74,
      amplitude: 5,
      opacity: 0.55,
    ),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    for (final wave in _waves) {
      final y = size.height * wave.yFactor;
      final paint = Paint()
        ..color = wave.color.withValues(alpha: wave.opacity)
        ..strokeWidth = 1.1
        ..style = PaintingStyle.stroke;

      final path = Path()..moveTo(0, y);
      path.quadraticBezierTo(
        size.width * 0.25,
        y - wave.amplitude,
        size.width * 0.5,
        y,
      );
      path.quadraticBezierTo(
        size.width * 0.75,
        y + wave.amplitude,
        size.width,
        y,
      );

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
