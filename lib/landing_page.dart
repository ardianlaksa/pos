// main.dart
import './screen_d.dart';
import 'package:flutter/material.dart';

import './screen_a.dart';
import './screen_b.dart';
import 'screenc/screen_c.dart';

void main() {
  runApp(const LandingPage());
}

class LandingPage extends StatelessWidget {
  const LandingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // Hide the debug banner
      debugShowCheckedModeBanner: false,
      title: 'Kindacode.com',
      home: MyLandingPage(),
    );
  }
}

class MyLandingPage extends StatefulWidget {
  const MyLandingPage({Key key}) : super(key: key);

  @override
  _MyLandingPageState createState() => _MyLandingPageState();
}

class _MyLandingPageState extends State<MyLandingPage> {
  int _selectedScreenIndex = 0;
  final List _screens = [
    {"screen": ScreenA(), "title": "Screen A Title"},
    {"screen": ScreenB(), "title": "Screen B Title"},
    {"screen": ScreenC(), "title": "Screen C Title"},
    {"screen": const ScreenD(), "title": "Screen D Title"}
  ];

  void _selectScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(_screens[_selectedScreenIndex]["title"]),
      // ),
      body: _screens[_selectedScreenIndex]["screen"],
      bottomNavigationBar: BottomNavigationBar(
        type : BottomNavigationBarType.fixed,
        currentIndex: _selectedScreenIndex,
        onTap: _selectScreen,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Kalender"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Notifikasi"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Profil")
        ],
      ),
    );
  }
}