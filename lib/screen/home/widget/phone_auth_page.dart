import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:house_an_apartement/firebase/security/otps_creen.dart';
import 'package:house_an_apartement/firebase/security/signup.dart';

class PhoneAuthPage extends StatefulWidget {
  var usernameController;
  
  var nameController;
  
  var professionController;
  
  var genderController;
  
  var emailController;

  var passwordController;

  PhoneAuthPage({
    required this.usernameController,
    required this.nameController,
    required this.professionController,
    required this.genderController,
    required this.emailController,
    required this.passwordController
  });
  @override
  _PhoneAuthPageState createState() => _PhoneAuthPageState();
}

class _PhoneAuthPageState extends State<PhoneAuthPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String _phoneNumber;
  bool _isLoading = false;

  Future<void> _submitPhoneNumber() async {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      setState(() {
        _isLoading = true;
      });

      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: _phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) {
          // auto-verification (if possible)
        },
        verificationFailed: (FirebaseAuthException e) {
          setState(() {
            _isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(content: Text(e is FirebaseAuthException ? e.message ?? 'An error occurred' : 'An error occurred')),
);
        },
        codeSent: (String verificationId, int? resendToken) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OTPScreen(
                verificationId: verificationId,
                phoneNumber: _phoneNumber, emailController: widget.emailController, genderController: widget.genderController, nameController: widget.nameController, passwordController: widget.passwordController, professionController: widget.professionController, usernameController: widget.usernameController,
              ),
            ),
          );print(nameController);
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
        timeout: const Duration(seconds: 60),
      );

      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Enter Phone Number')),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            const Text('Phone Verification',style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold),),
            const SizedBox(
              height: 5,
            ),
            const Text('Enter Your Phone Number',style: TextStyle(fontSize: 18,),),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your phone number',
                  labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                ],
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
                onSaved: (value) {
                  _phoneNumber = '+88$value'; // Assuming US phone numbers
                },
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _isLoading ? null : _submitPhoneNumber,
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Send OTP'),
            ),
          ],
        ),
      ),
    );
  }
}


