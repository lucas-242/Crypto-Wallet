import 'package:crypto_wallet/modules/insert_trade/insert_trade.dart';
import 'package:crypto_wallet/modules/wallet/wallet.dart';
import 'package:crypto_wallet/repositories/wallet_repository/wallet_repository.dart';
import 'package:crypto_wallet/shared/constants/cryptos.dart';
import 'package:crypto_wallet/shared/models/enums/status_page.dart';
import 'package:crypto_wallet/shared/constants/trade_type.dart';
import 'package:crypto_wallet/shared/themes/themes.dart';
import 'package:crypto_wallet/shared/widgets/bottom_buttons/bottom_buttons_widget.dart';
import 'package:crypto_wallet/shared/widgets/custom_dropdown_button/custom_dropdown_button.dart';
import 'package:crypto_wallet/shared/widgets/custom_text_form_field/custom_text_form_field_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:provider/provider.dart';

import '/modules/trades/trades.dart';

class InsertTradePage extends StatefulWidget {
  final WalletRepository walletRepository;
  const InsertTradePage({Key? key, required this.walletRepository})
      : super(key: key);

  @override
  _InsertTradePageState createState() => _InsertTradePageState();
}

class _InsertTradePageState extends State<InsertTradePage> {
  late final InsertTradeBloc bloc;
  late final String uid;

  final priceController =
      MoneyMaskedTextController(leftSymbol: '\$', decimalSeparator: '.');
  final tradedAmoutController =
      MoneyMaskedTextController(leftSymbol: '\$', decimalSeparator: '.');
  final cryptoAmountController =
      MoneyMaskedTextController(decimalSeparator: ',', precision: 8);
  final feeController =
      MoneyMaskedTextController(decimalSeparator: ',', precision: 8);
  final dateController = MaskedTextController(mask: '00/00/0000');

  @override
  void initState() {
    uid = FirebaseAuth.instance.currentUser!.uid;
    bloc = InsertTradeBloc(walletRepository: widget.walletRepository);

    bloc.onChange(user: uid);
    super.initState();
  }

  @override
  void dispose() {
    bloc.statusNotifier.dispose();
    super.dispose();
  }

  void onPressedSecondary() async {
    final tradesBloc = context.read<TradesBloc>();
    final walletBloc = context.read<WalletBloc>();
    await bloc
        .addTrade(tradesBloc: tradesBloc, walletBloc: walletBloc, uid: uid)
        .then((value) => Navigator.pop(context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: BackButton(color: AppColors.input),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: ValueListenableBuilder<InsertTradeStatus>(
                valueListenable: bloc.statusNotifier,
                builder: (context, status, child) {
                  if (status.statusPage == StatusPage.loading) {
                    return Container(
                      height: MediaQuery.of(context).size.height * 70,
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  return form();
                }),
          ),
        ),
      ),
      bottomNavigationBar: BottomButtons(
          primaryLabel: 'Cancel',
          secondaryLabel: 'Save',
          secondButtonColor: AppTextStyles.buttonSecondary,
          onPressedPrimary: () => Navigator.of(context).pop(),
          onPressedSecondary: () => onPressedSecondary()),
    );
  }

  Widget form() {
    return Column(
      children: [
        Text(
          'Fill all the fields of the trade',
          style: AppTextStyles.titleBoldGrey,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 25),
        Form(
          key: bloc.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text('Operation Type:'),
                  SizedBox(width: 30),
                  Expanded(
                    child: CustomDropdownButton(
                      value: bloc.trade.operationType,
                      items: TradeType.list,
                      onChanged: (value) {
                        bloc.onChange(operationType: value);
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text('Crypto:'),
                  SizedBox(width: 30),
                  Expanded(
                    child: CustomDropdownButton(
                      value: bloc.trade.crypto,
                      items: Cryptos.list,
                      onChanged: (value) {
                        bloc.onChange(crypto: value);
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              CustomTextFormField(
                labelText: 'Crypto amount',
                icon: Icons.plus_one,
                keyboardType: TextInputType.number,
                controller: cryptoAmountController,
                validator: bloc.validateCryptoAmount,
                onChanged: (value) =>
                    bloc.onChange(amount: cryptoAmountController.numberValue),
              ),
              CustomTextFormField(
                labelText: 'Invested amount',
                icon: Icons.attach_money,
                keyboardType: TextInputType.number,
                controller: tradedAmoutController,
                validator: bloc.validateTradedAmount,
                onChanged: (value) => bloc.onChange(
                    ammountInvested: tradedAmoutController.numberValue),
              ),
              CustomTextFormField(
                labelText: 'Trade Price',
                icon: Icons.attach_money,
                keyboardType: TextInputType.number,
                controller: priceController,
                validator: bloc.validatePrice,
                onChanged: (value) =>
                    bloc.onChange(price: priceController.numberValue),
              ),
              CustomTextFormField(
                labelText: 'Date',
                icon: Icons.calendar_today,
                keyboardType: TextInputType.datetime,
                controller: dateController,
                validator: bloc.validateDate,
                onChanged: (value) => bloc.onChange(date: value),
              ),
              CustomTextFormField(
                labelText: 'Fee',
                icon: Icons.attach_money,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                controller: feeController,
                onChanged: (value) =>
                    bloc.onChange(fee: feeController.numberValue),
              ),
              SizedBox(height: 25),
            ],
          ),
        ),
      ],
    );
  }
}
