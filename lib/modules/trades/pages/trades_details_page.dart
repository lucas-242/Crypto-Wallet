import 'package:crypto_wallet/blocs/wallet/wallet.dart';
import 'package:crypto_wallet/modules/trades/trades.dart';
import 'package:crypto_wallet/shared/constants/trade_type.dart';
import 'package:crypto_wallet/shared/models/enums/status_page.dart';
import 'package:crypto_wallet/shared/models/trade_model.dart';
import 'package:crypto_wallet/shared/themes/themes.dart';
import 'package:crypto_wallet/shared/widgets/app_bar/custom_app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../widgets/trade_details_row_widget.dart';

class TradesDetails extends StatefulWidget {
  const TradesDetails({Key? key}) : super(key: key);

  @override
  _TradesDetailsState createState() => _TradesDetailsState();
}

class _TradesDetailsState extends State<TradesDetails> {
  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final trade = arguments['trade'] as TradeModel;
    final bloc = context.watch<TradesBloc>();

    void _deleteTrade() {
      final walletBloc = context.read<WalletBloc>();
      bloc
          .deleteTrade(
        trade: trade,
        uid: arguments['uid'],
        walletBloc: walletBloc,
      )
          .then((value) {
        ScaffoldMessenger.of(context).showSnackBar(getAppSnackBar(
            message: 'Trade deleted successfully',
            type: SnackBarType.success,
            onClose: () =>
                ScaffoldMessenger.of(context).hideCurrentSnackBar()));
        Navigator.of(context).pop();
      });
    }

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Trade Details',
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
                    child:
                        Text(trade.crypto, style: AppTextStyles.titleRegular)),
                SizedBox(height: 25),
                TradeDetailsRow(
                  leftText: 'Type',
                  rightText: toBeginningOfSentenceCase(trade.operationType)!,
                  rightTextStyle: trade.operationType == TradeType.buy
                      ? AppTextStyles.captionBoldBody
                          .copyWith(color: AppColors.secondary)
                      : AppTextStyles.captionBoldBody
                          .copyWith(color: AppColors.red),
                ),
                SizedBox(height: 10),
                TradeDetailsRow(
                  leftText: 'Amount',
                  rightText: trade.amount.toStringAsFixed(8),
                ),
                SizedBox(height: 10),
                TradeDetailsRow(
                  leftText: 'Price',
                  rightText:
                      NumberFormat.currency(symbol: '\$').format(trade.price),
                ),
                SizedBox(height: 10),
                TradeDetailsRow(
                  leftText: 'Date',
                  rightText: DateFormat.yMd().format(trade.date),
                ),
                SizedBox(height: 10),
                Divider(),
                SizedBox(height: 10),
                TradeDetailsRow(
                  leftText: 'Fee',
                  rightText: trade.fee.toStringAsFixed(8),
                ),
                SizedBox(height: 10),
                TradeDetailsRow(
                  leftText: 'Total',
                  rightText: NumberFormat.currency(symbol: '\$')
                      .format(trade.amountInvested),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
