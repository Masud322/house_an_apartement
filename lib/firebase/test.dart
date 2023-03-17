import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AvatarScreen extends StatefulWidget {
  @override
  _AvatarScreenState createState() => _AvatarScreenState();
}

class _AvatarScreenState extends State<AvatarScreen> {
  final _auth = FirebaseAuth.instance;
  final _storage = FirebaseStorage.instance;
  late final String? _userId; // Add a field to store the current user's ID

  late File _imageFile;
  late String _imageUrl = '';

  @override
  void initState() {
    super.initState();
    _userId = _auth.currentUser!.uid; // Initialize the user ID field
    _loadImageUrl();
  }

  Future<void> _loadImageUrl() async {
    final userDoc =
        await FirebaseFirestore.instance.collection('users').doc(_userId).get();
    final data = userDoc.data();
    if (mounted && data != null && data.containsKey('avatarUrl')) {
      setState(() {
        _imageUrl = data['avatarUrl'];
      });
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Avatar Screen'),
      ),
      body: Center(
        child: Stack(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage:
                  _imageUrl != null ? NetworkImage(_imageUrl) : null,
              child: _imageUrl == null ? Icon(Icons.person, size: 50) : null,
            ),
            Positioned(
              bottom: 0,
              right: 0,
              
              child: Container(
                
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: _pickImage,
                  
                  
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
