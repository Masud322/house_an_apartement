import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:house_an_apartement/firebase/profile.dart';
import 'package:house_an_apartement/firebase/security/forget_page.dart';
import 'package:house_an_apartement/firebase/security/signup.dart';
import 'package:house_an_apartement/firebase/widget.dart';
import 'package:house_an_apartement/screen/home/home_page.dart';
import 'package:house_an_apartement/firebase/security/phone_auth_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(HomePage()); 
}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  @override
  void initState() {
    super.initState();
    // Check if the user is already logged in
    checkLogin();
  }

  void checkLogin() async {
    if (_auth.currentUser != null) {
      // If the user is already logged in, update the _isLoggedIn variable
      setState(() {
        _isLoggedIn = true;
      });
    }
  }

  bool _isLoggedIn = false;


  final _auth = FirebaseAuth.instance;
  bool _obsecureText = true;
  late String email;
  late String Password;

  // AlertDialog();

  
  @override
  Widget build(BuildContext context) {
     if (_isLoggedIn) {
      // If the user is already logged in, skip the login flow and show the main app screen
      return HomePage();
      } else {
    return
    Scaffold(
      appBar: AppBar(
        title: const Text('House an Apartement'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
            Container(
                
                child:Column(
                children: [
                  Padding(padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      
                      child: const Text("Rent an",style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold,color: Colors.indigo,fontFamily: 'Shojumaru-Regular',),)
                      
                    ),
                    Container(
                      
                      child: const Text("Apartement",style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold,color: Colors.purple,fontFamily: 'Shojumaru-Regular',),)
                      
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                 const Text('Welcome Back',style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold,color: Colors.black),),
                 const SizedBox(
                  height: 3,
                 ),
                 const Text('Sign to continue',style: TextStyle(fontSize: 15,color: Colors.black54),),
                  ],
                ),
                    ],
                  )
                ],
              ),),
                ],
              )
              ),
            SizedBox( 
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 70,
                      ),
                      SizedBox(
                        width: 350,
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
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        width: 350,
                        child: TextField(
                          obscureText: _obsecureText,
                          onChanged: (value) {
                            Password = value;
                          },
                          decoration:  InputDecoration(
                            labelText: 'Password',
                            border: const OutlineInputBorder(),
                            hintText: 'Password',
                            prefixIcon: const Icon(Icons.key),
                            suffixIcon: GestureDetector(
                              onTap: (() {
                                setState(() {
                                  _obsecureText=!_obsecureText;
                                });
                              }
                              ),
                              child: Icon(_obsecureText ?Icons.visibility:Icons.visibility_off),
                            ),
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 10,),
                        
                      Container(
                        padding: EdgeInsets.only(left: 190),
                        child: TextButton(
                          onPressed: (){
                          Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Forget_Page(context: context,)),
                          
                        );
                        }, child: const Text('Forget Password',style: TextStyle(color: Colors.blue),)),
                      ),
                    
                      Container(
                        width: 350,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () async{
                        
                    
                        try{
                            await _auth.signInWithEmailAndPassword(email: email, password: Password).then((value) =>
                            Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                          
                        ),
                        
                        );
                        
                          }
                          catch(e){
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Login Error')),
                                );
                            print('Failed $e');
                          }
                        }, child: const Text('LOGIN',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),)),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                      width: 8,
                    ),
        
                    const Text("Don't have account?",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
        
                    TextButton(
                  onPressed: () {
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  SignUp()),
                  );
                  },
                 child: const Text('create new account',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.blue),)),
        
                   ],
                 ),    
                    ],
                  ),
                ),
              
              
            ),
            ],
            ),
        ),
      )
    );
      }
  }
}