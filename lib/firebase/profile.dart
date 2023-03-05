import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:house_an_apartement/firebase/user_edit_page.dart';

// ignore: camel_case_types
class Profile_Page extends StatefulWidget {
  const Profile_Page({Key? key}) : super(key: key);

  @override
  _Profile_PageState createState() => _Profile_PageState();
}

class _Profile_PageState extends State<Profile_Page> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final User? _user = FirebaseAuth.instance.currentUser;

  String _username = '';
  String _name = '';
  String _profession = '';
  String _gender = '';
  String _email = '';
  String _phone = '';
  String _password = '';

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
        _username = data!['username'] ?? '';
        _name = data['name'] ?? '';
        _profession = data['profession'] ?? '';
        _gender = data['gender'] ?? '';
        _email = data['email'] ?? '';
        _phone = data['phone']?.toString() ?? '';
        _password = data['password'] ?? '';
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                const CircleAvatar(
                  radius: 70,
                  backgroundImage: AssetImage('assets/images/avater.jpg'),
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Username: $_username',
                        style: const TextStyle(fontSize: 20,overflow: TextOverflow.ellipsis,fontWeight: FontWeight.bold,),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: 50,
                        width: 335,
                        decoration:  BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(8),
                          gradient: const LinearGradient(
                            colors: [Color.fromARGB(255, 62, 219, 10), Color.fromARGB(255, 160, 32, 143)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          backgroundBlendMode: BlendMode.colorBurn,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Padding(padding: EdgeInsets.only(right: 20)),
                            const Icon(Icons.person),
                            const SizedBox(
                              width: 12,
                            ),
                            Text(
                              'Full Name: $_name',
                              style: const TextStyle(fontSize: 18,overflow: TextOverflow.ellipsis,fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      Container(
                        height: 50,
                        width: 335,
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(8),
                          gradient: const LinearGradient(
                            colors: [Color.fromARGB(255, 62, 219, 10), Color.fromARGB(255, 160, 32, 143)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          backgroundBlendMode: BlendMode.colorBurn,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Padding(padding: EdgeInsets.only(right: 20)),
                            const Icon(Icons.work),
                            const SizedBox(
                              width: 12,
                            ),
                            Text(
                              'Profession: $_profession',
                              style: const TextStyle(fontSize: 18,overflow: TextOverflow.ellipsis,fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      Container(
                        height: 50,
                        width: 335,
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(8),
                          gradient: const LinearGradient(
                            colors: [Color.fromARGB(255, 62, 219, 10), Color.fromARGB(255, 160, 32, 143)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          backgroundBlendMode: BlendMode.colorBurn,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Padding(padding: EdgeInsets.only(right: 20)),
                            const Icon(Icons.transgender),
                            const SizedBox(
                              width: 12,
                            ),
                            Text(
                              'Gender: $_gender',
                              style: const TextStyle(fontSize: 18,overflow: TextOverflow.ellipsis,fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      Container(
                        height: 50,
                        width: 335,
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(8),
                          gradient: const LinearGradient(
                            colors: [Color.fromARGB(255, 62, 219, 10), Color.fromARGB(255, 160, 32, 143)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          backgroundBlendMode: BlendMode.colorBurn,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Padding(padding: EdgeInsets.only(right: 20)),
                            const Icon(Icons.email),
                            const SizedBox(
                              width: 12,
                            ),
                            Text(
                              'Email: $_email',
                              style: const TextStyle(fontSize: 18,overflow: TextOverflow.ellipsis,fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      Container(
                        height: 50,
                        width: 335,
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(8),
                          gradient: const LinearGradient(
                            colors: [Color.fromARGB(255, 62, 219, 10), Color.fromARGB(255, 160, 32, 143)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          backgroundBlendMode: BlendMode.colorBurn,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Padding(padding: EdgeInsets.only(right: 20)),
                            const Icon(Icons.phone),
                            const SizedBox(
                              width: 12,
                            ),
                            Text(
                              'Phone: $_phone',
                              style: const TextStyle(fontSize: 18,overflow: TextOverflow.ellipsis,fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      Container(
                        height: 50,
                        width: 335,
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(8),
                          gradient: const LinearGradient(
                            colors: [Color.fromARGB(255, 62, 219, 10), Color.fromARGB(255, 160, 32, 143)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          backgroundBlendMode: BlendMode.colorBurn,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Padding(padding: EdgeInsets.only(right: 20)),
                            const Icon(Icons.key),
                            const SizedBox(
                              width: 12,
                            ),
                            Text(
                              'Password: ${'*' * _password.length}',
                              style: const TextStyle(fontSize: 18,overflow: TextOverflow.ellipsis,fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 40,
                  padding: const EdgeInsets.only(left: 215),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Profile_Edit()),
                      );
                    },
                    child: const Text('Edit Profile',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
