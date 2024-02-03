import 'package:crypto_wallet/core/components/walelt_total_card/wallet_total_card.dart';
import 'package:crypto_wallet/core/routes/routes.dart';
import 'package:crypto_wallet/core/utils/base_state.dart';
import 'package:crypto_wallet/domain/data/cryptos.dart';
import 'package:crypto_wallet/domain/models/wallet.dart';
import 'package:crypto_wallet/domain/models/wallet_crypto.dart';
import 'package:crypto_wallet/presenter/home/components/cryptos_carrousel.dart';
import 'package:crypto_wallet/presenter/home/components/watch_list_tab.dart';
import 'package:crypto_wallet/presenter/login/cubit/login_cubit.dart';
import 'package:crypto_wallet/service_locator.dart';
import 'package:crypto_wallet/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _cubit = ServiceLocator.get<LoginCubit>();

  final cryptos = [
    WalletCrypto(
      id: 'aaaa',
      cryptoId: 'bitcoin',
      amount: 0.01588,
      averagePrice: 25752.0,
      totalInvested: 1000,
      marketData: Cryptos.supported[0],
    ),
    WalletCrypto(
      id: 'aaaa',
      cryptoId: 'ethereum',
      amount: 0.01588,
      averagePrice: 25752.0,
      totalInvested: 1000,
      marketData: Cryptos.supported[1],
    ),
    WalletCrypto(
      id: 'aaaa',
      cryptoId: 'cardano',
      amount: 0.01588,
      averagePrice: 25752.0,
      totalInvested: 1000,
      marketData: Cryptos.supported[2],
    ),
    WalletCrypto(
      id: 'aaaa',
      cryptoId: 'binance_coin',
      amount: 0.01588,
      averagePrice: 25752.0,
      totalInvested: 1000,
      marketData: Cryptos.supported[3],
    ),
    WalletCrypto(
      id: 'aaaa',
      cryptoId: 'tether',
      amount: 0.01588,
      averagePrice: 25752.0,
      totalInvested: 1000,
      marketData: Cryptos.supported[4],
    ),
    WalletCrypto(
      id: 'aaaa',
      cryptoId: 'ripple',
      amount: 0.01588,
      averagePrice: 25752.0,
      totalInvested: 1000,
      marketData: Cryptos.supported[5],
    ),
    WalletCrypto(
      id: 'aaaa',
      cryptoId: 'dogecoin',
      amount: 0.01588,
      averagePrice: 25752.0,
      totalInvested: 1000,
      marketData: Cryptos.supported[6],
    )
  ];
  late final Wallet wallet;

  @override
  void initState() {
    wallet = Wallet(cryptos: cryptos);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _cubit,
      child: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state.status == BaseStateStatus.success) {
            context.globalNavigate(Routes.login);
          } else if (state.status == BaseStateStatus.error) {
            context.showSnackBar(state.callbackMessage);
          }
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppInsets.md),
              child: WalletTotalCard(wallet: wallet),
            ),
            CryptosCarrousel(cryptos: cryptos),
            Expanded(child: WatchListTab(cryptos: cryptos)),
          ],
        ),
      ),
    );
  }
}
