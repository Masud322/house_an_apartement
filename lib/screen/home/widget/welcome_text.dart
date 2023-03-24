import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:house_an_apartement/firebase/user_edit_page.dart';

// ignore: camel_case_types
class WelcomeText extends StatefulWidget {
  const WelcomeText({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _WelcomeTextState createState() => _WelcomeTextState();
}

class _WelcomeTextState extends State<WelcomeText> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final User? _user = FirebaseAuth.instance.currentUser;

  String _name = '';

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    final DocumentSnapshot<Map<String, dynamic>> snapshot =
        await _firestore.collection('user_profile').doc(_user!.uid).get();
    if (snapshot.exists) {
      final Map<String, dynamic>? data = snapshot.data();
      setState(() {
        _name = data!['name'] ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(padding: const EdgeInsets.only(left: 21,top: 10),
                child: Text(
                    'Hello $_name',
                    style: const TextStyle(
                        fontSize: 16,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.bold),
                  ),
              ),
                const Padding(padding: EdgeInsets.only(left: 21,top: 10,bottom: 14),
                  child: Text('Find Your Sweet Home',style: TextStyle(fontSize: 22,color: Colors.black45,fontWeight: FontWeight.bold),)),
            ],
          ),
        );
  }
}
