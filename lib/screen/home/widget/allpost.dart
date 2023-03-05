import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:house_an_apartement/firebase/house_details_page.dart';
import 'package:house_an_apartement/screen/detail/widget/house_details.dart';

class AllPost extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return Column(
    //     children: [
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.start,
    //         children: const [
    //           Text(
    //             'All Post',
    //           ),
    //         ],
    //       ),
    //       const SizedBox(
    //         height: 20,
    //       ),
    //       Center(
    //         child:
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: ((context, index) => GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => House_Details(
                          data: snapshot.data!.docs[index],
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 187, 187, 187),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(width: 10),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Text(
                                    snapshot.data!.docs[index]['name'],
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Text(
                                    snapshot.data!.docs[index]['name'],
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                          ],
                        )),
                  ),
                )),
          );
        } else {
          return Container();
        }
      }),
    );
    //     ),
    //   ],
    // );
  }
}
