import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:house_an_apartement/firebase/house_details_page.dart';
import 'package:house_an_apartement/screen/detail/widget/house_details.dart';

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
    _stream = FirebaseFirestore.instance.collection('test').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 10),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search',
              prefixIcon: const Icon(Icons.search),
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
        Padding(
          padding: const EdgeInsets.only(right: 265, top: 10, bottom: 18),
          child: Container(
            padding: const EdgeInsets.only(bottom: 4.0),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.purple,
                  width: 2.0,
                ),
              ),
            ),
            child: const Text(
              'All Post Here',
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple),
            ),
          ),
        ),
        StreamBuilder<QuerySnapshot>(
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
                      final List<dynamic> urls =
                          filteredDocs[index]['imageURL'];
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 0, right: 15),
                                    child: Container(
                                      height: 80,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 0.0),
                                        child: urls.isNotEmpty
                                            ? Image.network(urls[0],
                                            fit: BoxFit.cover,)
                                            : Container(),
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
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
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
                                            '${'Price: ৳ ' + filteredDocs[index]['price']} Taka',
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
                                            '${'\u{1F4CD}' + filteredDocs[index]['area']} ${filteredDocs[index]['district']}, ${filteredDocs[index]['division']}',
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
      ]),
    );
  }
}
