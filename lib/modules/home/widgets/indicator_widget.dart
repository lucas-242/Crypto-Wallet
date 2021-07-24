import 'package:flutter/material.dart';

class Indicator extends StatelessWidget {
  final Color color;
  final String text;
  final String? subtext;
  final bool isSquare;
  final double size;
  final Color textColor;

  const Indicator({
    Key? key,
    required this.color,
    required this.text,
    this.subtext,
    this.isSquare = false,
    this.size = 16,
    this.textColor = const Color(0xff505050),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: textColor,
              ),
            ),
            if (subtext != null)
              Text(
                subtext!,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: textColor,
                ),
              ),
          ],
        )
      ],
    );
  }
}
