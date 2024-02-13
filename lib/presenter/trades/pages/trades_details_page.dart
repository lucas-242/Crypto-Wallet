import 'package:crypto_wallet/core/components/status_pages/components/feedback_page.dart';
import 'package:crypto_wallet/core/components/status_pages/components/loading_page.dart';
import 'package:crypto_wallet/core/extensions/extensions.dart';
import 'package:crypto_wallet/core/l10n/l10n.dart';
import 'package:crypto_wallet/presenter/trades/cubit/trades_cubit.dart';
import 'package:crypto_wallet/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class TradesDetailsPage extends StatefulWidget {
  const TradesDetailsPage({super.key});

  @override
  State<TradesDetailsPage> createState() => _TradesDetailsPageState();
}

class _TradesDetailsPageState extends State<TradesDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.current.tradeDetails),
        leading: const BackButton(color: AppColors.primary),
        actions: [
          TextButton(
            onPressed: () => context.read<TradesCubit>(),
            child: const Icon(Icons.delete, color: AppColors.text, size: 20),
          ),
        ],
      ),
      body: BlocBuilder<TradesCubit, TradesState>(
        builder: (context, state) => state.when(
          onState: (_) {
            final trade = state.selectedTrade!;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppInsets.md),
              child: Column(
                children: [
                  Center(child: Text(trade.cryptoSymbol)),
                  AppSpacings.verticalMd,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(AppLocalizations.current.operationType),
                      Text(
                        trade.operationType.capitalize(),
                        style: context.textSubtitleMd,
                      ),
                    ],
                  ),

                  AppSpacings.verticalMd,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(AppLocalizations.current.cryptoAmount),
                      Text(
                        trade.amount.toStringAsFixed(8),
                        style: context.textSubtitleMd,
                      ),
                    ],
                  ),

                  AppSpacings.verticalMd,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(AppLocalizations.current.tradePrice),
                      Text(
                        trade.price.formatCurrency(),
                        style: context.textSubtitleMd,
                      ),
                    ],
                  ),

                  AppSpacings.verticalMd,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(AppLocalizations.current.date),
                      Text(
                        DateFormat.yMd().format(trade.date),
                        style: context.textSubtitleMd,
                      ),
                    ],
                  ),
                  AppSpacings.verticalMd,
                  const Divider(),
                  AppSpacings.verticalMd,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(AppLocalizations.current.fee),
                      Text(
                        trade.fee.toStringAsFixed(8),
                        style: context.textSubtitleMd,
                      ),
                    ],
                  ),
                  AppSpacings.verticalMd,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(AppLocalizations.current.total),
                      Text(
                        trade.amountDollars.formatCurrency(),
                        style: context.textSubtitleMd,
                      ),
                    ],
                  ),
                  AppSpacings.horizontalLg,
                  // Expanded(
                  //   child: Align(
                  //     child: SizedBox(
                  //       height: 250,
                  //       child: AdWidget(
                  //           ad: AdHelper.bannerTradeRegisterAndDetails(
                  //               size: AdSize.mediumRectangle)
                  //             ..load()),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            );
          },
          onLoading: () => const LoadingPage(),
          onError: (_) => FeedbackPage(message: state.callbackMessage),
        ),
      ),
    );
  }
}
