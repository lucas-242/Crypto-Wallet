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
import 'package:crypto_wallet/presenter/trades/components/bottom_buttons.dart';
import 'package:crypto_wallet/presenter/trades/cubit/trades_form_cubit.dart';
import 'package:crypto_wallet/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TradesFormPage extends StatefulWidget {
  const TradesFormPage({super.key});

  @override
  State<TradesFormPage> createState() => _TradesFormPageState();
}

class _TradesFormPageState extends State<TradesFormPage> {
  final formKey = GlobalKey<FormState>();

  final cryptoAmountController = TextEditingController();
  final tradedAmoutController = TextEditingController();
  final priceController = TextEditingController();
  final dateController = TextEditingController();
  final feeController = TextEditingController();

  // @override
  // void initState() {
  //   final auth = context.read<Auth>();
  //   uid = auth.user!.uid;
  //   bloc = InsertTradeBloc(
  //     walletRepository: widget.walletRepository,
  //     cryptosService: widget.cryptosService,
  //   );

  //   cubit.checkCryptoList();
  //   cubit.loadInterstitialAd();
  //   cubit.loadBannerAd();
  //   cubit.onChangeField(user: uid);
  //   super.initState();
  // }

  void onChangeDatePicker(DateTime? date) {
    context.read<TradesFormCubit>().onChangeField(date: date);
    if (date != null) {
      final day = date.day < 10 ? '0${date.day}' : date.day.toString();
      final month = date.month < 10 ? '0${date.month}' : date.month.toString();
      final formattedDate = '$day$month${date.year}';
      dateController.text = formattedDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TradesFormCubit>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // title: Text(
        //   _appCubit.state.currentPage.name.capitalize(),
        //   style: context.textSubtitleLg.copyWith(color: AppColors.primary),
        // ),
        // leading: IconButton(
        //   icon: const Icon(Icons.menu),
        //   onPressed: context.showDrawer,
        // ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppInsets.md),
        child: BlocConsumer<TradesFormCubit, TradesFormState>(
          listenWhen: (previous, current) => previous.status != current.status,
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
                          hint: AppLocalizations.current.hintFieldOperationType,
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
                            padding: const EdgeInsets.only(top: AppInsets.xxSm),
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
                            padding: const EdgeInsets.only(top: AppInsets.xxSm),
                            child: CustomTextFormField(
                              labelText:
                                  state.trade.operationType == TradeType.sell
                                      ? AppLocalizations.current.soldAmount
                                      : AppLocalizations.current.investedAmount,
                              hintText: '\$0.00',
                              icon: Icons.savings_outlined,
                              keyboardType: TextInputType.number,
                              controller: tradedAmoutController,
                              validator: FormValidator.validateTradedAmount,
                              onChanged: (value) {
                                final number =
                                    double.tryParse(tradedAmoutController.text);
                                cubit.onChangeField(
                                    amountDollars:
                                        value.isEmpty ? 0 : (number ?? 0));
                              },
                            ),
                          ),
                        AppSpacings.verticalMd,
                        CustomTextFormField(
                          labelText: AppLocalizations.current.fee,
                          hintText: '0.00',
                          icon: Icons.money_off_sharp,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                          controller: feeController,
                          validator: FormValidator.validateFee,
                          onChanged: (value) {
                            final number = double.tryParse(feeController.text);
                            cubit.onChangeField(
                                fee: value.isEmpty ? 0 : (number ?? 0));
                          },
                        ),
                        AppSpacings.verticalMd,
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
                  AppSpacings.verticalMd,
                  Text(AppLocalizations.current.hintTrade),
                  AppSpacings.verticalMd,
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
        ),
      ),
      bottomNavigationBar: BlocBuilder<TradesFormCubit, TradesFormState>(
        builder: (context, state) => state.when(
            onState: (_) => BottomButtons(
                  fisrtLabel: AppLocalizations.current.cancel,
                  secondLabel: AppLocalizations.current.save,
                  secondButtonStyle:
                      context.textSubtitleMd.copyWith(color: AppColors.primary),
                  onPressedFirst: context.pop,
                  onPressedSecond: () =>
                      context.read<TradesFormCubit>().onSave(),
                ),
            onLoading: () => const SizedBox.shrink()),
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
