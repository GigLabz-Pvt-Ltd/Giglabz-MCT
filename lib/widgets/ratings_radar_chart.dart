import 'package:flutter/material.dart';
import 'dart:math';

class RatingsRadarChart extends CustomPainter{
  RatingsRadarChart({
    required this.features,
    required this.ratings,
    required this.ratingGraphColor,
  });
  List<String> features;
  List<double> ratings;
  Color ratingGraphColor;

  @override
  void paint(Canvas canvas, Size size) {
    var centerX = size.width / 2.0;
    var centerY = size.height / 2.0;
    var centerOffset = Offset(centerX, centerY);
    var radius = centerX * 0.8;

    var outlinePentagonPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..isAntiAlias = true;

    const sides = 5; // number of sides for pentagon
    const double angle = (2 * pi) / sides;

    // Draw the outer pentagon
    Path pentagonPath = Path();
    pentagonPath.moveTo(
      centerX + radius * cos(-pi / 2),
      centerY + radius * sin(-pi / 2),
    );
    for (int i = 0; i < sides; i++) {
      pentagonPath.lineTo(
        centerX + radius * cos(-pi / 2 + angle * i),
        centerY + radius * sin(-pi / 2 + angle * i),
      );
    }
    pentagonPath.close();
    canvas.drawPath(pentagonPath, outlinePentagonPaint);

    //Draw inner pentagons
    var ratingValues = [1,2,3,4,5];
    var smallPentagonRadius = radius / (ratingValues.length);

    ratingValues.sublist(0, ratingValues.length - 1).asMap().forEach((index, rating) {
      var ratingRadius = smallPentagonRadius * (index + 1);
      Path smallPentagonPath = Path();
      smallPentagonPath.moveTo(
        centerX + ratingRadius * cos(-pi / 2 ),
        centerY + ratingRadius * sin(-pi / 2 ),
      );
      for (int i = 1; i <= sides; i++) {
        smallPentagonPath.lineTo(
          centerX + ratingRadius * cos(-pi / 2 + angle * i ),
          centerY + ratingRadius * sin(-pi / 2 + angle * i ),
        );
      }
      smallPentagonPath.close();
      canvas.drawPath(smallPentagonPath, outlinePentagonPaint);
    });

    // Display feature labels
    const List<String> features = ["AA", "BB", "CC", "DD", "EE"];
    final double labelRadius = radius + 20; // Radius for labels

    for (int i = 0; i < sides; i++) {
      final double labelAngle = -pi / 2 + angle * i;
      final double labelX = centerX + labelRadius * cos(labelAngle);  //for labels
      final double labelY = centerY + labelRadius * sin(labelAngle);  // for labels
      final double diagonalAngleX = cos(angle * i - pi / 2);  //for inner diagonal lines from center
      final double diagonalAngleY = sin(angle * i - pi / 2);  // for inner diagonal lines from center
      var diagonalOffset = Offset(centerX + radius * diagonalAngleX, centerY + radius * diagonalAngleY);

      canvas.drawLine(centerOffset, diagonalOffset, outlinePentagonPaint);

      TextPainter(
        text: TextSpan(
          text: features[i],
          style: TextStyle(color: Colors.black, fontSize: 12),
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      )
        ..layout(minWidth: 0, maxWidth: size.width)
        ..paint(canvas, Offset(labelX, labelY));
    }

    // Display rating radar graph
    const ratingGraphColor = Colors.blue;
    const List<List<double>> ratingData = [
      [5,4,4.5,1,0],
    ];
    final double scale = radius / ratingData.map((e) => e.reduce(max)).reduce(max);

    for (int j = 0; j < ratingData.length; j++) {
      final List<double> ratingGraph = ratingData[j];
      List<Offset> center = [];
      double textOffset = 5;

      var circlePointerPaint = Paint()
        ..color = Colors.red
        ..style = PaintingStyle.fill;

      Paint ratingGraphPaint = Paint()
        ..color = ratingGraphColor.withOpacity(0.3)
        ..style = PaintingStyle.fill;

      Paint ratingGraphOutlinePaint = Paint()
        ..color = ratingGraphColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0
        ..isAntiAlias = true;

      // Path for rating radar graph
      Path ratingGraphPath = Path();
      for (int i = 0; i < sides; i++) {
        final double scaledPoint = scale * ratingGraph[i];
        final double x = centerX + scaledPoint * cos(-pi / 2 + angle * i);
        final double y = centerY + scaledPoint * sin(-pi / 2 + angle * i);
        if (i == 0) {
          center.add(Offset(x, y));
          ratingGraphPath.moveTo(x, y);
        } else {
          center.add(Offset(x, y));
          ratingGraphPath.lineTo(x, y);
        }
      }
      canvas.drawPath(ratingGraphPath, ratingGraphPaint);
      canvas.drawPath(ratingGraphPath, ratingGraphOutlinePaint);

      // Display pointer for ratings
      for(int i=0; i<sides; i++){
        canvas.drawCircle(center[i], 10, circlePointerPaint);
        TextPainter(
          text: TextSpan(
            text: ratingData[0][i].toString(),
            style: TextStyle(color: Colors.white, fontSize: 8),
          ),
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr,
        )
          ..layout(minWidth: 0, maxWidth: size.width)
          ..paint(canvas, Offset(center[i].dx - textOffset, center[i].dy - textOffset));
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

}