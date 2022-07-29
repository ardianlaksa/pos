// screen_a.dart
import 'package:flutter/material.dart';
import 'package:POS/utils/colors.dart';
import 'package:POS/views/home_view.dart';

class ScreenA extends StatelessWidget {
  const ScreenA({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Screen A',
      theme: ThemeData(
        scaffoldBackgroundColor: primaryColor,
        primaryColor: primaryColor,
        textTheme: Theme.of(context).textTheme.apply(bodyColor: textColor),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeView(),
    );
  }
}