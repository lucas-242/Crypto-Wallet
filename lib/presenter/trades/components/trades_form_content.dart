import 'package:crypto_wallet/core/components/custom_dropdown/custom_dropdown.dart';
import 'package:crypto_wallet/core/components/custom_text_form_field/custom_text_form_field_widget.dart';
import 'package:crypto_wallet/core/components/status_pages/status_pages.dart';
import 'package:crypto_wallet/core/l10n/l10n.dart';
import 'package:crypto_wallet/core/routes/routes.dart';
import 'package:crypto_wallet/core/utils/base_state.dart';
import 'package:crypto_wallet/core/utils/form_validator.dart';
import 'package:crypto_wallet/core/utils/wallet_utils.dart';
import 'package:crypto_wallet/domain/data/cryptos.dart';
import 'package:crypto_wallet/domain/models/dropdown_item.dart';
import 'package:crypto_wallet/domain/models/enums/trade_type.dart';
import 'package:crypto_wallet/presenter/trades/cubit/trades_form_cubit.dart';
import 'package:crypto_wallet/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TradesFormContent extends StatefulWidget {
  const TradesFormContent({super.key});

  @override
  State<TradesFormContent> createState() => _TradesFormContentState();
}

class _TradesFormContentState extends State<TradesFormContent> {
  final formKey = GlobalKey<FormState>();

  final cryptoAmountController = TextEditingController();
  final tradedAmoutController = TextEditingController();
  final priceController = TextEditingController();
  final dateController = TextEditingController();
  final feeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TradesFormCubit>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppInsets.md),
      child: Builder(
        builder: (context) {
          return BlocConsumer<TradesFormCubit, TradesFormState>(
            listenWhen: (previous, current) =>
                previous.status != current.status,
            listener: (context, state) {
              if (state.status == BaseStateStatus.success) {
                return context.pop();
              }

              if (state.status == BaseStateStatus.error) {
                return context.showSnackBar(state.callbackMessage);
              }
            },
            builder: (context, state) => state.when(
              onState: (_) => SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomDropdown(
                            label: AppLocalizations.current.operationType,
                            hint:
                                AppLocalizations.current.hintFieldOperationType,
                            items: TradeType.list
                                .map((t) => DropdownItem(
                                      value: t,
                                      label: WalletUtils.getTradeLabel(t),
                                    ))
                                .toList(),
                            onChanged: (data) =>
                                cubit.onChangeField(operationType: data?.value),
                            validator: (item) =>
                                FormValidator.validateDropdown(item),
                          ),
                          AppSpacings.verticalLg,
                          CustomDropdown(
                            label: AppLocalizations.current.crypto,
                            hint: AppLocalizations.current.hintFieldCrypto,
                            items: Cryptos.supported
                                .map((e) => DropdownItem(
                                    label: '${e.symbol} - ${e.name}',
                                    value: e.id))
                                .toList(),
                            selectedItem: _getSelectedItem(),
                            onChanged: (data) =>
                                cubit.onChangeField(cryptoId: data?.value),
                            validator: (item) =>
                                FormValidator.validateDropdown(item),
                            showSeach: true,
                            searchHint: 'BTC, ETH, ADA ...',
                          ),
                          AppSpacings.verticalLg,
                          CustomTextFormField(
                            labelText: AppLocalizations.current.cryptoAmount,
                            hintText: '0.00',
                            icon: Icons.account_balance_wallet_outlined,
                            keyboardType: TextInputType.number,
                            controller: cryptoAmountController,
                            validator: FormValidator.validateCryptoAmount,
                            onChanged: onChangeAmount,
                          ),
                          if (state.trade.operationType != TradeType.transfer)
                            Padding(
                              padding: const EdgeInsets.only(top: AppInsets.lg),
                              child: CustomTextFormField(
                                labelText: AppLocalizations.current.tradePrice,
                                hintText: '\$0.00',
                                icon: Icons.attach_money_outlined,
                                keyboardType: TextInputType.number,
                                controller: priceController,
                                validator: FormValidator.validateTradePrice,
                                onChanged: onChangePrice,
                              ),
                            ),
                          if (state.trade.operationType != TradeType.transfer)
                            Padding(
                              padding: const EdgeInsets.only(top: AppInsets.lg),
                              child: CustomTextFormField(
                                labelText: state.trade.operationType ==
                                        TradeType.sell
                                    ? AppLocalizations.current.soldAmount
                                    : AppLocalizations.current.investedAmount,
                                hintText: '\$0.00',
                                icon: Icons.savings_outlined,
                                keyboardType: TextInputType.number,
                                controller: tradedAmoutController,
                                validator: FormValidator.validateTradedAmount,
                                onChanged: (value) => cubit.onChangeField(
                                    amountDollars: double.tryParse(
                                            tradedAmoutController.text) ??
                                        0),
                              ),
                            ),
                          AppSpacings.verticalLg,
                          CustomTextFormField(
                            labelText: AppLocalizations.current.fee,
                            hintText: '0.00',
                            icon: Icons.money_off_sharp,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.done,
                            controller: feeController,
                            validator: FormValidator.validateFee,
                            onChanged: (value) => cubit.onChangeField(
                                fee: double.tryParse(feeController.text) ?? 0),
                          ),
                          AppSpacings.verticalLg,
                          CustomTextFormField(
                            labelText: AppLocalizations.current.date,
                            hintText: AppLocalizations.current.hintFieldDate,
                            icon: Icons.calendar_today,
                            keyboardType: TextInputType.datetime,
                            controller: dateController,
                            validator: FormValidator.validateDate,
                            readOnly: true,
                            onTap: () => showDatePicker(
                              context: context,
                              initialDate: dateController.text != ''
                                  ? state.trade.date
                                  : DateTime.now(),
                              firstDate: DateTime(2008),
                              lastDate: DateTime.now(),
                            ).then((value) => onChangeDatePicker(value)),
                          ),
                        ],
                      ),
                    ),
                    AppSpacings.verticalLg,
                    Text(AppLocalizations.current.hintTrade),
                    AppSpacings.verticalLg,
                    // Container(
                    //   height: 50,
                    //   child: AdWidget(ad: cubit.bannerAd..load()),
                    // ),
                  ],
                ),
              ),
              onLoading: () => const LoadingPage(),
              onError: (_) => FeedbackPage(message: state.callbackMessage),
            ),
          );
        },
      ),
    );
  }

  DropdownItem? _getSelectedItem() {
    final trade = context.read<TradesFormCubit>().state.trade;
    if (trade.cryptoId.isNotEmpty) {
      final crypto = Cryptos.getCrypto(trade.cryptoId);
      if (crypto != null) {
        return DropdownItem(
          label: '${crypto.symbol} - ${crypto.name}',
          value: crypto.id,
        );
      }
    }

    return null;
  }

  void onChangeDatePicker(DateTime? date) {
    context.read<TradesFormCubit>().onChangeField(date: date);
    if (date != null) {
      final day = date.day < 10 ? '0${date.day}' : date.day.toString();
      final month = date.month < 10 ? '0${date.month}' : date.month.toString();
      final formattedDate = '$day$month${date.year}';
      dateController.text = formattedDate;
    }
  }

  void onChangeAmount(String value) {
    final cubit = context.read<TradesFormCubit>();
    cubit.onChangeAmount(value);
    tradedAmoutController.text = cubit.state.trade.amountDollars.toString();
  }

  void onChangePrice(String value) {
    final cubit = context.read<TradesFormCubit>();
    cubit.onChangePrice(value);
    tradedAmoutController.text = cubit.state.trade.amountDollars.toString();
  }
}
