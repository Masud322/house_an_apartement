
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:house_an_apartement/firebase/login.dart';
import 'package:house_an_apartement/firebase/signup.dart';
import 'package:house_an_apartement/screen/home/home_page.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp()); 
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
      home: const Scaffold(
        body: 
        // HomePage(),
        // SignUp(),
        Login(),
      ),
    );
  }
}