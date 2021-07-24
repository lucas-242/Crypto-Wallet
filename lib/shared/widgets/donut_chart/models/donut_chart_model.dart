import 'package:crypto_wallet/shared/themes/app_colors.dart';
import 'package:flutter/widgets.dart';

class DonutChartModel {
  double percent;
  Color color;

  DonutChartModel({this.percent = 0, Color? color})
      : this.color = color == null ? AppColors.primary : color;
}
