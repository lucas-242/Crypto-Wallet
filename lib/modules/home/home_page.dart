import 'package:crypto_wallet/modules/home/home.dart';
import 'package:crypto_wallet/modules/home/widgets/indicator_widget.dart';
import 'package:crypto_wallet/shared/themes/themes.dart';
import 'package:crypto_wallet/shared/widgets/watch_list/watch_list_widget.dart';
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
      appBar: AppBar(
        title: Text('Dashboard'),
        actions: [
          IconButton(
              onPressed: () {}, icon: Icon(Icons.remove_red_eye_sharp))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 25, right: 25, top: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // _header(),
            // SizedBox(height: 35),
            _totalCard(),
            _chart(),
            _variations(),
          ],
        ),
      ),
    );
  }

  // Widget _header() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     children: [
  //       Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text(auth.currentUser!.displayName ?? '',
  //               style: AppTextStyles.titleRegular),
  //           Text('Wallet', style: AppTextStyles.titleRegular),
  //         ],
  //       ),
  //       Container(
  //         height: 56,
  //         width: 56,
  //         decoration: BoxDecoration(
  //             color: Colors.black,
  //             borderRadius: BorderRadius.circular(5),
  //             image: DecorationImage(
  //                 image: NetworkImage(auth.currentUser!.photoURL!))),
  //       ),
  //     ],
  //   );
  // }

  Widget _totalCard() {
    return Card(
      color: AppColors.shape,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Today',
              style: AppTextStyles.titleRegular,
            ),
            SizedBox(height: 15),
            Text(
              NumberFormat.currency(symbol: '\$').format(19852.45),
              style: AppTextStyles.titleHome,
            ),
            SizedBox(height: 15),
            Row(
              children: [
                Text(
                  '+${NumberFormat.currency(symbol: '\$').format(1856.45)} (22.1%)',
                  style: AppTextStyles.titleRegular,
                ),
                Icon(Icons.arrow_upward, color: AppColors.secondary),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _chart() {
    return Row(
      children: [
        DonutChart(),
        Padding(
          padding: EdgeInsets.only(left: 20),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Indicator(
                color: Color(0xff0293ee),
                text: '0.05610231 BTC',
              ),
              SizedBox(height: 10),
              Indicator(
                color: Color(0xfff8b250),
                text: '0.05610231 ETH',
              ),
              SizedBox(height: 10),
              Indicator(
                color: Color(0xff845bef),
                text: '1520.54665874 DOGE',
              ),
              SizedBox(height: 10),
              Indicator(
                color: Color(0xff13d38e),
                text: '784.23456879 XRP',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _variations() {
    return Expanded(
      child: DefaultTabController(
        length: 4,
        initialIndex: 0,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            toolbarHeight: 50,
            bottom: TabBar(
              indicatorColor: AppColors.primary,
              labelColor: AppColors.primary,
              unselectedLabelColor: AppColors.stroke,
              tabs: [
                Tab(text: 'Day'),
                Tab(text: 'Week'),
                Tab(text: 'Month'),
                Tab(text: 'Year'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: WatchList(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: WatchList(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: WatchList(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: WatchList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
