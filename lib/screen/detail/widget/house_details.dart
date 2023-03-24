import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:house_an_apartement/chat/chatroom.dart';

class House_Details extends StatefulWidget {

  House_Details({super.key, required this.data});
  var data;

  @override
  State<House_Details> createState() => _House_DetailsState();
}

class _House_DetailsState extends State<House_Details> {
  
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final User? _user = FirebaseAuth.instance.currentUser;

  // String _name = '';

@override
void initState() {
  super.initState();
  if (_user != null) {
    // _fetchUserData();
  }
}

  // Future<void> _fetchUserData() async {
  //   final DocumentSnapshot<Map<String, dynamic>> snapshot =
  //       await _firestore.collection('user_profile').doc(_user!.uid).get();
  //   if (snapshot.exists) {
  //     final Map<String, dynamic>? data = snapshot.data();
  //     setState(() {
  //       _name = data!['name'] ?? '';
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  height: 250,
                  aspectRatio: 16 / 9,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: widget.data['imageURL'].length > 1,
                  viewportFraction: 1,
                ),
                items: List<Widget>.from(
                  widget.data['imageURL'].map((url) {
                    return Container(
                      width: 400,
                      child: Image.network(url, fit: BoxFit.cover),
                    );
                  }),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(25),
                child: Column(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          height: 18,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Text(
                                'House Name: ${widget.data['name']}',
                                style: const TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Text(
                                'Owner Name: ${widget.data['ownername']}',
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.purple,
                                    fontStyle: FontStyle.italic),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text(
                            '\nCategory: ${widget.data['category']}',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text(
                            'For: ${widget.data['gender']}',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text(
                            'Location: ${widget.data['area']} ${widget.data['district']}, ${widget.data['division']}',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text(
                            'Free Month: ${widget.data['free month']}',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text(
                            'Price: ৳${widget.data['price']} Per Month',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            const Padding(
                                padding: EdgeInsets.only(top: 10, bottom: 10)),
                            Container(
                              child: Row(
                                children: [
                                  Image.asset('assets/images/bedroom.png'),
                                  Text(
                                    '  Bedroom: ${widget.data['bedroom']}',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 68,
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Image.asset('assets/images/bath.png'),
                                  Text(
                                    '  Bathroom: ${widget.data['bathroom']}',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Row(
                          children: [
                            const Padding(
                                padding: EdgeInsets.only(top: 10, bottom: 10)),
                            Container(
                              child: Row(
                                children: [
                                  Image.asset('assets/images/kitchen.png'),
                                  Text(
                                    '  Kitchen: ${widget.data['kitchen']}',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 80,
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Image.asset('assets/images/parking.png'),
                                  Text(
                                    '  Parking: ${widget.data['parking']}',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 7),
                          child: Text(
                            '\nContact: ${widget.data['number']}',
                            style: const TextStyle(
                                fontSize: 16,
                                color: Colors.purple,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 28, bottom: 5),
                          child: Text(
                            'About:',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          '${widget.data['about']}\n\n',
                          style: const TextStyle(fontSize: 18),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChatRoom(
                                    recipientId: widget.data['userId'],
                                    data: widget.data,
                                  ),
                                ),
                              );
                            },
                            child: Text('Massage now')
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                // child: Text('House Name: ${data.docs[index]['name']}\nLocation: ${data.docs[index]['location']}\ncategory:${data.docs[index]['category']}\ngender: ${data.docs[index]['gender']}\n'),
              ),
            ],
          ),
        ),
      )),
    );
  }
}

