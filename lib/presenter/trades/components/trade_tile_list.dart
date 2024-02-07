import 'package:crypto_wallet/domain/models/trade.dart';
import 'package:crypto_wallet/presenter/trades/components/trade_tile.dart';
import 'package:crypto_wallet/presenter/trades/cubit/trades_cubit.dart';
import 'package:crypto_wallet/themes/extensions/size_extensions.dart';
import 'package:crypto_wallet/themes/extensions/typography_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    final cubit = context.read<TradesCubit>();

    // Widget getAd(int dateIndex) => (dateIndex != 0 && dateIndex % 2 == 0)
    //     ? Padding(
    //         padding: const EdgeInsets.only(top: 12.0),
    //         child: SizedBox(
    //           height: 50,
    //           child: AdWidget(
    //               ad: AdHelper.bannerTradesList..load(), key: UniqueKey()),
    //         ),
    //       )
    //     : Container();

    return RefreshIndicator(
      onRefresh: cubit.getTrades,
      child: ListView.builder(
        itemCount: cubit.state.dates.length,
        itemBuilder: (context, dateIndex) {
          final date = cubit.state.dates[dateIndex];
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Column(
                  children: [
                    SizedBox(
                      width: context.width,
                      child: Text(
                        DateFormat.yMd().format(date),
                        textAlign: TextAlign.left,
                        style: context.textSubtitleSm,
                      ),
                    ),
                    const Divider(),
                  ],
                ),
              ),
              SizedBox(
                height: 75 * cubit.getTradesByDate(date).length.toDouble(),
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: cubit.getTradesByDate(date).length,
                  itemBuilder: (context, index) {
                    final trades = cubit.getTradesByDate(date);
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
