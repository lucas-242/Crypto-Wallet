import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdCard extends StatefulWidget {
  final BannerAd ad;
  final int index;
  final int? openedIndex;

  const AdCard({
    Key? key,
    required this.ad,
    required this.index,
    this.openedIndex,
  }) : super(key: key);

  @override
  _AdCardState createState() => _AdCardState();
}

class _AdCardState extends State<AdCard> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: 20,
          bottom: widget.openedIndex == widget.index + 1 ? 20 : 0,
          left: 20,
          right: 20),
      child: Column(
        children: [
          Container(
            height: 100,
            child: AdWidget(
              ad: widget.ad,
            ),
          ),
          spaceToNextCard(),
          divider(),
        ],
      ),
    );
  }

  Widget spaceToNextCard() => widget.openedIndex == widget.index + 1
      ? Container()
      : SizedBox(height: 20);

  Widget divider() => widget.openedIndex == widget.index + 1
      ? Container()
      : Divider(thickness: 1);
}
