import 'package:crypto_wallet/core/components/status_pages/status_pages.dart';
import 'package:crypto_wallet/presenter/trades/components/trade_content.dart';
import 'package:crypto_wallet/presenter/trades/cubit/trades_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TradesPage extends StatefulWidget {
  const TradesPage({super.key});

  @override
  State<TradesPage> createState() => _TradesPageState();
}

class _TradesPageState extends State<TradesPage> {
  @override
  void initState() {
    context.read<TradesCubit>().getTrades();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () =>
          context.read<TradesCubit>().getTrades(forceRefresh: true),
      child: BlocBuilder<TradesCubit, TradesState>(
        builder: (context, state) => state.when(
          onState: (_) => const TradesContent(),
          onError: (_) => FeedbackPage(message: state.callbackMessage),
          onLoading: () => const LoadingPage(),
        ),
      ),
    );
  }
}
