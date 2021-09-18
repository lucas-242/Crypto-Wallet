import 'package:crypto_wallet/blocs/wallet/wallet.dart';
import 'package:crypto_wallet/modules/trades/trades.dart';
import 'package:crypto_wallet/shared/helpers/trade_helper.dart';
import 'package:crypto_wallet/shared/helpers/wallet_helper.dart';
import 'package:crypto_wallet/shared/models/enums/status_page.dart';
import 'package:crypto_wallet/shared/models/trade_model.dart';
import 'package:crypto_wallet/shared/themes/themes.dart';
import 'package:crypto_wallet/shared/widgets/app_bar/custom_app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../widgets/trade_details_row_widget.dart';

class TradesDetails extends StatefulWidget {
  const TradesDetails({Key? key}) : super(key: key);

  @override
  _TradesDetailsState createState() => _TradesDetailsState();
}

class _TradesDetailsState extends State<TradesDetails> {
  late Map<String, dynamic> arguments;
  late TradeModel trade;
  late final TradesBloc bloc;
  late AppLocalizations appLocalizations;

  @override
  void initState() {
    bloc = context.read<TradesBloc>();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    appLocalizations = AppLocalizations.of(context)!;
  }

  void _deleteTrade() {
    final walletBloc = context.read<WalletBloc>();
    bloc
        .deleteTrade(
      trade: trade,
      uid: arguments['uid'],
      walletBloc: walletBloc,
    )
        .then((value) {
      // ScaffoldMessenger.of(context).showSnackBar(getAppSnackBar(
      //     message: 'Trade deleted successfully',
      //     type: SnackBarType.success,
      //     onClose: () => ScaffoldMessenger.of(context).hideCurrentSnackBar()));
      bloc.loadAd();
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    trade = arguments['trade'] as TradeModel;

    return Scaffold(
      appBar: CustomAppBar(
        title: appLocalizations.tradeDetails,
        leading: BackButton(color: AppColors.primary),
        actions: [
          TextButton(
            onPressed: () => _deleteTrade(),
            child: Icon(Icons.delete, color: AppColors.primary, size: 20),
          ),
        ],
      ),
      body: ValueListenableBuilder<TradesStatus>(
        valueListenable: bloc.statusNotifier,
        builder: (context, status, widget) {
          if (status.statusPage == StatusPage.loading) {
            return Container(
              height: SizeConfig.height,
              child: Center(child: CircularProgressIndicator()),
            );
          } else if (status.statusPage == StatusPage.error) {
            return Container(
              height: SizeConfig.height,
              child: Center(child: Text(status.error)),
            );
          }

          return Padding(
            padding: EdgeInsets.only(top: 25, left: 25, right: 25),
            child: Column(
              children: [
                Center(
                    child: Text(trade.cryptoSymbol,
                        style: AppTextStyles.title)),
                SizedBox(height: 25),
                TradeDetailsRow(
                  leftText: appLocalizations.operationType,
                  rightText: toBeginningOfSentenceCase(
                      TradeTypeHelper.getTradeLabel(trade.operationType, appLocalizations))!,
                  rightTextStyle: TradeTypeHelper.getTradeColor(trade),
                ),
                SizedBox(height: 10),
                TradeDetailsRow(
                  leftText: appLocalizations.cryptoAmount,
                  rightText: trade.amount.toStringAsFixed(8),
                ),
                SizedBox(height: 10),
                TradeDetailsRow(
                  leftText: appLocalizations.tradePrice,
                  rightText: NumberFormat.currency(
                    symbol: '\$',
                    decimalDigits: WalletHelper.getDecimalDigits(trade.price),
                  ).format(trade.price),
                ),
                SizedBox(height: 10),
                TradeDetailsRow(
                  leftText: appLocalizations.date,
                  rightText: DateFormat.yMd().format(trade.date),
                ),
                SizedBox(height: 10),
                Divider(),
                SizedBox(height: 10),
                TradeDetailsRow(
                  leftText: appLocalizations.fee,
                  rightText: trade.fee.toStringAsFixed(8),
                ),
                SizedBox(height: 10),
                TradeDetailsRow(
                  leftText: appLocalizations.total,
                  rightText: NumberFormat.currency(
                    symbol: '\$',
                    decimalDigits: WalletHelper.getDecimalDigits(trade.price),
                  ).format(trade.amountDollars),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
