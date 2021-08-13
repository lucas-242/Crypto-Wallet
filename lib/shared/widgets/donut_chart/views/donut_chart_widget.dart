import 'package:crypto_wallet/shared/themes/app_text_styles.dart';
import 'package:crypto_wallet/shared/themes/size_config.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import '../donut_chart.dart';

class DonutChart extends StatefulWidget {
  final List<DonutChartModel> data;

  DonutChart({required this.data});

  @override
  State<StatefulWidget> createState() => DonutChartState();
}

class DonutChartState extends State<DonutChart> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.height * 0.25,
      // width: SizeConfig.width * 0.37,
      width: SizeConfig.width * 5,
      child: PieChart(
        PieChartData(
          pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {
            setState(() {
              final desiredTouch =
                  pieTouchResponse.touchInput is! PointerExitEvent &&
                      pieTouchResponse.touchInput is! PointerUpEvent;
              if (desiredTouch && pieTouchResponse.touchedSection != null) {
                touchedIndex =
                    pieTouchResponse.touchedSection!.touchedSectionIndex;
              } else {
                touchedIndex = -1;
              }
            });
          }),
          borderData: FlBorderData(show: false),
          sectionsSpace: 10,
          centerSpaceRadius: 55,
          sections: showingSections(),
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(widget.data.length, (i) {
      final data = widget.data[i];
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 40.0 : 30.0;
      return PieChartSectionData(
        color: data.color,
        value: double.parse(data.percent.toStringAsFixed(2)),
        showTitle: true,
        radius: radius,
        titleStyle: AppTextStyles.captionBoldBody.copyWith(
          fontSize: fontSize,
        ),
      );
    });
  }
}
