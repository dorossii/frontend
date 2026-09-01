import 'package:flutter/material.dart';

class UnderlineText extends StatelessWidget {
  final String text;

  const UnderlineText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: UnderlinePainter(),
      child: Text(text, style: const TextStyle(fontSize: 20, height: 1.8)),
    );
  }
}

class UnderlinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 1;

    const lineHeight = 20.0 * 1.8;

    for (double y = lineHeight; y < size.height; y += lineHeight) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
