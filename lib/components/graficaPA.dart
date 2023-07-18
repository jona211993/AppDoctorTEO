import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
class PresionArterialChart extends StatelessWidget {
  final List<double> sistoleData;
  final List<double> diastoleData;

  PresionArterialChart({required this.sistoleData, required this.diastoleData});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.5,
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.all(16.0),
        child: LineChart(
          LineChartData(
            lineTouchData: LineTouchData(
              touchTooltipData: LineTouchTooltipData(
                tooltipBgColor: Colors.blue.withOpacity(0.8),
                getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                  return touchedBarSpots.map((barSpot) {
                    final double y = barSpot.y;
                    return LineTooltipItem(
                      y.toStringAsFixed(2),
                      TextStyle(
                        color: Colors.black, // Color de fuente negro
                        fontSize: 12.0,
                      ).copyWith(fontSize: 12.0 * 0.7),
                    );
                  }).toList();
                },
              ),
            ),
            gridData: FlGridData(show: true, drawVerticalLine: true, drawHorizontalLine: true),
            titlesData: FlTitlesData(show: false),
            borderData: FlBorderData(show: true, border: Border.all(color: Colors.grey)),
            lineBarsData: [
              LineChartBarData(
                spots: _generateSpots(sistoleData),
                isCurved: true,
                color: Colors.blue,
                barWidth: 2,
              ),
              LineChartBarData(
                spots: _generateSpots(diastoleData),
                isCurved: true,
                color: Colors.red,
                barWidth: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<FlSpot> _generateSpots(List<double> data) {
    return data
        .asMap()
        .entries
        .map((entry) => FlSpot(entry.key.toDouble(), entry.value))
        .toList();
  }
}
