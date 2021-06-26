import 'package:crypto_wallet/shared/themes/themes.dart';
import 'package:flutter/material.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/insert_trade'),
        child: Icon(Icons.add),
        backgroundColor: AppColors.primary,
      ),
    );
  }
}
