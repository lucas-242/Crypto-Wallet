import 'package:crypto_wallet/shared/models/dashboard_model.dart';
import 'package:crypto_wallet/shared/themes/themes.dart';
import 'package:crypto_wallet/shared/extensions/string_extension.dart';
import 'package:crypto_wallet/shared/widgets/image_fade/image_fade_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

class CoinsSlide extends StatelessWidget {
  final DashboardModel dashboardData;
  const CoinsSlide({Key? key, required this.dashboardData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Text(
          'In your wallet',
          style: AppTextStyles.titleRegular,
        ),
        SizedBox(height: 15),
        Container(
          height: SizeConfig.height * 0.23,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: dashboardData.cryptosSummary.length,
              itemBuilder: (context, index) {
                var cryptoSummary = dashboardData.cryptosSummary[index];
                return Padding(
                  padding: EdgeInsets.only(
                      right: dashboardData.cryptosSummary.length == index + 1
                          ? 0
                          : 7),
                  child: Row(
                    children: [
                      Container(
                        width: SizeConfig.width * 0.36,
                        child: Card(
                          color: cryptoSummary.color,
                          elevation: 2,
                          child: Padding(
                            padding: EdgeInsets.all(15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ImageFade(image: cryptoSummary.image),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        '${cryptoSummary.crypto} - ${cryptoSummary.name.capitalize()}',
                                        style: AppTextStyles
                                            .captionBodyBackground),
                                    SizedBox(height: 5),
                                    Text(
                                      '${cryptoSummary.amount.toStringAsFixed(8)} ',
                                      style: AppTextStyles
                                          .captionBoldBodyBackground,
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      '${NumberFormat.decimalPercentPattern(decimalDigits: 1).format(cryptoSummary.percent / 100)}',
                                      style:
                                          AppTextStyles.captionBodyBackground,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }),
        ),
      ],
    );
  }
}
