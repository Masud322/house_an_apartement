import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:house_an_apartement/firebase/profile.dart';
import 'package:house_an_apartement/firebase/widget.dart';
import 'package:house_an_apartement/screen/home/home_page.dart';

final TextEditingController usernameController = TextEditingController();
final TextEditingController nameController = TextEditingController();
final TextEditingController professionController = TextEditingController();
final TextEditingController genderController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController phoneController = TextEditingController();
final TextEditingController passwordController = TextEditingController();

// ignore: camel_case_types
class Profile_Edit extends StatefulWidget {
  const Profile_Edit({Key? key}) : super(key: key);

  @override
  _Profile_EditState createState() => _Profile_EditState();
}

class _Profile_EditState extends State<Profile_Edit> {
  bool _obsecureText = true;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final User? _user = FirebaseAuth.instance.currentUser;
  final User user = FirebaseAuth.instance.currentUser!;

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

  Future<void> _saveUserData() async {
    final Map<String, dynamic> data = <String, dynamic>{
      'username': usernameController.text,
      'ownername': nameController.text,
      'profession': professionController.text,
      'gender': genderController.text,
      'email': emailController.text,
      'phone': int.parse(phoneController.text),
      'password': passwordController.text,
    };
    await _firestore.collection('user_profile').doc(_user!.uid).update(data);
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('User data updated successfully')),
    );
  }

  @override
  Widget build(BuildContext context) {
    usernameController.text = _username;
    nameController.text = _name;
    professionController.text = _profession;
    genderController.text = _gender;
    emailController.text = _email;
    phoneController.text = _phone;
    passwordController.text = _password;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text('Rent an Apartment'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Container(
                    padding:
                        const EdgeInsets.only(right: 255, top: 5, bottom: 5),
                    child: const Text(
                      'Edit Profile',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    )),
                
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Container(
                    height: 70,
                    width: 160,
                    child: TextFormField(
                      controller: usernameController,
                      maxLength: 10,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        labelText: 'Username',
                        border: OutlineInputBorder(),
                        hintText: 'Username',
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  height: 70,
                  width: 335,
                  child: TextFormField(
                    controller: nameController,
                    maxLength: 18,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    decoration: const InputDecoration(
                      labelText: 'Full Name',
                      border: OutlineInputBorder(),
                      hintText: 'Full Name',
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  height: 70,
                  width: 335,
                  child: TextFormField(
                    controller: professionController,
                    maxLength: 12,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    decoration: const InputDecoration(
                      labelText: 'Profession',
                      border: OutlineInputBorder(),
                      hintText: 'Profession',
                      prefixIcon: Icon(Icons.work),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  height: 70,
                  width: 335,
                  child: TextFormField(
                    controller: genderController,
                    decoration: const InputDecoration(
                      labelText: 'Gender',
                      border: OutlineInputBorder(),
                      helperText: 'Male/Female',
                      hintText: 'Gender',
                      prefixIcon: Icon(Icons.transgender),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  height: 70,
                  width: 335,
                  child: TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      helperText: '..@gmail.com',
                      border: OutlineInputBorder(),
                      hintText: 'Email',
                      prefixIcon: Icon(Icons.email),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  height: 70,
                  width: 335,
                  child: TextFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    maxLength: 11,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    decoration: const InputDecoration(
                      labelText: 'Phone',
                      border: OutlineInputBorder(),
                      hintText: 'Phone',
                      prefixIcon: Icon(Icons.phone),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  height: 70,
                  width: 335,
                  child: TextFormField(
                    controller: passwordController,
                    obscureText: _obsecureText,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: const OutlineInputBorder(),
                      counterText: 'Minimum 6 characters',
                      hintText: 'Password',
                      prefixIcon: const Icon(Icons.key),
                      suffixIcon: GestureDetector(
                        onTap: (() {
                          setState(() {
                            _obsecureText = !_obsecureText;
                          });
                        }),
                        child: Icon(_obsecureText
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: () {
                    _saveUserData(); // Call the method to save user data
                      Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()), // Navigate to another page
                      );
                  },
                  child: const Text(
                    'Save',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
