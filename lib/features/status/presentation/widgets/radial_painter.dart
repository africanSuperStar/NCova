import 'package:vector_math/vector_math.dart';
import 'package:flutter/material.dart';

class RadialPainter extends CustomPainter {
  Color lineColor;
  double completePercent;
  double width;

  RadialPainter({
    this.lineColor,
    this.completePercent,
    this.width,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Rect afterRect = Rect.fromLTWH(190, 15, 160, 110);

    Paint line = new Paint()
      ..color = lineColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;

    double arcAngle = 90 * (completePercent / 100);
    double completeFraction = completePercent / 100;

    canvas.drawLine(Offset(35, 15), Offset(270 * completeFraction, 15), line);
    canvas.drawArc(afterRect, radians(0), -radians(arcAngle), false, line);
    canvas.drawLine(Offset(350, 72), Offset(350, 270 * completeFraction), line);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
