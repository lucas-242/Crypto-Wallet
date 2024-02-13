import 'package:crypto_wallet/core/routes/routes.dart';
import 'package:crypto_wallet/presenter/trades/components/trade_tile_list.dart';
import 'package:crypto_wallet/presenter/trades/cubit/trades_cubit.dart';
import 'package:crypto_wallet/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TradesContent extends StatelessWidget {
  const TradesContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppInsets.md),
      child: Column(
        children: [
          // CustomDropdown(
          //   label: bloc.appLocalizations.filter,
          //   hint: bloc.appLocalizations.hintFieldCrypto,
          //   items: bloc.cryptoList,
          //   selectedItem: bloc.filterSelected,
          //   onChanged: (DropdownItem? item) => bloc.onFilter(item),
          //   showSeach: true,
          //   searchHint: 'BTC, ETH, ADA ...',
          // ),
          AppSpacings.verticalMd,
          Expanded(
            child: TradeTileList(
              onRefresh: () async {},
              onTap: (trade) {
                context.read<TradesCubit>().onSelectTrade(trade);
                context.pushTo('${Routes.trades}/${trade.id}');
              },
              onDelete: (_) {},
            ),
          ),
        ],
      ),
    );
  }
}
