import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '/blocs/wallet/wallet.dart';
import '/modules/insert_trade/insert_trade.dart';
import '/modules/trades/trades.dart';
import '/repositories/wallet_repository/wallet_repository.dart';
import '/shared/helpers/view_helper.dart';
import '/shared/helpers/wallet_helper.dart';
import '/shared/models/dropdown_item_model.dart';
import '/shared/models/enums/status_page.dart';
import '/shared/constants/trade_type.dart';
import '/shared/models/trade_model.dart';
import '/shared/services/cryptos_service.dart';
import '/shared/themes/themes.dart';
import '/shared/widgets/app_bar/custom_app_bar_widget.dart';
import '/shared/widgets/bottom_buttons/bottom_buttons_widget.dart';
import '/shared/widgets/custom_dropdown/custom_dropdown_widget.dart';
import '/shared/widgets/custom_text_form_field/custom_text_form_field_widget.dart';

class InsertTradePage extends StatefulWidget {
  final WalletRepository walletRepository;
  final CryptosService cryptosService;
  const InsertTradePage({
    Key? key,
    required this.walletRepository,
    required this.cryptosService,
  }) : super(key: key);

  @override
  _InsertTradePageState createState() => _InsertTradePageState();
}

class _InsertTradePageState extends State<InsertTradePage> {
  late final InsertTradeBloc bloc;
  late final String uid;

  final cryptoAmountController = TextEditingController();
  final tradedAmoutController = TextEditingController();
  final priceController = TextEditingController();
  final feeController = TextEditingController();
  final dateController =
      MaskedTextController(text: 'dd/MM/yyyy', mask: '00/00/0000');

  @override
  void initState() {
    uid = FirebaseAuth.instance.currentUser!.uid;
    bloc = InsertTradeBloc(
      walletRepository: widget.walletRepository,
      cryptosService: widget.cryptosService,
    );

    bloc.checkCryptoList();
    bloc.loadAd();
    bloc.onChangeField(user: uid);
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

  DropdownItem? getSelectedItem(TradeModel trade) {
    if (trade.cryptoId.isNotEmpty) {
      var crypto = WalletHelper.findCoin(bloc.trade.cryptoId);
      DropdownItem(
        text: '${crypto.symbol} - ${crypto.name}',
        value: crypto.id,
      );
    }

    return null;
  }

  void onSave() async {
    final tradesBloc = context.read<TradesBloc>();
    final walletBloc = context.read<WalletBloc>();
    await bloc
        .onSave(tradesBloc: tradesBloc, walletBloc: walletBloc, uid: uid)
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
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: CustomAppBar(
        title: bloc.appLocalizations.registerTrade,
        leading: BackButton(color: AppColors.primary),
      ),
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
                          CustomDropdown(
                            label: bloc.appLocalizations.operationType,
                            hint: bloc.appLocalizations.hintFieldOperationType,
                            items: TradeType.list
                                .map((e) => DropdownItem(
                                    value: e,
                                    text: ViewHelper.getTradeLabel(
                                        e, bloc.appLocalizations)))
                                .toList(),
                            onChanged: (DropdownItem? data) {
                              if (data != null) {
                                bloc.onChangeField(operationType: data.value);
                                setState(() {});
                              }
                            },
                            validator: (item) => bloc.validateDropdown(item),
                          ),
                          SizedBox(height: 25),
                          CustomDropdown(
                            label: bloc.appLocalizations.crypto,
                            hint: bloc.appLocalizations.hintFieldCrypto,
                            items: WalletHelper.coinsList
                                .map((e) => DropdownItem(
                                    text: '${e.symbol} - ${e.name}',
                                    auxValue: e.symbol,
                                    value: e.id))
                                .toList(),
                            selectedItem: getSelectedItem(bloc.trade),
                            onChanged: (DropdownItem? data) {
                              if (data != null) {
                                bloc.onChangeField(
                                    cryptoId: data.value,
                                    cryptoSymbol: data.auxValue);
                                setState(() {});
                              }
                            },
                            validator: (item) => bloc.validateDropdown(item),
                            showSeach: true,
                            searchHint: 'BTC, ETH, ADA ...',
                          ),
                          SizedBox(height: 25),
                          CustomTextFormField(
                            labelText: bloc.appLocalizations.cryptoAmount,
                            hintText: '0.00',
                            icon: Icons.account_balance_wallet_outlined,
                            keyboardType: TextInputType.number,
                            controller: cryptoAmountController,
                            validator: bloc.validateCryptoAmount,
                            onChanged: (value) {
                              var number =
                                  double.tryParse(cryptoAmountController.text);
                              tradedAmoutController.text =
                                  bloc.onChangeCryptoAmountOrPrice(
                                      amount: value.isEmpty
                                          ? 0
                                          : (number == null ? 0 : number));
                            },
                          ),
                          if (bloc.trade.operationType != TradeType.transfer)
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: CustomTextFormField(
                                labelText: bloc.appLocalizations.tradePrice,
                                hintText: '\$0.00',
                                icon: Icons.attach_money_outlined,
                                keyboardType: TextInputType.number,
                                controller: priceController,
                                validator: bloc.validateTradePrice,
                                onChanged: (value) {
                                  var number =
                                      double.tryParse(priceController.text);
                                  tradedAmoutController.text =
                                      bloc.onChangeCryptoAmountOrPrice(
                                          price: value.isEmpty
                                              ? 0
                                              : (number == null ? 0 : number));
                                },
                              ),
                            ),
                          if (bloc.trade.operationType != TradeType.transfer)
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: CustomTextFormField(
                                labelText:
                                    bloc.trade.operationType == TradeType.sell
                                        ? bloc.appLocalizations.soldAmount
                                        : bloc.appLocalizations.investedAmount,
                                hintText: '\$0.00',
                                icon: Icons.savings_outlined,
                                keyboardType: TextInputType.number,
                                controller: tradedAmoutController,
                                validator: bloc.validateTradedAmount,
                                onChanged: (value) {
                                  var number = double.tryParse(
                                      tradedAmoutController.text);
                                  bloc.onChangeField(
                                      amountDollars: value.isEmpty
                                          ? 0
                                          : (number == null ? 0 : number));
                                },
                              ),
                            ),
                          SizedBox(height: 10),
                          CustomTextFormField(
                            labelText: bloc.appLocalizations.fee,
                            hintText: '0.00',
                            icon: Icons.money_off_sharp,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.done,
                            controller: feeController,
                            validator: bloc.validateFee,
                            onChanged: (value) {
                              var number = double.tryParse(feeController.text);
                              bloc.onChangeField(
                                  fee: value.isEmpty
                                      ? 0
                                      : (number == null ? 0 : number));
                            },
                          ),
                          SizedBox(height: 10),
                          CustomTextFormField(
                            labelText: bloc.appLocalizations.date,
                            hintText: bloc.appLocalizations.hintFieldDate,
                            icon: Icons.calendar_today,
                            keyboardType: TextInputType.datetime,
                            controller: dateController,
                            validator: bloc.validateDate,
                            onChanged: (value) =>
                                bloc.onChangeField(date: value),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      bloc.appLocalizations.hintTrade,
                      style: textTheme.caption,
                    ),
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
                secondButtonStyle:
                    textTheme.button!.copyWith(color: AppColors.primary),
                onPressedFirst: () => Navigator.of(context).pop(),
                onPressedSecond: () => onSave());
          }

          return SizedBox();
        },
      ),
    );
  }
}
