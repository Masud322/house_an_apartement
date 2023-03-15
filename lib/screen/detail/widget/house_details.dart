import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class House_Details extends StatefulWidget {
  House_Details({super.key, required this.data});
  var data;

  @override
  State<House_Details> createState() => _House_DetailsState();
}

class _House_DetailsState extends State<House_Details> {
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
                                    fontSize: 20, fontWeight: FontWeight.bold),
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
                          child: ElevatedButton(
                            onPressed: () {
                              print(widget.data);
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              backgroundColor: Theme.of(context).primaryColor,
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: const Text(
                                'Message Now',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
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

/**
 * Center(
        child: StreamBuilder<QuerySnapshot>(
          stream: users,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text('something went wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text('Loading');
            }

            final data = snapshot.requireData;

            return ListView.builder(
              itemCount: data.size,
              itemBuilder: ((context, index) {
                return Container(
                  padding: const EdgeInsets.all(6),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // // mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        height: 9,
                      ),
                      Text(
                        'House Name: ${data.docs[index]['name']}',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '\nCategory: ${data.docs[index]['category']}\nGender: ${data.docs[index]['gender']}\nLocation: ${data.docs[index]['location']}\nFree Month: ${data.docs[index]['free month']}\nPrice: ${data.docs[index]['price']}\n',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Container(
                            child: Row(
                              children: [
                                Image.asset('assets/images/bedroom.png'),
                                Text(
                                  '  Bedroom: ${data.docs[index]['bedroom']}',
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
                                  '  Bathroom: ${data.docs[index]['bathroom']}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Container(
                            child: Row(
                              children: [
                                Image.asset('assets/images/kitchen.png'),
                                Text(
                                  '  Kitchen: ${data.docs[index]['kitchen']}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),

                          // Container(
                          //  child:Text('Kitchen: ${data.docs[index]['kitchen']}',style: TextStyle(fontSize: 16),),
                          // ),
                          const SizedBox(
                            width: 80,
                          ),
                          Container(
                            child: Row(
                              children: [
                                Image.asset('assets/images/parking.png'),
                                Text(
                                  '  Parking: ${data.docs[index]['parking']}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        '\nAbout: ${data.docs[index]['about']}\n\n',
                        style: const TextStyle(fontSize: 16),
                      ),
                      Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: ElevatedButton(
                              onPressed: () {
                                print(data);
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                backgroundColor: Theme.of(context).primaryColor,
                              ),
                              child: Container(
                                  alignment: Alignment.center,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  child: const Text('Message Now',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)))))
                    ],
                  ),
                  // child: Text('House Name: ${data.docs[index]['name']}\nLocation: ${data.docs[index]['location']}\ncategory:${data.docs[index]['category']}\ngender: ${data.docs[index]['gender']}\n'),
                );
              }),
            );
          },
        ),
      ),
 */