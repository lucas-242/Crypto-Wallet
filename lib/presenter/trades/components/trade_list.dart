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
        Expanded(
          child: Consumer<TradesBloc>(builder: (context, bloc, child) {
            return TradeTileList(
              bloc: bloc,
              onTap: (trade) => Navigator.pushNamed(
                context,
                AppRoutes.tradesDetails,
                arguments: {'trade': trade, 'uid': auth.user!.uid},
              ),
              onRefresh: () => bloc.getTrades(auth.user!.uid),
              onDelete: (trade) {
                final walletBloc = context.read<WalletBloc>();
                bloc
                    .onDelete(
                      trade: trade,
                      uid: auth.user!.uid,
                      walletBloc: walletBloc,
                    )
                    .then((value) => bloc.loadInterstitialAd());
              },
            );
          }),
        ),
      ],
    );
  }
}
