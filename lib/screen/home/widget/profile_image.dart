import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:house_an_apartement/firebase/form_Page.dart';
import 'package:house_an_apartement/firebase/profile.dart';
import 'package:house_an_apartement/firebase/widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile_Image extends StatefulWidget {
  @override
  _Profile_ImageState createState() => _Profile_ImageState();
}

class _Profile_ImageState extends State<Profile_Image> {
  @override
  void initState() {
    super.initState();
    _userId = _auth.currentUser!.uid; // Initialize the user ID field
    _loadImageUrl();
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

  void _changeProfilePicture() async {
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
    return InkWell(
      onTap: () {
        _changeProfilePicture();
      },
      child: CircleAvatar(
        radius: 35,
        backgroundImage: _imageUrl != null && _imageUrl.isNotEmpty
            ? NetworkImage(_imageUrl)
            : null,
        child: _imageUrl == null || _imageUrl.isEmpty
            ? const Icon(Icons.person_add, size: 25)
            : null,
      ),
    );
  }
}
