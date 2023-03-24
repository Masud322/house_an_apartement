import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:house_an_apartement/firebase/profile.dart';
import 'package:house_an_apartement/firebase/widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AvatarScreen extends StatefulWidget {



  @override
  _AvatarScreenState createState() => _AvatarScreenState();
}


class _AvatarScreenState extends State<AvatarScreen> {
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
  final _storage = FirebaseStorage.instance;
  late final String? _userId; // Add a field to store the current user's ID

  late File _imageFile;
  late String _imageUrl = '';

  Future<void> _loadImageUrl() async {
    final userDoc =
        await FirebaseFirestore.instance.collection('users').doc(_userId).get();
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

  void _saveImageUrl(String imageUrl) async {
    await FirebaseFirestore.instance.collection('users').doc(_userId).set({
      'avatarUrl': imageUrl,
    }, SetOptions(merge: true));
    // Save the image URL to SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('avatarUrl', imageUrl);
  }

  void _pickImage() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        _imageUrl = "";
      });
      _uploadImage();
    }
  }

  Future<void> _uploadImage() async {
    final ref = _storage.ref().child('user-avatars/$_userId.jpg');
    await ref.putFile(_imageFile);
    final imageUrl = await ref.getDownloadURL();
    _saveImageUrl(imageUrl);
    setState(() {
      _imageUrl = imageUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 230,
              width: 305,
              color: Colors.grey,
              child: DrawerHeader(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 55,
                      backgroundImage:
                          _imageUrl != null ? NetworkImage(_imageUrl) : null,
                      child:
                          _imageUrl == null ? const Icon(Icons.person, size: 50) : null,
                    ),
                    Positioned(
                      bottom: 45,
                      right: 90,
                      left: 20,
                      top: 70,
                      child: Container(
                        width: 5,
                        height: 5,
                        padding: const EdgeInsets.only(),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: _pickImage,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 115,left: 199),
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Profile_Page(imageUrl: _imageUrl)),
                              );
                            },
                            child: const Text('Profile')),
                      
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(padding: EdgeInsets.only(top: 120)),
                        Container(
                          width: 195,
                          child: SingleChildScrollView(
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
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Container(
                          width: 195,
                          child: SingleChildScrollView(
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
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
              Container(
                height: 658,
                color: Colors.blueGrey,
                child: Center(
                 child: const Logout(),
                )
              )
          ],
            
        ),
      ),
      
    );
  }
}
