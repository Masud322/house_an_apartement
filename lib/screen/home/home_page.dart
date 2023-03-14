
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:house_an_apartement/firebase/form_Page.dart';


import 'package:house_an_apartement/firebase/image.dart';
import 'package:house_an_apartement/firebase/location.dart';

import 'package:house_an_apartement/firebase/profile.dart';
import 'package:house_an_apartement/firebase/test.dart';

import 'package:house_an_apartement/firebase/widget.dart';
import 'package:house_an_apartement/screen/home/widget/allpost.dart';
import 'package:house_an_apartement/screen/home/widget/categories.dart';
import 'package:house_an_apartement/screen/home/widget/search_input.dart';
import 'package:house_an_apartement/screen/home/widget/welcome_text.dart';

class HomePage extends StatelessWidget {
  final FirebaseAuth currentUser = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    bool someCondition = false;
    return WillPopScope(
      onWillPop: () async {
        // Do some logic here to determine whether or not to allow the pop
        if (someCondition) {
          return true; // Allow the pop to occur
        } else {
          return false; // Prevent the pop
        }
      },
      child:
    Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      drawer: const Logout(),
      appBar: AppBar(
        backgroundColor: Colors.purple,
        actions: [
          Center(
            child: Row(
              children: [
                CircleAvatar(
                    radius: 25,
                    backgroundImage:
                        const AssetImage('assets/images/avater.jpg'),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Profile_Page()),
                        );
                      },
                    )),
              ],
            ),
          )
        ],
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
              // Navigator.push(
              //       context,
              //       MaterialPageRoute(builder: (context) => FirestoreImageDisplay()),
              //     );
            },
            child: const Icon(Icons.message_outlined),
          ),
        ],
      ),
    ),
    );
  }
}
