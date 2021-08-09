import 'package:crypto_wallet/shared/models/enums/status_page.dart';
import 'package:crypto_wallet/shared/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../home.dart';

class TotalWalletCard extends StatefulWidget {
  final HomeBloc bloc;
  const TotalWalletCard({Key? key, required this.bloc}) : super(key: key);

  @override
  _TotalWalletCardState createState() => _TotalWalletCardState();
}

class _TotalWalletCardState extends State<TotalWalletCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.shape,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 3,
      child: Padding(
        padding: EdgeInsets.all(30),
        child: ValueListenableBuilder<HomeStatus>(
            valueListenable: widget.bloc.statusNotifier,
            builder: (context, status, child) {
              if (status.statusPage == StatusPage.loading) {
                return Center(child: CircularProgressIndicator());
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Today',
                    style: AppTextStyles.titleRegular,
                  ),
                  SizedBox(height: 15),
                  Text(
                    NumberFormat.currency(symbol: '\$')
                        .format(widget.bloc.dashboardData.total),
                    style: AppTextStyles.titleHome,
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Text(
                        '${widget.bloc.dashboardData.variation.isNegative ? '' : '+'} ${NumberFormat.currency(symbol: '\$').format(widget.bloc.dashboardData.variation)} (${NumberFormat.decimalPercentPattern(decimalDigits: 1).format(widget.bloc.dashboardData.percentVariation / 100)})',
                        style: AppTextStyles.titleRegular,
                      ),
                      Icon(
                          widget.bloc.dashboardData.variation.isNegative
                              ? Icons.arrow_downward
                              : Icons.arrow_upward,
                          color: widget.bloc.dashboardData.variation.isNegative
                              ? AppColors.red
                              : AppColors.secondary),
                    ],
                  )
                ],
              );
            }),
      ),
    );
  }
}
