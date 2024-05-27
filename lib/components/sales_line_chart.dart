import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class SalesLineChart extends StatefulWidget {
  const SalesLineChart({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SalesLineChartState createState() => _SalesLineChartState();
}

class _SalesLineChartState extends State<SalesLineChart>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _hasAnimated = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _triggerAnimation() {
    if (!_hasAnimated) {
      _controller.forward();
      _hasAnimated = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: const Key('sales_line_chart'),
      onVisibilityChanged: (visibilityInfo) {
        if (visibilityInfo.visibleFraction > 0.1) {
          _triggerAnimation();
        }
      },
      child: SizedBox(
        height: 260,
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: LineChart(
                LineChartData(
                  lineBarsData: [
                    LineChartBarData(
                      spots: _getAnimatedChartData(),
                      isCurved: true,
                      curveSmoothness: 0.5,
                      barWidth: 3,
                      color: Colors.black,
                      belowBarData: BarAreaData(show: false),
                      dotData: const FlDotData(show: false),
                    ),
                  ],
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          switch (value.toInt()) {
                            case 0:
                              return const Padding(
                                padding: EdgeInsets.only(top: 10.0),
                                child: Text('JAN',
                                    style: TextStyle(
                                        fontSize: 11, color: Colors.grey)),
                              );
                            case 2:
                              return const Padding(
                                padding: EdgeInsets.only(top: 10.0),
                                child: Text('MAR',
                                    style: TextStyle(
                                        fontSize: 11, color: Colors.grey)),
                              );
                            case 4:
                              return const Padding(
                                padding: EdgeInsets.only(top: 10.0),
                                child: Text('MAY',
                                    style: TextStyle(
                                        fontSize: 11, color: Colors.grey)),
                              );
                            case 6:
                              return const Padding(
                                padding: EdgeInsets.only(top: 10.0),
                                child: Text('JUL',
                                    style: TextStyle(
                                        fontSize: 11, color: Colors.grey)),
                              );
                            case 8:
                              return const Padding(
                                padding: EdgeInsets.only(top: 10.0),
                                child: Text('SEP',
                                    style: TextStyle(
                                        fontSize: 11, color: Colors.grey)),
                              );
                          }
                          return const Text('');
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            '\$${value.toInt()}',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 10,
                            ),
                          );
                        },
                        reservedSize: 40,
                      ),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  gridData: FlGridData(
                    show: true,
                    drawHorizontalLine: true,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        color: Colors.grey.withOpacity(0.2),
                        strokeWidth: 1,
                      );
                    },
                    drawVerticalLine: false,
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border(
                      left: BorderSide.none,
                      bottom: BorderSide(
                          color: Colors.grey.withOpacity(0.5), width: 1),
                    ),
                  ),
                  lineTouchData: LineTouchData(
                    touchTooltipData: LineTouchTooltipData(
                      tooltipPadding: const EdgeInsets.all(8),
                      tooltipMargin: 8,
                      getTooltipItems: (List<LineBarSpot> touchedSpots) {
                        return touchedSpots.map((spot) {
                          return LineTooltipItem(
                            '${spot.y}',
                            const TextStyle(color: Colors.white),
                          );
                        }).toList();
                      },
                    ),
                    touchCallback:
                        (FlTouchEvent event, LineTouchResponse? response) {},
                    handleBuiltInTouches: true,
                    getTouchedSpotIndicator:
                        (LineChartBarData barData, List<int> indicators) {
                      return indicators.map((int index) {
                        final line = FlLine(
                          color: Colors.grey.withOpacity(0.6),
                          strokeWidth: 1,
                        );
                        final dot = FlDotData(
                          show: true,
                          getDotPainter: (spot, percent, barData, index) =>
                              FlDotCirclePainter(
                            radius: 3,
                            color: Colors.black,
                            strokeWidth: 0,
                          ),
                        );
                        return TouchedSpotIndicatorData(line, dot);
                      }).toList();
                    },
                  ),
                  minX: 0,
                  maxX: 9.5,
                  minY: 0,
                  maxY: 150,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  List<FlSpot> _getChartData() {
    return [
      const FlSpot(0, 10),
      const FlSpot(1, 40),
      const FlSpot(2, 70),
      const FlSpot(3, 50),
      const FlSpot(4, 90),
      const FlSpot(5, 40),
      const FlSpot(6, 120),
      const FlSpot(7, 60),
      const FlSpot(8, 140),
      const FlSpot(9, 100),
    ];
  }

  List<FlSpot> _getAnimatedChartData() {
    final chartData = _getChartData();
    final currentProgress = _animation.value * (chartData.length - 1);
    final lastIndex = currentProgress.floor();
    final nextIndex =
        (currentProgress == lastIndex) ? lastIndex : lastIndex + 1;
    final partialProgress = (currentProgress - lastIndex).clamp(0.0, 1.0);

    List<FlSpot> animatedData = [];
    for (int i = 0; i <= lastIndex; i++) {
      animatedData.add(chartData[i]);
    }

    if (nextIndex < chartData.length) {
      final start = chartData[lastIndex];
      final end = chartData[nextIndex];
      final interpolatedX = start.x + (end.x - start.x) * partialProgress;
      final interpolatedY = start.y + (end.y - start.y) * partialProgress;
      animatedData.add(FlSpot(interpolatedX, interpolatedY));
    }

    return animatedData;
  }
}
