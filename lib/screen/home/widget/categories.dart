// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:house_an_apartement/screen/home/home_page.dart';

// class OTPVerificationPage extends StatefulWidget {
//   final String verificationId;
//   final String phoneNumber;

//   OTPVerificationPage({
//     required this.verificationId,
//     required this.phoneNumber,
//   });

//   @override
//   _OTPVerificationPageState createState() => _OTPVerificationPageState();
// }

// class _OTPVerificationPageState extends State<OTPVerificationPage> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   late String _otpCode;
//   bool _isLoading = false;
//   final List<TextEditingController> _controllers =
//       List.generate(6, (index) => TextEditingController());

//   Future<void> _submitOTPCode() async {
//     final form = _formKey.currentState;
//     if (form!.validate()) {
//       form.save();
//       setState(() {
//         _isLoading = true;
//       });

//       final otpCode = _controllers.fold<String>(
//         '',
//         (previousValue, controller) => previousValue + controller.text,
//       );

//       PhoneAuthCredential credential = PhoneAuthProvider.credential(
//         verificationId: widget.verificationId,
//         smsCode: otpCode,
//       );

//       try {
//         await FirebaseAuth.instance.signInWithCredential(credential);
//         // ignore: use_build_context_synchronously
//         Navigator.pushAndRemoveUntil(
//             context,
//             MaterialPageRoute(builder: (context) => HomePage()),
//             (route) => false);
//         // Navigate to home page after successful verification
//       } catch (e) {
//         setState(() {
//           _isLoading = false;
//         });
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//               content: Text(e is FirebaseAuthException
//                   ? e.message ?? 'An error occurred'
//                   : 'An error occurred')),
//         );
//       }
//     }
//   }

//   @override
//   void dispose() {
//     for (final controller in _controllers) {
//       controller.dispose();
//     }
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Verify OTP')),
//       body: Form(
//         key: _formKey,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'Enter the OTP code sent to ${widget.phoneNumber}',
//               style: const TextStyle(fontSize: 18.0),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 16.0),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 _buildOTPTextField(0),
//                 _buildOTPTextField(1),
//                 _buildOTPTextField(2),
//                 _buildOTPTextField(3),
//                 _buildOTPTextField(4),
//                 _buildOTPTextField(5),
//               ],
//             ),
//             const SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: _isLoading ? null : _submitOTPCode,
//               child:
//                   _isLoading ? const CircularProgressIndicator() : const Text('Verify OTP'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildOTPTextField(int index) {
//     return SizedBox(
//       width: 50.0,
//       child: TextFormField(
//         decoration: const InputDecoration(
//           border: OutlineInputBorder(
            
//           )
//         ),
//         controller: _controllers[index],
//         textAlign: TextAlign.center,
//         keyboardType: TextInputType.number,
//         maxLength: 1,
//         validator: (value) {
//           if (value!.isEmpty) {
//             return 'Please enter a digit';
//           }
//           return null;
//         },
//         onChanged: (value) {
//           if (value.isNotEmpty) {
//             FocusScope.of(context).nextFocus();
//           } else {
//             FocusScope.of(context).previousFocus();
//           }
//         },
//       ),
//     );
//   }
// }
