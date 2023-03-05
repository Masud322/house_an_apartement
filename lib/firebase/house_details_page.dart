// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';

// class House_details extends StatelessWidget {
//   final Stream<QuerySnapshot> users = FirebaseFirestore.instance.collection('users').snapshots();
  

//   @override
//   Widget build(BuildContext context) {
//     return 
//     Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//              StreamBuilder<QuerySnapshot>(stream: users,
//              builder: (BuildContext context,AsyncSnapshot<QuerySnapshot>snapshot){
//                       if (snapshot.hasError) {
//                         return Text('something went wrong');
//                       }
//                       if (snapshot.connectionState == ConnectionState.waiting){
//                         return Text('Loading');
//                       }
    
//                       final data = snapshot.requireData;
//                       return ListView.builder(
//                         itemCount: data.size,
//                         itemBuilder: ((context, index) {
//                           return Column(
//                             children: [
//                               Text('House Name: ${data.docs[index]['name']}')
//                             ],
//                           ) ;
//                         }));
//                     },)
//           ],
//         ),
//       ),
//     );
//   }
// }
// // Text('House Name: ${data.docs[index]['name']}\nLocation: ${data.docs[index]['location']}\ncategory:${data.docs[index]['category']}\ngender: ${data.docs[index]['gender']}\n');