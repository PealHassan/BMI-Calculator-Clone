import 'dart:math';
import 'package:flutter/material.dart';

class BMIMeter extends StatelessWidget {
  final double bmi;

  const BMIMeter({Key? key, required this.bmi}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      child: CustomPaint(
        painter: BMIMeterPainter(bmi: bmi),
      ),
    );
  }
}

class BMIMeterPainter extends CustomPainter {
  final double bmi;

  BMIMeterPainter({required this.bmi});

  @override
  void paint(Canvas canvas, Size size) {
    print('BMI: $bmi');

    Paint paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 8
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    double center = size.width / 2;
    double radius = size.width / 2 - 20;

    // Draw the outer circle
    canvas.drawCircle(Offset(center, center), radius, paint);

    // Define BMI ranges and corresponding colors
    Map<String, dynamic> bmiRanges = {
      'Underweight': {'min': 16, 'max': 18.5, 'color': Colors.yellow},
      'Normal': {'min': 18.5, 'max': 25, 'color': Colors.green},
      'Overweight': {'min': 25, 'max': 40, 'color': Colors.red},
    };

    double startAngle = -pi / 2;
    double endAngle = 0;

    // Draw each BMI range segment
    bmiRanges.forEach((key, value) {
      double min = value['min'];
      double max = value['max'];
      Color color = value['color'];
      double sweepAngle = (max - min) / 40 * pi;
      paint.color = color;
      canvas.drawArc(
        Rect.fromCircle(center: Offset(center, center), radius: radius),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
      startAngle += sweepAngle;
    });

    // Draw the needle
    double angle = (pi / 40) * ((bmi >= 16 && bmi <= 40) ? bmi - 16 : 0);
    print('Angle: $angle');
    paint.color = Colors.black;
    paint.strokeWidth = 4;
    canvas.drawLine(
      Offset(center, center),
      Offset(center + radius * cos(angle), center + radius * sin(angle)),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
