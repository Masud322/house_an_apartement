// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class DivisionDistrictDropdowns extends StatefulWidget {
  
//   @override
//   _DivisionDistrictDropdownsState createState() =>
//       _DivisionDistrictDropdownsState();
// }

// class _DivisionDistrictDropdownsState extends State<DivisionDistrictDropdowns> {
//   late String selectedDivision = '';
//   late String selectedDistrict = '';
//   late String selectedArea = '';

//   @override
//   void initState() {
//     super.initState();
//     selectedDivision = '';
//     selectedDistrict = '';
//     selectedArea = '';
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: 
//       Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Padding(
//                   padding: EdgeInsets.all(12),
//                   child: StreamBuilder<QuerySnapshot>(
//                     stream: FirebaseFirestore.instance
//                         .collection('Divisions')
//                         .snapshots(),
//                     builder: (BuildContext context,
//                         AsyncSnapshot<QuerySnapshot> snapshot) {
//                       if (!snapshot.hasData) {
//                         return const CircularProgressIndicator();
//                       }
//                       List<DropdownMenuItem<String>> items = [];
//                       for (var doc in snapshot.data!.docs) {
//                         items.add(
//                           DropdownMenuItem(
//                             value: doc['name'],
//                             child: Text(doc['name']),
//                           ),
//                         );
//                       }
//                       if (selectedDivision.isEmpty && items.isNotEmpty) {
//                         selectedDivision = items.first.value!;
//                       }
//                       return DropdownButtonFormField<String>(
//                         decoration: InputDecoration(
//                           label: const Text('Select Division'),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                         ),
//                         items: items,
//                         onChanged: (i) {
//                           setState(() {
//                             selectedDivision = i!;
//                             selectedDistrict = '';
//                             selectedArea = '';
//                           });
//                         },
//                         value: selectedDivision,
//                       );
//                     },
//                   ),
//                 ),
    
//                 Padding(
//                   padding: EdgeInsets.all(12),
//                   child: StreamBuilder<QuerySnapshot>(
//                     stream: FirebaseFirestore.instance
//                         .collection('Districts')
//                         .where('division', isEqualTo: selectedDivision)
//                         .snapshots(),
//                     builder: (BuildContext context,
//                         AsyncSnapshot<QuerySnapshot> snapshot) {
//                       if (!snapshot.hasData) {
//                         return const CircularProgressIndicator();
//                       }
//                       List<DropdownMenuItem<String>> items = [];
//                       for (var doc in snapshot.data!.docs) {
//                         items.add(
//                           DropdownMenuItem(
//                             value: doc['name'],
//                             child: Text(doc['name']),
//                           ),
//                         );
//                       }
//                       if (selectedDistrict.isEmpty && items.isNotEmpty) {
//                         selectedDistrict = items.first.value!;
//                       }
//                       return DropdownButtonFormField<String>(
//                         decoration: InputDecoration(
//                           label: const Text('Select District'),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                         ),
//                         items: items,
//                         onChanged: (i) {
//                           setState(() {
//                             selectedDistrict = i!;
//                             selectedArea = '';
//                           });
//                         },
//                         value: selectedDistrict,
//                       );
//                     },
//                   ),
//                 ),
    
//                 Padding(
//                   padding: EdgeInsets.all(12),
//                   child: StreamBuilder<QuerySnapshot>(
//                     stream: FirebaseFirestore.instance
//                         .collection('Areas')
//                         .where('district', isEqualTo: selectedDistrict)
//                         .snapshots(),
//                     builder: (BuildContext context,
//                         AsyncSnapshot<QuerySnapshot> snapshot) {
//                       if (!snapshot.hasData) {
//                         return const CircularProgressIndicator();
//                       }
//                       List<DropdownMenuItem<String>> items = [];
//                       for (var doc in snapshot.data!.docs) {
//                         items.add(
//                           DropdownMenuItem(
//                             value: doc['name'],
//                             child: Text(doc['name']),
//                           ),
//                         );
//                       }
//                       if (selectedArea.isEmpty && items.isNotEmpty) {
//                         selectedArea = items.first.value!;
//                       }
//                       return DropdownButtonFormField<String>(
//                         decoration: InputDecoration(
//                           label: const Text('Select District'),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                         ),
//                         items: items,
//                         onChanged: (i) {
//                           setState(() {
//                             // selectedDistrict = value!;
//                             selectedArea = '';
//                           });
//                         },
//                         value: selectedArea,
//                       );
//                     },
//                   ),
//                 ),
    
