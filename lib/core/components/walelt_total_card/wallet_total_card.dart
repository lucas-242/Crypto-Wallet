import 'package:crypto_wallet/core/extensions/extensions.dart';
import 'package:crypto_wallet/core/l10n/l10n.dart';
import 'package:crypto_wallet/domain/models/wallet.dart';
import 'package:crypto_wallet/presenter/app/cubit/app_cubit.dart';
import 'package:crypto_wallet/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WalletTotalCard extends StatelessWidget {
  const WalletTotalCard({
    super.key,
    required this.wallet,
    this.showTotalInvested = false,
  });

  final Wallet wallet;
  final bool showTotalInvested;

  @override
  Widget build(BuildContext context) {
    Widget hideValue({TextStyle? style}) => Text(
          '\$ ***',
          style: style ?? context.textLg,
        );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppInsets.lg),
      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) => Column(
          children: [
            state.showWalletValues
                ? hideValue()
                : Text(
                    wallet.totalNow.formatCurrency(),
                    style: context.textSubtitleXLg,
                  ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                state.showWalletValues
                    ? hideValue()
                    : Text(
                        '${wallet.variation.isNegative ? '-' : '+'} ${wallet.variation.formatCurrency()}',
                        style: context.textLg,
                      ),
                Text(
                  ' (${wallet.percentVariation.formatPercent()})',
                  style: context.textLg,
                ),
                Icon(
                  wallet.variation.isNegative
                      ? Icons.arrow_downward
                      : Icons.arrow_upward,
                  color: wallet.variation.isNegative
                      ? AppColors.red
                      : AppColors.green,
                ),
              ],
            ),
            if (showTotalInvested)
              Padding(
                padding: const EdgeInsets.only(top: AppInsets.lg),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.current.totalInvested,
                      style: context.textLg,
                    ),
                    state.showWalletValues
                        ? hideValue()
                        : Text(
                            wallet.totalInvested.formatCurrency(),
                            style: context.textLg,
                          ),
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}
