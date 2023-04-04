import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:house_an_apartement/chat/chatroom.dart';
import 'package:house_an_apartement/chat/chatscreen.dart';

import 'package:house_an_apartement/firebase/form_Page.dart';
import 'package:house_an_apartement/screen/home/widget/phone_auth_page.dart';
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
  Future<void> _refresh() async {
    setState(() {
    });
    return Future.delayed(Duration(seconds: 1));

    // Implement the logic to refresh the page here
    // For example, you can fetch new data from the server
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
        body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return RefreshIndicator(
            onRefresh: _refresh,
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    WelcomeText(),
                    AllPost(),
                  ],
                ),
              ),
            ),
          );
        }),
        floatingActionButton: Floating_Button(),
      ),
    );
  }
}


// import 'dart:async';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// import 'package:house_an_apartement/firebase/drawer_header.dart';
// import 'package:house_an_apartement/screen/home/widget/allpost.dart';
// import 'package:house_an_apartement/screen/home/widget/profile_image.dart';
// import 'package:house_an_apartement/screen/home/widget/welcome_text.dart';

// class HomePage extends StatefulWidget {
//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   FirebaseAuth currentUser = FirebaseAuth.instance;
//   int _notificationCount = 0;
//   StreamSubscription<QuerySnapshot>? _subscription;
//    late Stream<QuerySnapshot> _stream;
  

//   Future<void> _refresh() async {
// setState(() {
//       _stream = FirebaseFirestore.instance.collection('test').snapshots();
//       _stream = FirebaseFirestore.instance.collection('user_profile').snapshots();
//       _stream = FirebaseFirestore.instance.collection('users').snapshots();
//     });
//     return Future.delayed(Duration(seconds: 1));
    
//     // Implement the logic to refresh the page here
//     // For example, you can fetch new data from the server
//   }

//   @override
//   Widget build(BuildContext context) {
//     bool someCondition = false;

//     return WillPopScope(
//       onWillPop: () async {
//         if (someCondition) {
//           return true;
//         } else {
//           return false;
//         }
//       },
//       child: Scaffold(
//         backgroundColor: Theme.of(context).backgroundColor,
//         drawer: Drawer_Header(),
//         appBar: AppBar(
//           backgroundColor: Colors.purple,
//           actions: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 Profile_Image(),
//               ],
//             )
//           ],
//         ),
//         body: LayoutBuilder(
//           builder: (BuildContext context, BoxConstraints constraints) {
//             return RefreshIndicator(
//               onRefresh: _refresh,
//               child: SingleChildScrollView(
//                 physics: AlwaysScrollableScrollPhysics(),
//                 child: Container(
//                   height: MediaQuery.of(context).size.height,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       WelcomeText(),
//                       AllPost(),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
