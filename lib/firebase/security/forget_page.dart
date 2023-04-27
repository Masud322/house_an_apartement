// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class PhoneVerificationPage extends StatefulWidget {
//   @override
//   _PhoneVerificationPageState createState() => _PhoneVerificationPageState();
// }

// class _PhoneVerificationPageState extends State<PhoneVerificationPage> {
//   final _formKey = GlobalKey<FormState>();
//   final _phoneNumberController = TextEditingController();
//   final _auth = FirebaseAuth.instance;

//   void _submitPhoneNumber() async {
//     if (_formKey.currentState!.validate()) {
//       final phone = _phoneNumberController.text.trim();

//       await _auth.verifyPhoneNumber(
//         phoneNumber: phone,
//         verificationCompleted: (PhoneAuthCredential credential) async {
//           await _auth.signInWithCredential(credential);
//           print(
//               'Phone number automatically verified and signed in: ${_auth.currentUser!.phoneNumber}');
//         },
//         verificationFailed: (FirebaseAuthException e) {
//           if (e.code == 'invalid-phone-number') {
//             print('The provided phone number is not valid.');
//           }
//         },
//         codeSent: (String verificationId, int? resendToken) {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => VerificationCodePage(
//                 verificationId: verificationId,
//                 phoneNumber: phone,
//               ),
//             ),
//           );
//         },
//         codeAutoRetrievalTimeout: (String verificationId) {},
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Phone Verification'),
//       ),
//       body: Form(
//         key: _formKey,
//         child: Column(
//           children: [
//             TextFormField(
//               controller: _phoneNumberController,
//               keyboardType: TextInputType.phone,
//               decoration: InputDecoration(
//                 labelText: 'Phone Number',
//               ),
//               validator: (value) {
//                 if (value!.isEmpty) {
//                   return 'Please enter a phone number';
//                 }
//                 return null;
//               },
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _submitPhoneNumber,
//               child: Text('Verify'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class VerificationCodePage extends StatefulWidget {
//   final String verificationId;
//   final String phoneNumber;

//   VerificationCodePage(
//       {required this.verificationId, required this.phoneNumber});

//   @override
//   _VerificationCodePageState createState() => _VerificationCodePageState();
// }

// class _VerificationCodePageState extends State<VerificationCodePage> {
//   final _formKey = GlobalKey<FormState>();
//   final _codeController = TextEditingController();
//   final _passwordController = TextEditingController(); 
//   final _auth = FirebaseAuth.instance;

// void _submitCode() async {
//   if (_formKey.currentState!.validate()) {
//     final code = _codeController.text.trim();

//     try {
//       final credential = PhoneAuthProvider.credential(
//         verificationId: widget.verificationId,
//         smsCode: code,
//       );
//       await _auth.signInWithCredential(credential);

//       // Get the current user
//       final user = _auth.currentUser;

//       // Prompt the user to enter a new password
//       final newPassword = await showDialog<String>(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: Text('Create a new password'),
//           content: TextFormField(
//             obscureText: true,
//             decoration: InputDecoration(
//               labelText: 'New Password',
//             ),
//             validator: (value) {
//               if (value!.isEmpty) {
//                 return 'Please enter a new password';
//               }
//               return null;
//             },
//           ),
//           actions: [
//             ElevatedButton(
//               onPressed: () => Navigator.pop(context),
//               child: Text('Cancel'),
//             ),
//             ElevatedButton(
//               onPressed: () => Navigator.pop(context, _passwordController.text.trim()),
//               child: Text('Save'),
//             ),
//           ],
//         ),
//       );

//       // Update the user's password and navigate to the login page
//       if (newPassword != null) {
//         await user!.updatePassword(newPassword);
//         print('Password updated successfully');
//         Navigator.pushReplacementNamed(context, '/login');
//       }

//       print('Phone number verified and signed in: ${user!.phoneNumber}');
//     } catch (e) {
//       print('Error verifying phone number: $e');
//     }
//   }
// }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Enter Verification Code'),
//       ),
//       body: Form(
//         key: _formKey,
//         child: Column(
//           children: [
//             Text('Enter the verification code sent to ${widget.phoneNumber}'),
//             SizedBox(height: 20),
//             TextFormField(
//               controller: _codeController,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(
//                 labelText: 'Verification Code',
//               ),
//               validator: (value) {
//                 if (value!.isEmpty) {
//                   return 'Please enter the verification code';
//                 }
//                 return null;
//               },
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _submitCode,
//               child: Text('Verify'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
