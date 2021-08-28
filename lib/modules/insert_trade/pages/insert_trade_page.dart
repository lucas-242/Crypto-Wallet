import 'package:crypto_wallet/blocs/wallet/wallet.dart';
import 'package:crypto_wallet/modules/insert_trade/insert_trade.dart';
import 'package:crypto_wallet/repositories/wallet_repository/wallet_repository.dart';
import 'package:crypto_wallet/shared/constants/cryptos.dart';
import 'package:crypto_wallet/shared/helpers/wallet_helper.dart';
import 'package:crypto_wallet/shared/models/dropdown_item_model.dart';
import 'package:crypto_wallet/shared/models/enums/status_page.dart';
import 'package:crypto_wallet/shared/constants/trade_type.dart';
import 'package:crypto_wallet/shared/themes/themes.dart';
import 'package:crypto_wallet/shared/widgets/app_bar/custom_app_bar_widget.dart';
import 'package:crypto_wallet/shared/widgets/bottom_buttons/bottom_buttons_widget.dart';
import 'package:crypto_wallet/shared/widgets/custom_text_form_field/custom_text_form_field_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:dropdown_search/dropdown_search.dart';

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

  //TODO: Decimal Separator according to the language and crypto
  final priceController = MoneyMaskedTextController(
    leftSymbol: '\$',
    decimalSeparator: ',',
    precision: WalletHelper.decimalDigitsToSmallCryptos,
  );
  final tradedAmoutController = MoneyMaskedTextController(
    leftSymbol: '\$',
    decimalSeparator: ',',
    precision: WalletHelper.decimalDigitsToSmallCryptos,
  );
  final cryptoAmountController =
      MoneyMaskedTextController(decimalSeparator: ',', precision: 8);
  final feeController =
      MoneyMaskedTextController(decimalSeparator: ',', precision: 8);
  final dateController =
      MaskedTextController(text: 'dd/MM/yyyy', mask: '00/00/0000');

  @override
  void initState() {
    uid = FirebaseAuth.instance.currentUser!.uid;
    bloc = InsertTradeBloc(walletRepository: widget.walletRepository);

    bloc.loadAd();
    bloc.onChange(user: uid);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc.appLocalizations = AppLocalizations.of(context)!;
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  void onSave() async {
    final tradesBloc = context.read<TradesBloc>();
    final walletBloc = context.read<WalletBloc>();
    await bloc
        .addTrade(tradesBloc: tradesBloc, walletBloc: walletBloc, uid: uid)
        .then((value) => Navigator.pop(context))
        .catchError((error) {
      if (error.message == bloc.appLocalizations.errorInsufficientBalance) {
        ScaffoldMessenger.of(context).showSnackBar(getAppSnackBar(
          message: error.message,
          type: SnackBarType.error,
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: bloc.appLocalizations.registerTrade,
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Form(
                      key: bloc.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DropdownSearch<DropdownItem>(
                            label: bloc.appLocalizations.operationType,
                            mode: Mode.BOTTOM_SHEET,
                            maxHeight: SizeConfig.height * 0.15,
                            selectedItem: bloc.trade.operationType.isNotEmpty
                                ? DropdownItem(
                                    value: bloc.trade.operationType,
                                    text: bloc.trade.operationType ==
                                            TradeType.buy
                                        ? bloc.appLocalizations.buy
                                        : bloc.appLocalizations.sell)
                                : null,
                            items: TradeType.list
                                .map((e) => DropdownItem(
                                    value: e,
                                    text: e == TradeType.buy
                                        ? bloc.appLocalizations.buy
                                        : bloc.appLocalizations.sell))
                                .toList(),
                            itemAsString: (DropdownItem u) => u.text,
                            onChanged: (DropdownItem? data) {
                              if (data != null) {
                                bloc.onChange(operationType: data.value);
                                setState(() {});
                              }
                            },
                            validator: (item) => bloc.validateCrypto(item),
                            dropdownBuilder: (_, item, value) =>
                                _dropdownBuilder(
                              value: value,
                              hint:
                                  bloc.appLocalizations.hintFieldOperationType,
                            ),
                            dropdownButtonBuilder: (_) =>
                                _dropdownButtonBuilder(),
                          ),
                          SizedBox(height: 10),
                          DropdownSearch<DropdownItem>(
                            label: bloc.appLocalizations.crypto,
                            mode: Mode.BOTTOM_SHEET,
                            selectedItem: bloc.trade.crypto.isNotEmpty
                                ? DropdownItem(
                                    text:
                                        '${bloc.trade.crypto} - ${Cryptos.names[bloc.trade.crypto]}',
                                    value: bloc.trade.crypto,
                                  )
                                : null,
                            items: Cryptos.list
                                .map((e) => DropdownItem(
                                    text: '$e - ${Cryptos.names[e]}', value: e))
                                .toList(),
                            itemAsString: (DropdownItem u) => u.text,
                            onChanged: (DropdownItem? data) {
                              if (data != null) {
                                bloc.onChange(crypto: data.value);
                                setState(() {});
                              }
                            },
                            showSearchBox: true,
                            validator: (item) => bloc.validateCrypto(item),
                            dropdownBuilder: (_, item, value) =>
                                _dropdownBuilder(
                                    value: value,
                                    hint:
                                        bloc.appLocalizations.hintFieldCrypto),
                            dropdownButtonBuilder: (_) =>
                                _dropdownButtonBuilder(),
                          ),
                          SizedBox(height: 15),
                          CustomTextFormField(
                            labelText: bloc.appLocalizations.cryptoAmount,
                            icon: Icons.account_balance_wallet_outlined,
                            keyboardType: TextInputType.number,
                            controller: cryptoAmountController,
                            validator: bloc.validateCryptoAmount,
                            onChanged: (value) => bloc.onChange(
                                amount: cryptoAmountController.numberValue),
                          ),
                          SizedBox(height: 10),
                          CustomTextFormField(
                            labelText:
                                bloc.trade.operationType == TradeType.sell
                                    ? bloc.appLocalizations.soldAmount
                                    : bloc.appLocalizations.investedAmount,
                            icon: Icons.savings_outlined,
                            keyboardType: TextInputType.number,
                            controller: tradedAmoutController,
                            validator: bloc.validateTradedAmount,
                            onChanged: (value) => bloc.onChange(
                                ammountInvested:
                                    tradedAmoutController.numberValue),
                          ),
                          SizedBox(height: 10),
                          CustomTextFormField(
                            labelText: bloc.appLocalizations.tradePrice,
                            icon: Icons.attach_money_outlined,
                            keyboardType: TextInputType.number,
                            controller: priceController,
                            validator: bloc.validateTradePrice,
                            onChanged: (value) => bloc.onChange(
                                price: priceController.numberValue),
                          ),
                          SizedBox(height: 10),
                          CustomTextFormField(
                            labelText: bloc.appLocalizations.date,
                            hintText: bloc.appLocalizations.hintFieldDate,
                            icon: Icons.calendar_today,
                            keyboardType: TextInputType.datetime,
                            controller: dateController,
                            validator: bloc.validateDate,
                            onChanged: (value) => bloc.onChange(date: value),
                          ),
                          SizedBox(height: 10),
                          CustomTextFormField(
                            labelText: bloc.appLocalizations.fee,
                            icon: Icons.money_off_sharp,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.done,
                            controller: feeController,
                            onChanged: (value) =>
                                bloc.onChange(fee: feeController.numberValue),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(bloc.appLocalizations.hintTrade,
                        style: AppTextStyles.input),
                  ],
                ),
              );
            }),
      ),
      bottomNavigationBar: ValueListenableBuilder<InsertTradeStatus>(
        valueListenable: bloc.statusNotifier,
        builder: (context, status, child) {
          if (status.statusPage != StatusPage.loading) {
            return BottomButtons(
                fisrtLabel: bloc.appLocalizations.cancel,
                secondLabel: bloc.appLocalizations.save,
                firstButtonStyle: AppTextStyles.buttonGrey,
                secondButtonStyle: AppTextStyles.buttonPrimary,
                onPressedFirst: () => Navigator.of(context).pop(),
                onPressedSecond: () => onSave());
          }

          return SizedBox();
        },
      ),
    );
  }

  Widget _dropdownBuilder({String? value, String hint = ''}) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Container(
          child: Text(
            value == null || value == '' ? hint : value,
            style: AppTextStyles.input,
          ),
        ),
      );

  Widget _dropdownButtonBuilder() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Icon(
          Icons.arrow_drop_down,
          size: 24,
          color: AppColors.text,
        ),
      );
}
