import 'package:crypto_wallet/blocs/wallet/wallet.dart';
import 'package:crypto_wallet/modules/insert_trade/insert_trade.dart';
import 'package:crypto_wallet/repositories/wallet_repository/wallet_repository.dart';
import 'package:crypto_wallet/shared/constants/cryptos.dart';
import 'package:crypto_wallet/shared/models/enums/status_page.dart';
import 'package:crypto_wallet/shared/constants/trade_type.dart';
import 'package:crypto_wallet/shared/themes/themes.dart';
import 'package:crypto_wallet/shared/widgets/app_bar/custom_app_bar_widget.dart';
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
      appBar: CustomAppBar(
        title: 'Register Trade',
        leading: BackButton(color: AppColors.primary),
      ),
      backgroundColor: AppColors.background,
      body: Padding(
        padding: EdgeInsets.only(left: 25, right: 25, top: 20, bottom: 5),
        child: ValueListenableBuilder<InsertTradeStatus>(
            valueListenable: bloc.statusNotifier,
            builder: (context, status, child) {
              if (status.statusPage == StatusPage.loading) {
                return Container(
                  height: SizeConfig.height * 0.8,
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              return SingleChildScrollView(
                child: Form(
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
                      SizedBox(height: 10),
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
                      SizedBox(height: 15),
                      CustomTextFormField(
                        labelText: 'Crypto amount',
                        icon: Icons.account_balance_wallet_outlined,
                        keyboardType: TextInputType.number,
                        controller: cryptoAmountController,
                        validator: bloc.validateCryptoAmount,
                        onChanged: (value) => bloc.onChange(
                            amount: cryptoAmountController.numberValue),
                      ),
                      SizedBox(height: 10),
                      CustomTextFormField(
                        labelText: 'Invested amount',
                        icon: Icons.savings_outlined,
                        keyboardType: TextInputType.number,
                        controller: tradedAmoutController,
                        validator: bloc.validateTradedAmount,
                        onChanged: (value) => bloc.onChange(
                            ammountInvested: tradedAmoutController.numberValue),
                      ),
                      SizedBox(height: 10),
                      CustomTextFormField(
                        labelText: 'Trade Price',
                        icon: Icons.attach_money_outlined,
                        keyboardType: TextInputType.number,
                        controller: priceController,
                        validator: bloc.validatePrice,
                        onChanged: (value) =>
                            bloc.onChange(price: priceController.numberValue),
                      ),
                      SizedBox(height: 10),
                      CustomTextFormField(
                        labelText: 'Date',
                        icon: Icons.calendar_today,
                        keyboardType: TextInputType.datetime,
                        controller: dateController,
                        validator: bloc.validateDate,
                        onChanged: (value) => bloc.onChange(date: value),
                      ),
                      SizedBox(height: 10),
                      CustomTextFormField(
                        labelText: 'Fee',
                        icon: Icons.money_off_sharp,
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
              );
            }),
      ),
      bottomNavigationBar: ValueListenableBuilder<InsertTradeStatus>(
        valueListenable: bloc.statusNotifier,
        builder: (context, status, child) {
          if (status.statusPage != StatusPage.loading) {
            return BottomButtons(
                fisrtLabel: 'Cancel',
                secondLabel: 'Save',
                firstButtonStyle: AppTextStyles.buttonGrey,
                secondButtonStyle: AppTextStyles.buttonPrimary,
                onPressedFirst: () => Navigator.of(context).pop(),
                onPressedSecond: () => onPressedSecondary());
          }

          return SizedBox();
        },
      ),
    );
  }
}
