import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../core/app_theme.dart';
import '../data/models.dart';

/// Line chart with a soft gradient fill. Used for price trends.
class SparkLine extends StatelessWidget {
  const SparkLine({
    super.key,
    required this.values,
    required this.color,
    this.height = 46,
    this.showDot = true,
  });

  final List<double> values;
  final Color color;
  final double height;
  final bool showDot;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: CustomPaint(
        painter: _SparkPainter(values: values, color: color, showDot: showDot),
      ),
    );
  }
}

class _SparkPainter extends CustomPainter {
  _SparkPainter({
    required this.values,
    required this.color,
    required this.showDot,
  });

  final List<double> values;
  final Color color;
  final bool showDot;

  @override
  void paint(Canvas canvas, Size size) {
    if (values.length < 2) return;

    final double minValue = values.reduce(math.min);
    final double maxValue = values.reduce(math.max);
    final double span = (maxValue - minValue).abs() < 0.0001
        ? 1.0
        : (maxValue - minValue);

    final double top = size.height * 0.12;
    final double usable = size.height * 0.76;

    final List<Offset> points = <Offset>[];
    for (int i = 0; i < values.length; i++) {
      final double x = size.width * i / (values.length - 1);
      final double y = top + usable - ((values[i] - minValue) / span) * usable;
      points.add(Offset(x, y));
    }

    final Path line = Path()..moveTo(points.first.dx, points.first.dy);
    for (int i = 1; i < points.length; i++) {
      line.lineTo(points[i].dx, points[i].dy);
    }

    final Path fill = Path.from(line)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(
      fill,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[color.withOpacity(0.30), color.withOpacity(0.0)],
        ).createShader(Offset.zero & size),
    );

    canvas.drawPath(
      line,
      Paint()
        ..color = color
        ..strokeWidth = 2.4
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round,
    );

    if (showDot) {
      canvas.drawCircle(points.last, 4.5, Paint()..color = color);
      canvas.drawCircle(
        points.last,
        4.5,
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _SparkPainter oldDelegate) =>
      oldDelegate.values != values ||
      oldDelegate.color != color ||
      oldDelegate.showDot != showDot;
}

/// Bar chart for the yield history, with the forecast season highlighted.
class YieldBars extends StatelessWidget {
  const YieldBars({super.key, required this.points, required this.unit});

  final List<YieldPoint> points;
  final String unit;

  @override
  Widget build(BuildContext context) {
    final double maxValue =
        points.map((YieldPoint p) => p.value).reduce(math.max);

    return SizedBox(
      height: 186,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: points.map((YieldPoint point) {
          final bool forecast = point.forecast;
          final Color color = forecast ? AppColors.sun : AppColors.primary;
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    point.value.toStringAsFixed(1),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: forecast ? AppColors.sun : context.strongText,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: TweenAnimationBuilder<double>(
                        tween: Tween<double>(
                          begin: 0,
                          end: point.value / maxValue,
                        ),
                        duration: const Duration(milliseconds: 800),
                        curve: Curves.easeOutCubic,
                        builder: (BuildContext context, double factor, _) {
                          return FractionallySizedBox(
                            heightFactor: factor.clamp(0.05, 1.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: <Color>[
                                    color,
                                    color.withOpacity(0.55),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    point.label,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: forecast ? FontWeight.w700 : FontWeight.w500,
                      color: forecast ? AppColors.sun : context.subtleText,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
