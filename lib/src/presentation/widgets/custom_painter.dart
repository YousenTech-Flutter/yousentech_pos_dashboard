import 'package:flutter/material.dart';
import 'package:shared_widgets/config/app_colors.dart';

class RPSCustomPainterL2R extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Layer 1

    Paint paintFill = Paint()
      ..color = AppColor.white
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    Path pathFill = Path();
    pathFill.moveTo(size.width * -0.0000000, size.height * 1.0000000);
    pathFill.lineTo(size.width * -0.0000000, 0);
    pathFill.lineTo(size.width * 1.0000000, 0);
    pathFill.lineTo(size.width * 1.0000000, size.height * 1.0000000);

    canvas.drawPath(pathFill, paintFill);

    // Layer 2
    Path pathFillStroke = Path();
    pathFillStroke.moveTo(size.width * -0.0000000, size.height * 1.0000000);
    pathFillStroke.lineTo(size.width * -0.0000000, 0);
    pathFillStroke.lineTo(size.width * 1.0000000, 0);

    Paint paintFillStroke = Paint()
      ..color = AppColor.purple
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    canvas.drawPath(pathFillStroke, paintFillStroke);

    // Layer 1

    Paint paintShap = Paint()
      ..color = AppColor.purple
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    Path pathShap = Path();
    pathShap.moveTo(0, size.height * 0.0050000);
    pathShap.lineTo(size.width, 0);
    pathShap.quadraticBezierTo(size.width * 0.9960400, size.height * 0.2467500,
        size.width * 0.9000000, size.height * 0.2550000);
    pathShap.cubicTo(
        size.width * 0.7250000,
        size.height * 0.2537500,
        size.width * 0.3750000,
        size.height * 0.2512500,
        size.width * 0.2000000,
        size.height * 0.2500000);
    pathShap.quadraticBezierTo(size.width * 0.0965600, size.height * 0.2619500,
        size.width * 0.1000000, size.height * 0.5050000);
    pathShap.quadraticBezierTo(size.width * 0.0995200, size.height * 0.7368000,
        size.width * 0.2000000, size.height * 0.7450000);
    pathShap.cubicTo(
        size.width * 0.3750000,
        size.height * 0.7487500,
        size.width * 0.7250000,
        size.height * 0.7562500,
        size.width * 0.9000000,
        size.height * 0.7600000);
    pathShap.quadraticBezierTo(size.width * 0.9990000, size.height * 0.7497000,
        size.width, size.height);
    pathShap.lineTo(0, size.height * 1.0050000);
    pathShap.lineTo(0, size.height * 0.0050000);
    pathShap.close();

    canvas.drawPath(pathShap, paintShap);

    // Layer 1

    Paint paintShapStroke = Paint()
      ..color = AppColor.purple
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    canvas.drawPath(pathShap, paintShapStroke);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class RPSCustomPainterR2L extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Layer 1

    Paint paintFill = Paint()
      ..color = AppColor.white
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    Path pathFill = Path();
    pathFill.moveTo(size.width * 1.0000000, size.height * 1.0000000);
    pathFill.lineTo(size.width * 1.0000000, 0);
    pathFill.lineTo(size.width * -0.0000000, 0);
    pathFill.lineTo(size.width * -0.0000000, size.height * 1.0000000);

    canvas.drawPath(pathFill, paintFill);

    // Layer 2
    Path pathFillStroke = Path();
    pathFillStroke.moveTo(size.width * 1.0000000, size.height * 1.0000000);
    pathFillStroke.lineTo(size.width * 1.0000000, 0);
    pathFillStroke.lineTo(size.width * -0.0000000, 0);

    Paint paintFillStroke = Paint()
      ..color = AppColor.purple
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    canvas.drawPath(pathFillStroke, paintFillStroke);

    // Layer 1

    Paint paintShap = Paint()
      ..color = AppColor.purple
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    Path pathShap = Path();
    pathShap.moveTo(size.width, size.height * 0.0050000);
    pathShap.lineTo(0, 0);
    pathShap.quadraticBezierTo(size.width * 0.0039600, size.height * 0.2467500,
        size.width * 0.1000000, size.height * 0.2550000);
    pathShap.cubicTo(
        size.width * 0.2750000,
        size.height * 0.2537500,
        size.width * 0.6250000,
        size.height * 0.2512500,
        size.width * 0.8000000,
        size.height * 0.2500000);
    pathShap.quadraticBezierTo(size.width * 0.9034400, size.height * 0.2619500,
        size.width * 0.9000000, size.height * 0.5050000);
    pathShap.quadraticBezierTo(size.width * 0.9004800, size.height * 0.7368000,
        size.width * 0.8000000, size.height * 0.7450000);
    pathShap.cubicTo(
        size.width * 0.6250000,
        size.height * 0.7487500,
        size.width * 0.2750000,
        size.height * 0.7562500,
        size.width * 0.1000000,
        size.height * 0.7600000);
    pathShap.quadraticBezierTo(
        size.width * 0.0010000, size.height * 0.7497000, 0, size.height);
    pathShap.lineTo(size.width, size.height * 1.0050000);
    pathShap.lineTo(size.width, size.height * 0.0050000);
    pathShap.close();

    canvas.drawPath(pathShap, paintShap);

    // Layer 1

    Paint paintShapStroke = Paint()
      ..color = AppColor.purple
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    canvas.drawPath(pathShap, paintShapStroke);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
