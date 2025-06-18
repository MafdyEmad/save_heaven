import 'package:flutter/material.dart';

class CurveBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.shade300
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;

    final path = Path();
    double fabRadius = 35;
    double centerX = size.width / 2;

    path.moveTo(0, 0);
    path.lineTo(centerX - fabRadius - 10, 0);
    path.quadraticBezierTo(centerX - fabRadius, 0, centerX - fabRadius + 10, 20);
    path.arcToPoint(
      Offset(centerX + fabRadius - 10, 20),
      radius: Radius.circular(30),
      clockwise: false,
    );
    path.quadraticBezierTo(centerX + fabRadius, 0, centerX + fabRadius + 10, 0);
    path.lineTo(size.width, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
