
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
import 'package:house_an_apartement/screen/home/widget/welcome_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatelessWidget {


  // Future<String?> _loadImageUrl() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs.getString('imageUrl');
  // }
  
  final FirebaseAuth currentUser = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    int _notificationCount = 0;

    bool someCondition = false;

    
    return WillPopScope(
      onWillPop: () async {
        // Do some logic here to determine whether or not to allow the pop
        // ignore: dead_code
        if (someCondition) {
          return true; // Allow the pop to occur
        } else {
          return false; // Prevent the pop
        }
      },
      child:
    Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      drawer: AvatarScreen(),
      appBar: AppBar(
        backgroundColor: Colors.purple,
      ),
      body: 
         SafeArea(
           child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                WelcomeText(),
                // SearchPage(),
                AllPost(),
                // Near_you(),
              ],
            ),
                 ),
         ),
      
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            heroTag: 'Test',
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //       builder: (context) => test7()),
              // );
            },
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            heroTag: 'add',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Form_Page()),
              );
            },
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            heroTag: 'message',
            onPressed: () {
              Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserListPage()),
                  );
            },
            child: const Icon(Icons.message_outlined),
          ),
        ],
      ),
    ),
    );
  }
}




