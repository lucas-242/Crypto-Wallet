import 'package:crypto_wallet/modules/home/home.dart';
import 'package:crypto_wallet/shared/models/enums/status_page.dart';
import 'package:crypto_wallet/shared/widgets/donut_chart/donut_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatefulWidget {
  final HomeBloc bloc;
  const Chart({Key? key, required this.bloc}) : super(key: key);

  @override
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<HomeStatus>(
      valueListenable: widget.bloc.statusNotifier,
      builder: (context, status, child) {
        if (status.statusPage == StatusPage.success) {
          return Row(
            children: [
              DonutChart(
                data: widget.bloc.dashboardData.cryptosSummary
                    .asMap()
                    .entries
                    .map((e) => DonutChartModel(
                        percent: e.value.percent,
                        color: widget.bloc.chartColors[e.key]))
                    .toList(),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: widget.bloc.dashboardData.cryptosSummary
                        .asMap()
                        .entries
                        .map(
                      (e) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Indicator(
                            color: widget.bloc.chartColors[e.key],
                            text:
                                '${e.value.crypto} (${NumberFormat.decimalPercentPattern(decimalDigits: 1).format(e.value.percent / 100)})',
                            subtext: e.value.amount.toStringAsFixed(8),
                          ),
                        );
                      },
                    ).toList()),
              ),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}
