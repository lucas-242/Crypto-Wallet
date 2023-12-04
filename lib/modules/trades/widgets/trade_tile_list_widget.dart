import 'package:crypto_wallet/shared/helpers/ad_helper.dart';
import 'package:crypto_wallet/shared/models/trade_model.dart';
import 'package:crypto_wallet/shared/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';

import '../trades.dart';

class TradeTileList extends StatelessWidget {
  final TradesBloc bloc;
  final Future<void> Function() onRefresh;
  final void Function(TradeModel trade) onTap;
  final void Function(TradeModel trade) onDelete;
  const TradeTileList({
    Key? key,
    required this.bloc,
    required this.onRefresh,
    required this.onTap,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    Widget getAd(int dateIndex) => (dateIndex != 0 && dateIndex % 2 == 0)
        ? Padding(
            padding: EdgeInsets.only(top: 12.0),
            child: Container(
              height: 50,
              child: AdWidget(
                  ad: AdHelper.bannerTradesList..load(), key: UniqueKey()),
            ),
          )
        : Container();

    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.builder(
        itemCount: bloc.dates.length,
        itemBuilder: (context, dateIndex) {
          final date = bloc.dates[dateIndex];
          return Column(
            children: [
              getAd(dateIndex),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Column(
                  children: [
                    Container(
                      width: SizeConfig.width,
                      child: Text(DateFormat.yMd().format(date),
                          textAlign: TextAlign.left,
                          style: textTheme.titleSmall),
                    ),
                    Divider(),
                  ],
                ),
              ),
              Container(
                height: 75 * bloc.getTradesByDate(date).length.toDouble(),
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: bloc.getTradesByDate(date).length,
                  itemBuilder: (context, index) {
                    final trades = bloc.getTradesByDate(date);
                    return Column(
                      children: [
                        TradeTile(
                          trade: trades[index],
                          onTap: (trade) => onTap(trade),
                          onDelete: (trade) => onDelete(trade),
                        ),
                        if (trades.length > 1 && index != trades.length - 1)
                          Divider(),
                      ],
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
