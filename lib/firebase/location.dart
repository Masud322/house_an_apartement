// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class DropdownPage extends StatefulWidget {
//   @override
//   _DropdownPageState createState() => _DropdownPageState();
// }

// class _DropdownPageState extends State<DropdownPage> {
//   late String selectedDivision;
//   late String selectedDistrict;
//   late String selectedArea;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Dropdowns'),
//       ),
//       body: Container(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             DropdownButton<String>(
//               hint: Text('Select Division'),
//               value: selectedDivision,
//               onChanged: (newValue) {
//                 setState(() {
//                   selectedDivision = newValue!;
//                   selectedDistrict = null;
//                   selectedArea = null;
//                 });
//               },
//               items: _buildDivisionDropdownItems(),
//             ),
//             SizedBox(height: 16.0),
//             DropdownButton<String>(
//               hint: Text('Select District'),
//               value: selectedDistrict,
//               onChanged: (newValue) {
//                 setState(() {
//                   selectedDistrict = newValue!;
//                   selectedArea = null;
//                 });
//               },
//               items: _buildDistrictDropdownItems(),
//             ),
//             SizedBox(height: 16.0),
//             DropdownButton<String>(
//               hint: Text('Select Area'),
//               value: selectedArea,
//               onChanged: (newValue) {
//                 setState(() {
//                   selectedArea = newValue!;
//                 });
//               },
//               items: _buildAreaDropdownItems(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   List<DropdownMenuItem<String>> _buildDivisionDropdownItems() {
//     return [      DropdownMenuItem<String>(        value: 'Dhaka',        child: Text('Dhaka'),      ),      DropdownMenuItem<String>(        value: 'Chittagong',        child: Text('Chittagong'),      ),      DropdownMenuItem<String>(        value: 'Rajshahi',        child: Text('Rajshahi'),      ),  ];    // Add more items as needed    ];
//   }

//   Object _buildDistrictDropdownItems() {
//     if (selectedDivision == null) {
//       return [];
//     }
//     return FirebaseFirestore.instance
//         .collection('districts')
//         .where('division', isEqualTo: selectedDivision)
//         .get()
//         .then((QuerySnapshot querySnapshot) {
//       return querySnapshot.docs.map((doc) {
//         return DropdownMenuItem<String>(
//           value: doc['name'],
//           child: Text(doc['name']),
//         );
//       }).toList();
//     });
//   }

//   Object _buildAreaDropdownItems() {
//     if (selectedDistrict == null) {
//       return [];
//     }
//     return FirebaseFirestore.instance
//         .collection('areas')
//         .where('district', isEqualTo: selectedDistrict)
//         .get()
//         .then((QuerySnapshot querySnapshot) {
//       return querySnapshot.docs.map((doc) {
//         return DropdownMenuItem<String>(
//           value: doc['name'],
//           child: Text(doc['name']),
//         );
//       }).toList();
//     });
//   }
// }
