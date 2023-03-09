// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:house_an_apartement/screen/detail/widget/house_details.dart';

// class SearchPage extends StatefulWidget {

//   @override
//   _SearchPageState createState() => _SearchPageState();
// }

// class _SearchPageState extends State<SearchPage> {
//   final FirebaseFirestore _db = FirebaseFirestore.instance;
//   List<DocumentSnapshot> _divisionList = [];
//   List<DocumentSnapshot> _districtList = [];
//   List<DocumentSnapshot> _areaList = [];
//   String _searchText = '';
  

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Search'),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextField(
//               onChanged: (value) {
//                 setState(() {
//                   _searchText = value;
//                 });
                
//                 _searchData(value);
//               },
//               decoration: InputDecoration(
//                 hintText: 'Search',
//                 prefixIcon: Icon(Icons.search),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//             child: _buildSearchResults(),
//           ),
//         ],
//       ),
//     );
//   }

//   void _searchData(String searchText) {
//     _db.collection('users').where('division', isEqualTo: searchText).get().then((value) {
//       setState(() {
//         _divisionList = value.docs;
//       });
//     });
    
//     _db.collection('users').where('district', isEqualTo: searchText).get().then((value) {
//       setState(() {
//         _districtList = value.docs;
//       });
//     });
    
//     _db.collection('users').where('area', isEqualTo: searchText).get().then((value) {
//       setState(() {
//         _areaList = value.docs;
//       });
//     });
//   }

//   Widget _buildSearchResults() {
//     List<DocumentSnapshot> _searchResults = [];
    
//     if (_searchText.isNotEmpty) {
//       _divisionList.forEach((division) {
//         _searchResults.add(division);
//       });
      
//       _districtList.forEach((district) {
//         _searchResults.add(district);
//       });
      
//       _areaList.forEach((area) {
//         _searchResults.add(area);
//       });
//     }
    
//     return ListView.builder(
//       itemCount: _searchResults.length,
//       itemBuilder: (context, index) {
//         DocumentSnapshot document = _searchResults[index];
//         String type = '';
        
//         if (_divisionList.contains(document)) {
//           type = 'Division';
//         } else if (_districtList.contains(document)) {
//           type = 'District';
//         } else if (_areaList.contains(document)) {
//           type = 'Area';
//         }
        
//         var snapshot;
//         return ListView.builder(
//             physics: const NeverScrollableScrollPhysics(),
//             scrollDirection: Axis.vertical,
//             shrinkWrap: true,
//             itemCount: snapshot.data!.docs.length,
//             itemBuilder: ((context, index) => GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => House_Details(
//                           data: snapshot.data!.docs[index],
//                         ),
//                       ),
//                     );
//                   },
//                   child: Padding(
//                     padding:
//                         const EdgeInsets.only(left: 21, right: 21, bottom: 10),
//                     child: Container(
//                         height: 100,
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                             color: Colors.purple, // Change the border color here
//                             width: 1.0,
//                           ),
//                           // color: const Color.fromARGB(255, 187, 187, 187),
//                           borderRadius: BorderRadius.circular(15),
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             const SizedBox(width: 10),
//                             Expanded(
//                               child: Padding(
//                                 padding: const EdgeInsets.only(left: 0,right: 15),
//                                 child: Container(
//                                   height: 80,
//                                   decoration: BoxDecoration(
//                                     // color: Colors.green,
//                                     borderRadius: BorderRadius.circular(12),
//                                   ),
//                                   child: Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 0.0),
//                                     child: Image.network(
//                                       "https://images.pexels.com/photos/106399/pexels-photo-106399.jpeg",
//                                       fit: BoxFit.cover,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             Expanded(
//                               child: Container(
//                                 height: 80,
//                                 decoration: const BoxDecoration(
//                                   // color: Colors.blue,
//                                 ),
//                                 child: Column(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceEvenly,
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Padding(
//                                       padding: const EdgeInsets.only(
//                                           left: 8.0),
//                                       child: Text(
//                                         snapshot.data!.docs[index]['name'],
//                                         overflow: TextOverflow.ellipsis,
//                                         style: const TextStyle(
//                                             color: Colors.black,
//                                             fontSize: 17,
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.symmetric(
//                                           horizontal: 8.0),
//                                       child: Text(
//                                         '${'Price: ৳' + snapshot.data!.docs[index]['price']} Taka',
//                                         overflow: TextOverflow.ellipsis,
//                                         style: const TextStyle(
//                                             color: Colors.black54,
//                                             fontSize: 12,
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.symmetric(
//                                           horizontal: 8.0),
//                                       child: Text(
//                                         '${ snapshot.data!.docs[index]['area']} ${snapshot.data!.docs[index]['district']}, ${snapshot.data!.docs[index]['division']}',
//                                         overflow: TextOverflow.ellipsis,
//                                         style: const TextStyle(
//                                             color: Colors.black54,
//                                             fontSize: 12,
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(width: 10),
//                           ],
//                         )),
//                   ),
//                 )),
//           );
//       },
//     );
//   }
// }
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';


// class SearchPage extends StatefulWidget {
//   @override
//   _SearchPageState createState() => _SearchPageState();
// }

// class _SearchPageState extends State<SearchPage> {
//   TextEditingController _searchController = TextEditingController();
//   List<String> _nameList = [];
//   List<String> _filteredList = [];

//   @override
//   void initState() {
//     super.initState();
//     _getNameList();
//   }

//   Future<void> _getNameList() async {
//     // Retrieve data from Firestore
//     QuerySnapshot snapshot =
//         await FirebaseFirestore.instance.collection('users').get();
//     List<String> names =
//         snapshot.docs.map((doc) => doc.data()!['name'] as String).toList();
//     setState(() {
//       _nameList = names;
//       _filteredList = names;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Searchable ListView'),
//       ),
//       body: Column(
//         children: <Widget>[
//           TextField(
//             controller: _searchController,
//             onChanged: (value) {
//               setState(() {
//                 _filteredList = _nameList
//                     .where((name) =>
//                         name.toLowerCase().contains(value.toLowerCase()))
//                     .toList();
//               });
//             },
//             decoration: InputDecoration(
//               labelText: "Search",
//               hintText: "Search for a name",
//               prefixIcon: Icon(Icons.search),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.all(
//                   Radius.circular(25.0),
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: _filteredList.length,
//               itemBuilder: (BuildContext context, int index) {
//                 return ListTile(
//                   title: Text(_filteredList[index]),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
