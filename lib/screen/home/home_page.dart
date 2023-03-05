import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:house_an_apartement/firebase/form.dart';
import 'package:house_an_apartement/firebase/house_details_page.dart';
import 'package:house_an_apartement/firebase/profile.dart';
import 'package:house_an_apartement/screen/home/widget/allpost.dart';
import 'package:house_an_apartement/screen/home/widget/categories.dart';
import 'package:house_an_apartement/screen/home/widget/recommended_house.dart';
import 'package:house_an_apartement/screen/home/widget/search_input.dart';
import 'package:house_an_apartement/screen/home/widget/welcome_text.dart';

class HomePage extends StatelessWidget {
  final FirebaseAuth currentUser = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      drawer: Drawer(
    
      ),
      // Drawer(
      //   child: Center(
      //       child: ElevatedButton(
      //           onPressed: () {
      //             Navigator.push(
      //               context,
      //               MaterialPageRoute(builder: (context) => MyWidget()),
      //             );
      //           },
      //           child: Text('Edit Profile'))),
      // ),
      appBar: AppBar(
        backgroundColor: Colors.purple,
        actions: [
          Center(
            child: Row(
              children: [
              CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage('assets/images/avater.jpg'),
                    child: 
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Profile_Page()),
                    );
                    },
                  )
                  ),
                
              ],
            ),
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WelcomeText(),
              SearchInput(),
              Categories(),
              RecommendedHouse(),
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
                    builder: (context) => const DropdownExample()),
              );
            },
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            heroTag: 'message',
            onPressed: () {
            },
            child: const Icon(Icons.message_outlined),
          ),
        ],
      ),
    );
  }
}
