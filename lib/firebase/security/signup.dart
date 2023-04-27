import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:house_an_apartement/firebase/security/login.dart';
import 'package:house_an_apartement/firebase/security/otps_creen.dart';
import 'package:house_an_apartement/firebase/widget.dart';
import 'package:house_an_apartement/firebase/security/phone_auth_page.dart';

final TextEditingController usernameController = TextEditingController();
final TextEditingController nameController = TextEditingController();
final TextEditingController professionController = TextEditingController();
final TextEditingController genderController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();

class SignUp extends StatefulWidget {
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  bool _obsecureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rent an Apartement'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(9),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        child: const Text(
                      "Rent an",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo,
                        fontFamily: 'Shojumaru-Regular',
                      ),
                    )),
                    Container(
                        child: const Text(
                      "Apartement",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple,
                        fontFamily: 'Shojumaru-Regular',
                      ),
                    )),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      'Create Account',
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    const Text(
                      'Create a new account',
                      style: TextStyle(fontSize: 15, color: Colors.black54),
                    ),
                  ],
                ),
              ),
              SizedBox(
                child: SizedBox(
                  width: 350,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: usernameController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your username';
                            }
                            return null;
                          },
                          maxLength: 10,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          decoration: const InputDecoration(
                            labelText: 'User Name',
                            border: OutlineInputBorder(),
                            hintText: 'User Name',
                            prefixIcon: Icon(Icons.verified_user_sharp),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        TextFormField(
                          controller: nameController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your full name';
                            }
                            return null;
                          },
                          maxLines: 1,
                          maxLength: 16,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          decoration: const InputDecoration(
                            labelText: 'Full Name',
                            border: OutlineInputBorder(),
                            hintText: 'Full Name',
                            prefixIcon: Icon(Icons.person),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        TextFormField(
                          controller: professionController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your full profession';
                            }
                            return null;
                          },
                          maxLength: 12,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          decoration: const InputDecoration(
                            labelText: 'Profession',
                            border: OutlineInputBorder(),
                            hintText: 'Profession',
                            prefixIcon: Icon(Icons.work),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        TextFormField(
                          controller: genderController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your gender';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: 'Gender',
                            border: OutlineInputBorder(),
                            hintText: 'Gender',
                            helperText: 'Male/Female',
                            prefixIcon: Icon(Icons.transgender),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        TextFormField(
                          controller: emailController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(),
                            hintText: 'Email',
                            helperText: '..@gmail.com',
                            prefixIcon: Icon(Icons.email),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        TextFormField(
                          controller: passwordController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                          obscureText: _obsecureText,
                          maxLines: 1,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: const OutlineInputBorder(),
                            hintText: 'Password',
                            counterText: 'Minimum 6 characters',
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
                        const SizedBox(
                          height: 33,
                        ),
                        Container(
                          height: 48,
                          width: 350,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                try {
                                  await signUp(context);
                                } catch (e) {
                                  print(e);
                                }
                              }
                            },
                            child: const Text(
                              'CREATE ACCOUNT',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              width: 7,
                            ),
                            const Text(
                              'Already have an account?',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Login()),
                                );
                              },
                              child: const Text(
                                'Log In',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> signUp(BuildContext context) async {
  try {

    // Navigate to the Login screen if signUp is successful
    // ignore: use_build_context_synchronously
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => PhoneAuthPage(
                emailController: emailController,
                genderController: genderController,
                nameController: nameController,
                passwordController: passwordController,
                professionController: professionController,
                usernameController: usernameController,
              )),
    );

    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('SignUp Successfully')),
    );
  } on FirebaseAuthException catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      e.code == 'weak-password'
          ? const SnackBar(content: Text('The password provided is too weak.'))
          : const SnackBar(
              content: Text('The account already exists for that email.')),
    );
  } catch (e) {
  }
}