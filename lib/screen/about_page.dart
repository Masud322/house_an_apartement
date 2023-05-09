import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        
        backgroundColor: const Color.fromARGB(255, 138, 220, 44),
        body:
        Center(
            child: Column(

          children:[
           const SizedBox(
            height: 100,
           ),
           const CircleAvatar(backgroundImage: AssetImage("assets/images/me.jpg"),
           radius: 60,
           ),
           const SizedBox(
            height: 30,
           ),
            Container(
              
              margin: EdgeInsets.only(left: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children:const [
                Text("App Name: Rent an Apartment\n",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.black),),
                Text('App Version: 1.000\n',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.black),),
                Text("Developed by Md. Masudur Rahman\n",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.black),),
                Text("Student Id: 11190120322\n",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.black),),
                Text("Email: masudurrahman5656@gmail.com",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.black),),
                ]
                
              ),
              
            
            )
          ],
        )));
  }
}