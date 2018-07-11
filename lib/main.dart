import 'package:flutter/material.dart';
import 'main_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    MainPage.tag: (context) => MainPage(),
  };
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Evaluation Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.lightBlue,
          //fontFamily: 'Nunito',
          scaffoldBackgroundColor: Colors.grey[300]),
      home: MainPage(),
      routes: routes,
    );
  }
}
