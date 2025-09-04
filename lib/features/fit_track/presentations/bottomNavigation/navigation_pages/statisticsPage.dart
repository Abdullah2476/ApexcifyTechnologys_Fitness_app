import 'package:fit_track/features/core/theme/app_colors.dart';
import 'package:fit_track/features/fit_track/providers/bottomnavigation_provider/stat_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BarChartWidget extends StatelessWidget {
  final List<BarChartGroupData> barGroups;

  const BarChartWidget({super.key, required this.barGroups});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.5,
      child: BarChart(
        BarChartData(
          barGroups:
              barGroups
                  .map(
                    (group) => BarChartGroupData(
                      x: group.x,
                      barRods:
                          group.barRods
                              .map(
                                (rod) => BarChartRodData(
                                  toY: rod.toY,
                                  color: Colors.yellow,
                                  width: rod.width,
                                  borderRadius: rod.borderRadius,
                                ),
                              )
                              .toList(),
                      showingTooltipIndicators: group.showingTooltipIndicators,
                    ),
                  )
                  .toList(),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  const style = TextStyle(color: Colors.white, fontSize: 10);
                  switch (value.toInt()) {
                    case 0:
                      return Text('Mon', style: style);
                    case 1:
                      return Text('Tue', style: style);
                    case 2:
                      return Text('Wed', style: style);
                    case 3:
                      return Text('Thu', style: style);
                    case 4:
                      return Text('Fri', style: style);
                    case 5:
                      return Text('Sat', style: style);
                    case 6:
                      return Text('Sun', style: style);
                    default:
                      return const Text('');
                  }
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  return Text(
                    value.toInt().toString(),
                    style: const TextStyle(color: Colors.white, fontSize: 10),
                  );
                },
                interval: 200,
                reservedSize: 32,
              ),
            ),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          gridData: FlGridData(show: true),
          barTouchData: BarTouchData(enabled: true),
        ),
      ),
    );
  }
}

class Statisticspage extends ConsumerWidget {
  const Statisticspage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stepDataAsync = ref.watch(stepDataProvider);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: SweepGradient(
            startAngle: 0,
            endAngle: 35,
            center: Alignment.topRight,
            tileMode: TileMode.decal,
            colors: [AppColors.black, AppColors.yelow],
          ),
        ),
        child: stepDataAsync.when(
          data: (barGroups) {
            if (barGroups.isEmpty) {
              return const Center(
                child: Text(
                  'No step data found',
                  style: TextStyle(color: AppColors.white),
                ),
              );
            }
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: BarChartWidget(barGroups: barGroups),
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(child: Text('Error: $error')),
        ),
      ),
    );
  }
}
