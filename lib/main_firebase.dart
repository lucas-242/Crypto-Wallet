import 'package:crypto_wallet/main_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class MainFirebase extends StatefulWidget {
  const MainFirebase({Key? key}) : super(key: key);

  @override
  _MainFirebaseState createState() => _MainFirebaseState();
}

class _MainFirebaseState extends State<MainFirebase> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Material(
              child: Center(
                child: Text('Unable to initialize Firebase \n Não foi possível inicializar o Firebase'),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            return MainApp();
          } else {
            return Material(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
