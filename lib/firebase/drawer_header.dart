import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:house_an_apartement/firebase/profile.dart';
import 'package:house_an_apartement/firebase/widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Drawer_Header extends StatefulWidget {
  @override
  _Drawer_HeaderState createState() => _Drawer_HeaderState();
}

class _Drawer_HeaderState extends State<Drawer_Header> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final User? _user = FirebaseAuth.instance.currentUser;

  String _username = '';
  String _email = '';

  @override
  void initState() {
    super.initState();
    _fetchUserData();
    _userId = _auth.currentUser!.uid; // Initialize the user ID field
    _loadImageUrl();
  }

  Future<void> _fetchUserData() async {
    final DocumentSnapshot<Map<String, dynamic>> snapshot =
        await _firestore.collection('user_profile').doc(_user!.uid).get();
    if (snapshot.exists) {
      final Map<String, dynamic>? data = snapshot.data();
      setState(() {
        _username = data!['username'] ?? '';
        _email = data['email'] ?? '';
      });
    }
  }

  final _auth = FirebaseAuth.instance;
  late final String? _userId; // Add a field to store the current user's ID

  late String _imageUrl = '';

  Future<void> _loadImageUrl() async {
    final userDoc =
        await FirebaseFirestore.instance.collection('images').doc(_userId).get();
    final data = userDoc.data();
    if (mounted && data != null && data.containsKey('avatarUrl')) {
      setState(() {
        _imageUrl = data['avatarUrl'];
      });
      // Save the image URL to SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('avatarUrl', _imageUrl);
    } else {
      setState(() {
        _imageUrl = "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            height: 192,
            width: 305,
            color: Colors.purple,
            child: DrawerHeader(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: CircleAvatar(
                    radius: 55,
                    backgroundImage: _imageUrl != null && _imageUrl.isNotEmpty
                        ? NetworkImage(_imageUrl)
                        : null,
                    child: _imageUrl == null || _imageUrl.isEmpty
                        ? const Icon(Icons.person_add, size: 27)
                        : null,
                  ),
                ),
                Column(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Text(
                            'Username: $_username',
                            style: const TextStyle(
                              fontSize: 15,
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Text(
                            'Email: $_email',
                            style: const TextStyle(
                                fontSize: 15,
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            )),
          ),
          const SizedBox(
            height: 20,
          ),
          ListTile(
            leading: const Icon(
              Icons.person,
            ),
            title: const Text('Profile'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Profile_Page(imageUrl: _imageUrl)),
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.info,
            ),
            title: const Text('About'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const About()),
              );
            },
          ),
          const ListTile(
            leading: Icon(
              Icons.logout,
            ),
            title: Logout(),
          ),
        ],
      ),
    );
  }
}
