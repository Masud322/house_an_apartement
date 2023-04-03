import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:house_an_apartement/chat/chatroom.dart';
import 'package:house_an_apartement/chat/chatscreen.dart';
import 'package:house_an_apartement/firebase/form.dart';
import 'package:house_an_apartement/firebase/form_Page.dart';
import 'package:house_an_apartement/screen/home/widget/phone_auth_page.dart';

import 'package:house_an_apartement/firebase/image.dart';
import 'package:house_an_apartement/firebase/security/otps_creen.dart';

import 'package:house_an_apartement/firebase/profile.dart';
import 'package:house_an_apartement/firebase/drawer_header.dart';

import 'package:house_an_apartement/firebase/widget.dart';
import 'package:house_an_apartement/screen/home/widget/allpost.dart';
import 'package:house_an_apartement/screen/home/widget/categories.dart';
import 'package:house_an_apartement/screen/home/widget/phone_auth_page.dart';
import 'package:house_an_apartement/screen/home/widget/profile_image.dart';
import 'package:house_an_apartement/screen/home/widget/welcome_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


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
    bool someCondition = false;

    return WillPopScope(
      onWillPop: () async {
        if (someCondition) {
          return true;
        } else {
          return false;
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        drawer: Drawer_Header(),
        appBar: AppBar(
          backgroundColor: Colors.purple,
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
               Profile_Image(),
              ],
            )
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                WelcomeText(),
                AllPost(),
              ],
            ),
          ),
        ),
        floatingActionButton: Column(
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
        ),
      ),
    );
  }
}
