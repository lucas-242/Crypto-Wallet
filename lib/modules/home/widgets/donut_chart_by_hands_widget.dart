import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class DonutChartByHand extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DonutChartState();
}

class DonutChartState extends State {
  var kCategories = [
    Category('groceries', amount: 600.00),
    Category('online Shopping', amount: 150.00),
    Category('eating', amount: 90.00),
    Category('bills', amount: 90.00),
    Category('subscriptions', amount: 70.00),
    Category('fees', amount: 50.00),
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(
      children: [
        SizedBox(height: 40),
        Center(
          child: Container(
            width: size.width * 0.55,
            height: size.height * 0.4,
            child: CustomPaint(
              child: Center(
                child: Text('\$1280.20'),
              ),
              foregroundPainter: PieChartData(
                width: size.width * 0.25,
                categories: kCategories,
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  blurRadius: 1,
                  offset: Offset(-1, -1),
                  color: Colors.white,
                ),
                BoxShadow(
                  spreadRadius: -2,
                  blurRadius: 10,
                  offset: Offset(5, 5),
                  color: Colors.black.withOpacity(0.5),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class PieChartData extends CustomPainter {
  PieChartData({required this.categories, required this.width});

  final List<Category> categories;
  final double width;

  final kNeumorphicColors = [
    Color.fromRGBO(82, 98, 255, 1), //  rgb(82, 98, 255)
    Color.fromRGBO(46, 198, 255, 1), // rgb(46, 198, 255)
    Color.fromRGBO(123, 201, 82, 1), // rgb(123, 201, 82)
    Color.fromRGBO(255, 171, 67, 1), // rgb(255, 171, 67)
    Color.fromRGBO(252, 91, 57, 1), //  rgb(252, 91, 57)
    Color.fromRGBO(139, 135, 130, 1), //rgb(139, 135, 130)
  ];

  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);

    var paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = width / 2;

    double total = 0;
    // Calculate total amount from each category
    categories.forEach((expense) => total += expense.amount);

    // The angle/radian at 12 o'clcok
    double startRadian = -pi / 2;

    for (var index = 0; index < categories.length; index++) {
      final currentCategory = categories.elementAt(index);
      // Amount of length to paint is a percentage of the perimeter of a circle (2 x pi)
      final sweepRadian = currentCategory.amount / total * 2 * pi;
      // Used modulo/remainder to catch use case if there is more than 6 colours
      paint.color = kNeumorphicColors.elementAt(index % categories.length);
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startRadian,
        sweepRadian,
        false,
        paint,
      );

      // The new startRadian starts from where the previous sweepRadian.
      // Example, a circle perimeter is 10.
      // Category A takes a startRadian 0 and ends at sweepRadian 5.
      // Category B takes the startRadian where Category A left off, which is 5
      // and ends at sweepRadian 7.
      // Category C takes the startRadian where Category B left off, which is 7
      // and so on.
      startRadian += sweepRadian;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class Category {
  Category(this.name, {required this.amount});

  final String name;
  final double amount;
}
