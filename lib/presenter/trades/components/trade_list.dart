import 'package:crypto_wallet/presenter/trades/components/trade_tile_list.dart';
import 'package:crypto_wallet/themes/settings/app_spacings.dart';
import 'package:flutter/material.dart';

class TradeList extends StatelessWidget {
  const TradeList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
        TradeTileList(onRefresh: () async {}, onTap: (_) {}, onDelete: (_) {}),
      ],
    );
  }
}