//                 SizedBox(height: 16),
//                 ElevatedButton(
//                   onPressed: () {
//                     FirebaseFirestore.instance
//                         .collection('test')
//                         .doc('user_id_here')
//                         .set({
//                       'division': selectedDivision,
//                       'district': selectedDistrict,
//                     });
//                   },
//                   child: Text('Save'),
//                 ),
//               ],
//             ),
//     );
//   }
// }

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class MyForm extends StatefulWidget {
//   @override
//   _MyFormState createState() => _MyFormState();
// }

// class _MyFormState extends State<MyForm> {
//   String? _selectedDivision;
//   String? _selectedDistrict;
//   String? _selectedArea;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: 
//       Column(
//       children: [
//         StreamBuilder<QuerySnapshot>(
//           stream: FirebaseFirestore.instance.collection('Divisions').snapshots(),
//           builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//             if (!snapshot.hasData) {
//               return const CircularProgressIndicator();
//             }

//             final List<DropdownMenuItem<String>> divisionItems = [];
//             snapshot.data!.docs.forEach((divisionDoc) {
//               final String divisionName = divisionDoc['name'];
//               divisionItems.add(
//                 DropdownMenuItem(
//                   value: divisionName,
//                   child: Text(divisionName),
//                 ),
//               );
//             });

//             return DropdownButtonFormField<String>(
//               value: _selectedDivision,
//               items: divisionItems,
//               onChanged: (value) {
//                 setState(() {
//                   _selectedDivision = value;
//                   _selectedDistrict = null;
//                   _selectedArea = null;
//                 });
//               },
//               decoration: const InputDecoration(
//                 labelText: 'Division',
//               ),
//             );
//           },
//         ),
//         StreamBuilder<QuerySnapshot>(
//           stream: FirebaseFirestore.instance
//               .collection('Districts')
//               .where('division', isEqualTo: _selectedDivision)
//               .snapshots(),
//           builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//             if (!snapshot.hasData) {
//               return const CircularProgressIndicator();
//             }

//             final List<DropdownMenuItem<String>> districtItems = [];
//             snapshot.data!.docs.forEach((districtDoc) {
//               final String districtName = districtDoc['name'];
//               districtItems.add(
//                 DropdownMenuItem(
//                   value: districtName,
//                   child: Text(districtName),
//                 ),
//               );
//             });

//             return DropdownButtonFormField<String>(
//               value: _selectedDistrict,
//               items: districtItems,
//               onChanged: (value) {
//                 setState(() {
//                   _selectedDistrict = value;
//                   _selectedArea = null;
//                 });
//               },
//               decoration: const InputDecoration(
//                 labelText: 'District',
//               ),
//             );
//           },
//         ),
//         StreamBuilder<QuerySnapshot>(
//           stream: FirebaseFirestore.instance
//               .collection('Areas')
//               .where('district', isEqualTo: _selectedDistrict)
//               .snapshots(),
//           builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//             if (!snapshot.hasData) {
//               return const CircularProgressIndicator();
//             }

//             final List<DropdownMenuItem<String>> areaItems = [];
//             snapshot.data!.docs.forEach((areaDoc) {
//               final String areaName = areaDoc['name'];
//               areaItems.add(
//                 DropdownMenuItem(
//                   value: areaName,
//                   child: Text(areaName),
//                 ),
//               );
//             });

//             return DropdownButtonFormField<String>(
//               value: _selectedArea,
//               items: areaItems,
//               onChanged: (value) {
//                 setState(() {
//                   _selectedArea = value;
//                 });
//               },
//               decoration: const InputDecoration(
//                 labelText: 'Area',
//               ),
//             );
//           },
//         ),
//       ],
//     )
//     );
//   }
// }
