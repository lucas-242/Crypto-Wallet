import 'package:crypto_wallet/modules/insert_trade/insert_trade_status.dart';
import 'package:crypto_wallet/modules/wallet/wallet.dart';
import 'package:crypto_wallet/repositories/trades_repository.dart';
import 'package:crypto_wallet/shared/models/cryptos.dart';
import 'package:crypto_wallet/shared/models/status_page.dart';
import 'package:crypto_wallet/shared/models/trade_type.dart';
import 'package:crypto_wallet/shared/themes/themes.dart';
import 'package:crypto_wallet/shared/widgets/bottom_buttons/bottom_buttons_widget.dart';
import 'package:crypto_wallet/shared/widgets/custom_dropdown_button/custom_dropdown_button.dart';
import 'package:crypto_wallet/shared/widgets/custom_text_form_field/custom_text_form_field_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:provider/provider.dart';

import 'insert_trade_bloc.dart';

class InsertTradePage extends StatefulWidget {
  final TradesRepository tradesRepository;
  const InsertTradePage({Key? key, required this.tradesRepository})
      : super(key: key);

  @override
  _InsertTradePageState createState() => _InsertTradePageState();
}

class _InsertTradePageState extends State<InsertTradePage> {
  late final InsertTradeBloc bloc;

  final priceController =
      MoneyMaskedTextController(leftSymbol: '\$', decimalSeparator: '.');
  final amountController =
      MoneyMaskedTextController(decimalSeparator: ',', precision: 8);
  final dateController = MaskedTextController(mask: '00/00/0000');

  @override
  void initState() {
    final auth = FirebaseAuth.instance;
    bloc = InsertTradeBloc(tradesRepository: widget.tradesRepository);

    bloc.onChange(
      operationType: bloc.initialValueOperationType,
      crypto: bloc.initialValueCrypto,
      user: auth.currentUser!.uid,
    );
    super.initState();
  }

  @override
  void dispose() {
    bloc.statusNotifier.dispose();
    super.dispose();
  }

  void onPressedSecondary() async {
    final walletBloc = context.read<WalletBloc>();
    await bloc
        .addTrade(walletBloc)
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
                      height: MediaQuery.of(context).size.height,
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
                      value: bloc.initialValueOperationType,
                      items: [
                        DropdownOption(name: TradeType.BUY),
                        DropdownOption(name: TradeType.SELL),
                      ],
                      onChanged: (value) => bloc.onChange(operationType: value),
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
                      value: bloc.initialValueCrypto,
                      items: [
                        DropdownOption(name: Cryptos.BTC),
                      ],
                      onChanged: (value) => bloc.onChange(crypto: value),
                    ),
                  ),
                ],
              ),
              CustomTextFormField(
                labelText: 'Amount',
                icon: Icons.plus_one,
                keyboardType: TextInputType.number,
                controller: amountController,
                validator: bloc.validateAmount,
                onChanged: (value) =>
                    bloc.onChange(amount: amountController.numberValue),
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
                textInputAction: TextInputAction.done,
                controller: dateController,
                validator: bloc.validateDate,
                onChanged: (value) => bloc.onChange(date: value),
              ),
              SizedBox(height: 25),
            ],
          ),
        ),
      ],
    );
  }
}
