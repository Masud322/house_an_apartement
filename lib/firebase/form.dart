// import 'dart:async';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:house_an_apartement/chat/chatroom.dart';
// import 'package:house_an_apartement/chat/chatscreen.dart';
// import 'package:house_an_apartement/firebase/form.dart';
// import 'package:house_an_apartement/firebase/form_Page.dart';
// import 'package:house_an_apartement/screen/home/widget/phone_auth_page.dart';

// import 'package:house_an_apartement/firebase/image.dart';
// import 'package:house_an_apartement/firebase/security/otps_creen.dart';

// import 'package:house_an_apartement/firebase/profile.dart';
// import 'package:house_an_apartement/firebase/drawer_header.dart';

// import 'package:house_an_apartement/firebase/widget.dart';
// import 'package:house_an_apartement/screen/home/widget/allpost.dart';
// import 'package:house_an_apartement/screen/home/widget/categories.dart';
// import 'package:house_an_apartement/screen/home/widget/phone_auth_page.dart';
// import 'package:house_an_apartement/screen/home/widget/welcome_text.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class HomePage extends StatefulWidget {
  
//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {


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
//         drawer: AvatarScreen(),
//         appBar: AppBar(
//           backgroundColor: Colors.purple,
//         ),
//         body: SafeArea(
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 WelcomeText(),
//                 AllPost(),
//               ],
//             ),
//           ),
//         ),
        
//       ),
//     );
//   }
// }
