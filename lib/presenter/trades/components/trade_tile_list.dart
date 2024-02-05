import 'package:crypto_wallet/domain/models/trade.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TradeTileList extends StatelessWidget {
  const TradeTileList({
    super.key,
    required this.onRefresh,
    required this.onTap,
    required this.onDelete,
  });

  final Future<void> Function() onRefresh;
  final void Function(Trade trade) onTap;
  final void Function(Trade trade) onDelete;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    Widget getAd(int dateIndex) => (dateIndex != 0 && dateIndex % 2 == 0)
        ? Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: SizedBox(
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
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Column(
                  children: [
                    SizedBox(
                      width: SizeConfig.width,
                      child: Text(DateFormat.yMd().format(date),
                          textAlign: TextAlign.left,
                          style: textTheme.titleSmall),
                    ),
                    const Divider(),
                  ],
                ),
              ),
              SizedBox(
                height: 75 * bloc.getTradesByDate(date).length.toDouble(),
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
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
                          const Divider(),
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
