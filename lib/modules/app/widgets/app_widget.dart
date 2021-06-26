import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app.dart';
import 'app_bottom_navigation_widget.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    var appBloc = context.watch<AppBloc>();
    return Scaffold(
      appBar: AppBar(
        title: Text(appBloc.currentPageName),
      ),
      body: 
      [
        Container(
          color: Colors.blue,
        ),
        Container(
          color: Colors.red,
        ),
      ][appBloc.currentPageIndex],
      bottomNavigationBar: AppBottomNavigationBar(
        currentPage: appBloc.currentPageIndex,
        onTap: (index) => appBloc.changePage(index),
      ),
    );
  }
}
