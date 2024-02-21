import 'package:crypto_wallet/core/l10n/l10n.dart';
import 'package:crypto_wallet/core/routes/routes.dart';
import 'package:crypto_wallet/presenter/trades/components/bottom_buttons.dart';
import 'package:crypto_wallet/presenter/trades/components/trades_form_content.dart';
import 'package:crypto_wallet/presenter/trades/cubit/trades_form_cubit.dart';
import 'package:crypto_wallet/service_locator.dart';
import 'package:crypto_wallet/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TradesFormPage extends StatefulWidget {
  const TradesFormPage({super.key});

  @override
  State<TradesFormPage> createState() => _TradesFormPageState();
}

class _TradesFormPageState extends State<TradesFormPage> {
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

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ServiceLocator.get<TradesFormCubit>(),
      child: Scaffold(
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
        body: const TradesFormContent(),
        bottomNavigationBar: BlocBuilder<TradesFormCubit, TradesFormState>(
          builder: (context, state) => state.when(
            onState: (_) => BottomButtons(
              fisrtLabel: AppLocalizations.current.cancel,
              secondLabel: AppLocalizations.current.save,
              secondButtonStyle:
                  context.textSubtitleMd.copyWith(color: AppColors.primary),
              onPressedFirst: context.pop,
              onPressedSecond: () => context.read<TradesFormCubit>().onSave(),
            ),
            onLoading: () => const SizedBox.shrink(),
          ),
        ),
      ),
    );
  }
}
