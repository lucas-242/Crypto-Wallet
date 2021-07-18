import 'package:crypto_wallet/modules/home/home.dart';
import 'package:crypto_wallet/shared/themes/themes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final auth = FirebaseAuth.instance;

  var cryptos = [
    //  new Series<LinearSales, int>(
    //     id: 'Sales',
    //     domainFn: (LinearSales sales, _) => sales.year,
    //     measureFn: (LinearSales sales, _) => sales.sales,
    //     data: data,
    //     // Set a label accessor to control the text of the arc label.
    //     labelAccessorFn: (LinearSales row, _) => '${row.year}: ${row.sales}',
    //   )
    // new Series(id: id, data: data, domainFn: domainFn, measureFn: measureFn)
    {"name": "btc", "value": "0.0017"},
    {"name": "eth", "value": "0.000085"},
    {"name": "ada", "value": "30.5"}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _header(),
            SizedBox(height: 35),
            _total(),
            SizedBox(height: 15),
            DonutChart(),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Welcome', style: AppTextStyles.titleRegular),
            Text(auth.currentUser!.displayName ?? '',
                style: AppTextStyles.titleRegular)
          ],
        ),
        Container(
          height: 56,
          width: 56,
          decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(5),
              image: DecorationImage(
                  image: NetworkImage(auth.currentUser!.photoURL!))),
        ),
      ],
    );
  }

  Widget _total() {
    return Text.rich(
      TextSpan(
        text: 'Total Equity\n',
        style: AppTextStyles.titleRegular,
        children: [
          TextSpan(
            text: NumberFormat.currency(symbol: '\$').format(19852.45)
          )
        ]
      ),
    );
  }
}
