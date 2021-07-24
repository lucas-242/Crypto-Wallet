import 'package:crypto_wallet/shared/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WatchList extends StatelessWidget {
  const WatchList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;

    return ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Container(
            child: Padding(
              padding: EdgeInsets.only(top: 5, left: 10, right: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _name(),
                      _canvas(),
                      _price(),
                    ],
                  ),
                  SizedBox(height: 5),
                  Divider(),
                ],
              ),
            ),
          );
        });
  }

  Widget _name() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Bitcoin',
          style: AppTextStyles.captionBody,
        ),
        Text(
          'BTC',
          style: AppTextStyles.captionBody,
        ),
      ],
    );
  }

  Widget _canvas() {
    return Container();
  }

  Widget _price() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${NumberFormat.currency(symbol: '\$').format(32575.45)}',
          style: AppTextStyles.captionBody,
        ),
        Row(
          children: [
            Text('10,5%', style: AppTextStyles.captionBody),
            Icon(
              Icons.arrow_upward,
              color: AppColors.secondary,
              size: 15,
            ),
          ],
        )
      ],
    );
  }
}
