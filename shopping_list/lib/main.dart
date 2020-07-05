import 'package:flutter/material.dart';

import 'Widgets/itemsListWidget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title = 'Basket List';

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery
            .of(context)
            .size
            .height,
        width: MediaQuery
            .of(context)
            .size
            .width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Color.fromRGBO(253, 213, 55, 1.0), Color.fromRGBO(236, 185, 42, 1.0)],
              begin: Alignment.center,
              end: Alignment.topRight),
        ), child: ItemsListWidget(title)
    );
  }
}
