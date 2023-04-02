import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:house_an_apartement/firebase/security/login.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Forget_Page extends StatefulWidget {
  const Forget_Page({super.key, required this.context});
  final BuildContext context;
  @override
  State<Forget_Page> createState() => _Forget_PageState();
}

class _Forget_PageState extends State<Forget_Page> {
  final _auth = FirebaseAuth.instance;
  late String email;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
          height: 300,
          width: 400,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                child: TextField(
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Email',
                    prefixIcon: Icon(Icons.email),
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                    try {
                      await _auth.sendPasswordResetEmail(email: email).then(
                            (value) => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Login()),
                            ),
                          );
                    } catch (e) {
                      print('Failed $e');
                    }
                  },
                  child: const Text('Forget Password'))
            ],
          )),
    );
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}

class Widget_Page extends StatefulWidget {
  const Widget_Page({super.key, required this.context});
  final BuildContext context;

  @override
  State<Widget_Page> createState() => _Widget_PageState();
}

class _Widget_PageState extends State<Widget_Page> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
          height: 300,
          width: 400,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                "😍😍..HURRAH..😍😍",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const Text(
                "Sign Up Successful 😊",
                style: TextStyle(fontSize: 15),
              ),
              const Text(
                "You May Login Now",
                style: TextStyle(fontSize: 15),
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Login()),
                    );
                  },
                  child: const Text('OK')),
            ],
          )),
    );
  }
}

class Logout extends StatefulWidget {
  const Logout({Key? key}) : super(key: key);

  @override
  _LogoutState createState() => _LogoutState();
}

class _LogoutState extends State<Logout> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        logout();
      },
      child: const Text('Logout'),
    );
  }

  Future<void> logout() async {
    await _auth.signOut();
    // ignore: use_build_context_synchronously
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (BuildContext context) => const Login()),
        (route) => false);
  }
}






// class EditIconButton extends StatefulWidget {
//   @override
//   _EditIconButtonState createState() => _EditIconButtonState();
// }

// class _EditIconButtonState extends State<EditIconButton> {
//   final picker = ImagePicker();
//   String? _imageUrl;

//   @override
//   void initState() {
//     super.initState();
//     _loadImageUrl();
//   }

//   Future<void> _loadImageUrl() async {
//     final prefs = await SharedPreferences.getInstance();
//     setState(() {
//       _imageUrl = prefs.getString('imageUrl');
//     });
//   }

//   Future<void> _saveImageUrl(String url) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('imageUrl', url);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () async {
//         final pickedFile =
//             await picker.getImage(source: ImageSource.gallery);
//         if (pickedFile != null) {
//           final Reference storageRef = FirebaseStorage.instance
//               .ref()
//               .child('images/${DateTime.now().millisecondsSinceEpoch}.jpg');

//           final UploadTask uploadTask =
//               storageRef.putFile(File(pickedFile.path));
//           final TaskSnapshot downloadUrl =
//               (await uploadTask.whenComplete(() {}));

//           final String url = await downloadUrl.ref.getDownloadURL();

//           FirebaseFirestore.instance.collection('images').add({
//             'url': url,
//           });

//           _saveImageUrl(url);

//           setState(() {
//             _imageUrl = url;
//           });
//         }
//       },
//       child: _imageUrl != null
//           ? CircleAvatar(
//               backgroundImage: NetworkImage(_imageUrl!),
//               radius: 70.0,
//             )
//           : Icon(Icons.edit),
//     );
//   }
// }




