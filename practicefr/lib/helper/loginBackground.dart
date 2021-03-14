import 'package:flutter/material.dart';

class LoginBackground extends CustomPainter {
  LoginBackground({this.isJoin});

  final bool isJoin;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = isJoin ? Colors.black : Colors.blueGrey;

    canvas.drawCircle(
        Offset(size.width * 0.5, size.height * 0.4), size.height * 0.5, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
