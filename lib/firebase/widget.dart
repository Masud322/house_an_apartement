import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:house_an_apartement/chat/chatscreen.dart';
import 'package:house_an_apartement/firebase/form_Page.dart';
import 'package:house_an_apartement/firebase/security/login.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Forget_Page extends StatefulWidget {
  const Forget_Page({super.key, required this.context});
  final BuildContext context;
  @override
  State<Forget_Page> createState() => _Forget_PageState();
}

class _Forget_PageState extends State<Forget_Page> {
  final _auth = FirebaseAuth.instance;
  late String email;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
          height: 300,
          width: 400,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                child: TextField(
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Email',
                    prefixIcon: Icon(Icons.email),
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                    try {
                      await _auth.sendPasswordResetEmail(email: email).then(
                            (value) => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Login()),
                            ),
                          );
                    } catch (e) {
                      print('Failed $e');
                    }
                  },
                  child: const Text('Forget Password'))
            ],
          )),
    );
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}

class Widget_Page extends StatefulWidget {
  const Widget_Page({super.key, required this.context});
  final BuildContext context;

  @override
  State<Widget_Page> createState() => _Widget_PageState();
}

class _Widget_PageState extends State<Widget_Page> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
          height: 300,
          width: 400,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                "😍😍..HURRAH..😍😍",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const Text(
                "Sign Up Successful 😊",
                style: TextStyle(fontSize: 15),
              ),
              const Text(
                "You May Login Now",
                style: TextStyle(fontSize: 15),
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Login()),
                    );
                  },
                  child: const Text('OK')),
            ],
          )),
    );
  }
}

class Logout extends StatefulWidget {
  const Logout({Key? key}) : super(key: key);

  @override
  _LogoutState createState() => _LogoutState();
}

class _LogoutState extends State<Logout> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        logout();
      },
      child: const Text('Logout'),
    );
  }

  Future<void> logout() async {
    await _auth.signOut();
    // ignore: use_build_context_synchronously
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (BuildContext context) => const Login()),
        (route) => false);
  }
}

class Floating_Button extends StatefulWidget {
  const Floating_Button({super.key});

  @override
  State<Floating_Button> createState() => _Floating_ButtonState();
}

class _Floating_ButtonState extends State<Floating_Button> {
    FirebaseAuth currentUser = FirebaseAuth.instance;
  int _notificationCount = 0;
  StreamSubscription<QuerySnapshot>? _subscription;
  @override
  void initState() {
    super.initState();
    // Listen for changes in the message stream
    _subscription = FirebaseFirestore.instance
        .collection('messages')
        .snapshots()
        .listen((querySnapshot) {
      // Increment the notification count whenever new data is available
      setState(() {
        _notificationCount += 1;
      });
    });
  }

  @override
  void dispose() {
    // Cancel the subscription to the message stream
    _subscription?.cancel();
    super.dispose();
  }

  // Function to reset the badge notification count
  void resetNotificationCount() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _notificationCount = 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FloatingActionButton(
              heroTag: 'add',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Form_Page()),
                );
              },
              child: const Icon(Icons.add),
            ),
            const SizedBox(height: 10),
            Stack(
              children: <Widget>[
                FloatingActionButton(
                  heroTag: 'message',
                  onPressed: () async {
                    // Navigate to the chat screen and wait for the result
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserListPage(
                          notificationCount: _notificationCount,
                          resetNotificationCount: resetNotificationCount,
                        ),
                      ),
                    ).then((value) => resetNotificationCount());
                  },
                  child: const Icon(Icons.message_outlined),
                ),
                if (_notificationCount > 0)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        color: _notificationCount > 0
                            ? Colors.red
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: Text(
                        _notificationCount > 0 ? '$_notificationCount' : '',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        );
  }
}


