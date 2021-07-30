import 'package:crypto_wallet/shared/models/trade_model.dart';
import 'package:flutter/material.dart';

class TradesDetails extends StatelessWidget {
  const TradesDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final trade = ModalRoute.of(context)!.settings.arguments as TradeModel;

    return Scaffold(
      appBar: AppBar(
        title: Text('Trade Details'),
      ),
      body: Column(
        children: [
          Text(trade.crypto),
          Text(trade.date.toString()),
          Text(trade.price.toString()),
          Text(trade.amount.toString()),
          Text(trade.amountInvested.toString()),
          Text(trade.fee.toString()),
          Text(trade.operationType.toString()),
        ],
      ),
    );
  }
}
