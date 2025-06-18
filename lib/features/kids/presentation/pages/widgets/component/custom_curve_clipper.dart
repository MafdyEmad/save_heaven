import 'package:flutter/material.dart';

class CustomCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double fabRadius = 35;
    double centerX = size.width / 2;

    Path path = Path();
    path.lineTo(centerX - fabRadius - 10, 0);

    path.quadraticBezierTo(
      centerX - fabRadius, 0,
      centerX - fabRadius + 10, 20,
    );

    path.arcToPoint(
      Offset(centerX + fabRadius - 10, 20),
      radius: Radius.circular(30),
      clockwise: false,
    );

    path.quadraticBezierTo(
      centerX + fabRadius, 0,
      centerX + fabRadius + 10, 0,
    );

    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
