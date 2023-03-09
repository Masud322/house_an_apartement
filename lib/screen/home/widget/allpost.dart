import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:house_an_apartement/firebase/house_details_page.dart';
import 'package:house_an_apartement/screen/detail/widget/house_details.dart';

// class AllPost extends StatelessWidget {

//   @override
//   Widget build(BuildContext context) {
  

//     return StreamBuilder(
//       stream: FirebaseFirestore.instance.collection('users').snapshots(),
//       builder: ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         if (snapshot.hasData) {
//           return ListView.builder(
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
//         } else {
//           return Container();
//         }
//       }),
//     );
//   }
// }

class AllPost extends StatefulWidget {

  @override
  _AllPostState createState() => _AllPostState();
}

class _AllPostState extends State<AllPost> {
  late Stream<QuerySnapshot> _stream;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _stream = FirebaseFirestore.instance.collection('users').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 10),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
            },
          ),
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
              stream: _stream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final filteredDocs = snapshot.data!.docs.where((doc) {
                    final name = doc['name'].toString().toLowerCase();
                    final area = doc['area'].toString().toLowerCase();
                    final district = doc['district'].toString().toLowerCase();
                    final division = doc['division'].toString().toLowerCase();
                    final searchQuery = _searchQuery.toLowerCase();
                    return name.contains(searchQuery) ||
                        area.contains(searchQuery) ||
                        district.contains(searchQuery) ||
                        division.contains(searchQuery);
                  }).toList();

                  return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: filteredDocs.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => House_Details(
                                  data: filteredDocs[index],
                                ),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 21, right: 21, bottom: 10),
                            child: Container(
                              height: 100,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.purple,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 0, right: 15),
                                      child: Container(
                                        height: 80,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 0.0),
                                          child: Image.network(
                                            "https://images.pexels.com/photos/106399/pexels-photo-106399.jpeg",
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: 80,
                                      decoration: const BoxDecoration(),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Text(
                                              filteredDocs[index]['name'],
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Text(
                                              '${'Price: ৳' + filteredDocs[index]['price']} Taka',
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Text(
                                              '${filteredDocs[index]['area']} ${filteredDocs[index]['district']}, ${filteredDocs[index]['division']}',
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                } else {
                  return Container();
                }
              }),
        ),
      ]),
    );
  }
}
