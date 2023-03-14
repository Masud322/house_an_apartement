// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class MultipleImageUpload extends StatefulWidget {

  
  
//   @override
//   _MultipleImageUploadState createState() => _MultipleImageUploadState();
// }

// class _MultipleImageUploadState extends State<MultipleImageUpload> {
//   List<File> _imageFiles = [];

//   Future<void> _selectImages() async {
//     final picker = ImagePicker();
//     List<XFile>? pickedFiles = await picker.pickMultiImage();
//     if (pickedFiles != null) {
//       setState(() {
//         _imageFiles = pickedFiles.map((file) => File(file.path)).toList();
//       });
//     }
//   }

//   Future<List<String>> _uploadImages() async {
//     List<String> downloadUrls = [];

//     for (File file in _imageFiles) {
//       String fileName = DateTime.now().millisecondsSinceEpoch.toString();
//       Reference storageReference =
//           FirebaseStorage.instance.ref().child('images/$fileName');
//       UploadTask uploadTask = storageReference.putFile(file);
//       TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
//       String downloadUrl = await taskSnapshot.ref.getDownloadURL();
//       downloadUrls.add(downloadUrl);
//     }

//     return downloadUrls;
//   }

//   Future<void> _addToFirestore(List<String> downloadUrls) async {
//     CollectionReference collectionReference = FirebaseFirestore.instance.collection('images');
//     DocumentReference documentReference = collectionReference.doc();
//     Map<String, dynamic> data = {
//       'urls': downloadUrls,
//       // 'inputValue': inputValue,
//     };
//     await documentReference.set(data);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Multiple Image Upload'),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             GridView.builder(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 3,
//                 crossAxisSpacing: 8.0,
//                 mainAxisSpacing: 8.0,
//               ),
//               itemCount: _imageFiles.length + 1,
//               itemBuilder: (context, index) {
//                 if (index == 0) {
//                   return ElevatedButton(
//                     onPressed: _selectImages,
//                     child: const Icon(Icons.add),
//                   );
//                 } else {
//                   return Image.file(
//                     _imageFiles[index - 1],
//                     fit: BoxFit.cover,
//                   );
//                 }
//               },
//             ),
//             const SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: () async {
//                 List<String> downloadUrls = await _uploadImages();
//                 await _addToFirestore(downloadUrls);
//                 setState(() {
//                   _imageFiles = [];
//                 });
//               },
//               child: const Text('Upload'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
