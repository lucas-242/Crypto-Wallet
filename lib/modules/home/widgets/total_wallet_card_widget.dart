import 'package:crypto_wallet/shared/models/dashboard_model.dart';
import 'package:crypto_wallet/shared/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TotalWalletCard extends StatelessWidget {
  final DashboardModel dashboardData;
  const TotalWalletCard({Key? key, required this.dashboardData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            NumberFormat.currency(symbol: '\$').format(dashboardData.total),
            style: AppTextStyles.titleHome,
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${dashboardData.variation.isNegative ? '' : '+'} ${NumberFormat.currency(symbol: '\$').format(dashboardData.variation)} (${NumberFormat.decimalPercentPattern(decimalDigits: 1).format(dashboardData.percentVariation / 100)})',
                style: AppTextStyles.titleRegular,
              ),
              Icon(
                  dashboardData.variation.isNegative
                      ? Icons.arrow_downward
                      : Icons.arrow_upward,
                  color: dashboardData.variation.isNegative
                      ? AppColors.red
                      : AppColors.secondary),
            ],
          )
        ],
      ),
    );
  }
}
