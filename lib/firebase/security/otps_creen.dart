import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:house_an_apartement/firebase/security/signup.dart';
import 'package:house_an_apartement/home_page.dart';

class OTPScreen extends StatefulWidget {
  final String verificationId;
  final String phoneNumber;

  var usernameController;

  var nameController;

  var professionController;

  var genderController;

  var emailController;

  var passwordController;

  OTPScreen({
    required this.verificationId,
    required this.phoneNumber,
    required this.usernameController,
    required this.nameController,
    required this.professionController,
    required this.genderController,
    required this.emailController,
    required this.passwordController,
  });

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String _otpCode;
  bool _isLoading = false;
  final List<TextEditingController> _controllers =
      List.generate(6, (index) => TextEditingController());

Future<void> _submitOTPCode() async {
  final form = _formKey.currentState;
  if (form!.validate()) {
    form.save();
    setState(() {
      _isLoading = true;
    });

    final otpCode = _controllers.fold<String>(
      '',
      (previousValue, controller) => previousValue + controller.text,
    );

    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: widget.verificationId,
      smsCode: otpCode,
    );

    try {
      // sign in the user with the OTP credential
      await FirebaseAuth.instance.signInWithCredential(credential);

      // create a new user with the email and password entered by the user
      final UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // save the user data in the database
      await setUserDoc(
        userCredential.user!.uid,
        widget.usernameController.text,
        widget.nameController.text,
        widget.professionController.text,
        widget.genderController.text,
        widget.emailController.text,
        widget.passwordController.text,
        int.parse(widget.phoneNumber),
      );

      // navigate to the home page
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
          (route) => false);
    } on FirebaseAuthException catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        e.code == 'weak-password'
            ? const SnackBar(
                content: Text('The password provided is too weak.'))
            : const SnackBar(
                content: Text('The account already exists for that email.')),
      );
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(e is FirebaseAuthException
                ? e.message ?? 'An error occurred'
                : 'An error occurred')),
      );
    }
  }
}



  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verify OTP')),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Phone Verification',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              'Enter the OTP code sent to ${widget.phoneNumber}',
              style: const TextStyle(fontSize: 18.0),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildOTPTextField(0),
                _buildOTPTextField(1),
                _buildOTPTextField(2),
                _buildOTPTextField(3),
                _buildOTPTextField(4),
                _buildOTPTextField(5),
              ],
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _isLoading ? null : _submitOTPCode,
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Verify OTP'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOTPTextField(int index) {
    return SizedBox(
      width: 50.0,
      child: TextFormField(
        decoration: const InputDecoration(border: OutlineInputBorder()),
        controller: _controllers[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter a digit';
          }
          return null;
        },
        onChanged: (value) {
          if (value.isNotEmpty) {
            FocusScope.of(context).nextFocus();
          } else {
            FocusScope.of(context).previousFocus();
          }
        },
      ),
    );
  }
}

Future<void> setUserDoc(
  String uid,
  String username,
  String name,
  String profession,
  String gender,
  String email,
  String password,
  int phoneNumber,
) async {
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('user_profile');
  final DocumentReference userDoc = usersCollection.doc(uid);

  await userDoc.set({
    'username': username,
    'ownername': name,
    'profession': profession,
    'gender': gender,
    'password': password,
    'email': email,
    'phone': phoneNumber,
  });
}
