
import 'package:flutter/material.dart';
import 'package:house_an_apartement/screen/home/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        backgroundColor: Colors.white,
        primaryColor: Colors.purple,
        // ignore: deprecated_member_use
        accentColor: Colors.amber
      ),
      home: Scaffold(
        body: HomePage()
      ),
    );
  }
}