import 'package:crypto_wallet/shared/models/crypto_model.dart';
import 'package:crypto_wallet/shared/models/cryptos.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'widgets/crypto_summary_widget.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({ Key? key }) : super(key: key);

  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
    final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
        child: Column(
          children: [
            CryptoSummary(
              crypto: CryptoModel(
                crypto: Cryptos.BTC,
                amount: 0.002,
                averagePrice: 33425.25,
                totalInvested: 1587.51,
                gainLoss: 2741.45,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
}