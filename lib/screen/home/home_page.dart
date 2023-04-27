import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:house_an_apartement/firebase/drawer.dart';
import 'package:house_an_apartement/firebase/widget.dart';
import 'package:house_an_apartement/screen/home/widget/allpost.dart';
import 'package:house_an_apartement/screen/home/widget/profile_image.dart';
import 'package:house_an_apartement/screen/home/widget/welcome_text.dart';

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