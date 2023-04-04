import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:house_an_apartement/screen/home/home_page.dart';
import 'package:image_picker/image_picker.dart';

class Uplode_Image extends StatefulWidget {
  final String text1;
  final String text2;
  final String text3;
  final String? text4;
  final String? text5;
  final String? text6;
  final String? text7;
  final String? text8;
  final String? text9;
  final String? text10;
  final String? text11;
  String? text12;
  String? text13;
  String? text14;

  List<File> _imageFiles = [];

  Uplode_Image({
    super.key,
    required this.text1,
    required this.text2,
    required this.text3,
    required this.text4,
    required this.text5,
    required this.text6,
    required this.text7,
    required this.text8,
    required this.text9,
    required this.text10,
    required this.text11,
    required this.text12,
    required this.text13,
    required this.text14,
  });

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _submitData(List<String> downloadUrls) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;

    final DocumentSnapshot<Map<String, dynamic>> snapshot =
      await _firestore.collection('user_profile').doc(userId).get();
  String _name = '';
  if (snapshot.exists) {
    final Map<String, dynamic>? data = snapshot.data();
    _name = data!['ownername'] ?? '';
  }
  Timestamp timestamp = Timestamp.now(); 

    _firestore.collection('house_details').add({

      'userId': userId,
      'name': text1,
      'price': text2,
      'number': text3,
      'category': text4,
      'gender': text5,
      'bedroom': text6,
      'bathroom': text7,
      'kitchen': text8,
      'parking': text9,
      'free month': text10,
      'about': text11,
      'division': text12,
      'district': text13,
      'area': text14,
      'imageURL': downloadUrls,
      'ownername':_name,
      'timestamp': timestamp,
    });
  }

  @override
  State<Uplode_Image> createState() => _Uplode_ImageState();
}

class _Uplode_ImageState extends State<Uplode_Image> {

  
  
  List<File> _imageFiles = [];
  List<String> _downloadUrls = [];

  Future<void> _selectImages() async {
    final picker = ImagePicker();
    List<XFile>? pickedFiles = await picker.pickMultiImage();
    if (pickedFiles != null) {
      setState(() {
        _imageFiles = pickedFiles.map((file) => File(file.path)).toList();
      });
    }
  }

  Future<List<String>> _uploadImages() async {
    List<String> downloadUrls = [];

    for (File file in _imageFiles) {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference storageReference =
          FirebaseStorage.instance.ref().child('images/$fileName');
      UploadTask uploadTask = storageReference.putFile(file);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      downloadUrls.add(downloadUrl);
    }

    return downloadUrls;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text('Uplode Image'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 5,
            ),
            Container(
              padding: const EdgeInsets.all(4.0),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.purple,
                    width: 2.0,
                  ),
                ),
              ),
              child: const Text(
                'Add Images',
                style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: _imageFiles.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return ElevatedButton(
                      onPressed: _selectImages,
                      child: const Icon(Icons.add),
                    );
                  } else {
                    return Image.file(
                      _imageFiles[index - 1],
                      fit: BoxFit.cover,
                    );
                  }
                },
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            ElevatedButton(
              onPressed: () async {
                List<String> downloadUrls = await _uploadImages();
                widget._submitData(downloadUrls);
                showDialog(
                  context: context,
                  builder: (context) => BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: AlertDialog(
                      title: const Text('Success!'),
                      content: SizedBox(
                        height: 150,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.check_circle_outline,
                                  color: Colors.green,
                                  size: 50,
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  'Images uploaded successfully',
                                  style: TextStyle(fontSize: 18),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomePage()),
                                    );
                                  },
                                  child: const Text(
                                    'Ok',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
              child: const Text('Uplode Images'),
            ),
          ],
        ),
      ),
    );
  }
}
