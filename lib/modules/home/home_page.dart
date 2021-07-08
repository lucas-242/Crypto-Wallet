import 'package:crypto_wallet/shared/themes/themes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final auth = FirebaseAuth.instance;

  @override
   Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
        child: Column(
          children: [
            _header(),
            SizedBox(height: 40),
            
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
}
