import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:house_an_apartement/screen/home/home_page.dart';
import 'package:image_picker/image_picker.dart';

class DropdownExample extends StatefulWidget {
  const DropdownExample({super.key});

  @override
  State<DropdownExample> createState() => _DropdownExampleState();
}

class _DropdownExampleState extends State<DropdownExample> {
  // final ImagePicker _picker = ImagePicker();
  // final List<XFile>? images = await _picker.pickMultiImage();

  late String selectedValue1;
  late String selectedValue2;
  late String selectedValue3;
  late String selectedValue4;
  late String selectedValue5;
  late String selectedValue6;
  late String selectedValue7;
  late String selectedValue8;
  late String textvalue1;
  late String textvalue2;
  late String textvalue3;

  @override
  void initState() {
    super.initState();
    selectedValue1 = '';
    selectedValue2 = '';
    selectedValue3 = '';
    selectedValue4 = '';
    selectedValue5 = '';
    selectedValue6 = '';
    selectedValue7 = '';
    selectedValue8 = '';
  }

  final users = FirebaseFirestore.instance.collection("users");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
      ),
      body: Form(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        hintText: 'Write your home name',
                        labelText: 'Home Name',
                      ),
                      onChanged: (value) {
                        textvalue1 = value;
                      },
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('location')
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return const CircularProgressIndicator();
                          }
                          List<String> items = [];
                          for (var doc in snapshot.data!.docs) {
                            items.add(doc['name']);
                          }
                          if (selectedValue1 == '' && items.isNotEmpty) {
                            selectedValue1 = items[0];
                          }
                          return DropdownButtonFormField(
                            decoration: InputDecoration(
                                label: const Text('Select Location'),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                )),
                            items: items.map((item) {
                              return DropdownMenuItem(
                                value: item,
                                child: Text(item),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedValue1 = value!;
                              });
                            },
                            value: selectedValue1,
                          );
                        },
                      )),
                  Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('category')
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return const CircularProgressIndicator();
                          }
                          List<String> items = [];
                          for (var doc in snapshot.data!.docs) {
                            items.add(doc['name']);
                          }
                          if (selectedValue2 == '' && items.isNotEmpty) {
                            selectedValue2 = items[0];
                          }
                          return DropdownButtonFormField(
                            decoration: InputDecoration(
                                label: const Text('Select catrgory'),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                )),
                            items: items.map((item) {
                              return DropdownMenuItem(
                                value: item,
                                child: Text(item),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedValue2 = value!;
                              });
                            },
                            value: selectedValue2,
                          );
                        },
                      )),
                  Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('gender')
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return const CircularProgressIndicator();
                          }
                          List<String> items = [];
                          for (var doc in snapshot.data!.docs) {
                            items.add(doc['name']);
                          }
                          if (selectedValue3 == '' && items.isNotEmpty) {
                            selectedValue3 = items[0];
                          }
                          return DropdownButtonFormField(
                            decoration: InputDecoration(
                                label: const Text('Gender'),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                )),
                            items: items.map((item) {
                              return DropdownMenuItem(
                                value: item,
                                child: Text(item),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedValue3 = value!;
                              });
                            },
                            value: selectedValue3,
                          );
                        },
                      )),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: 200,
                    child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('bedroom')
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData) {
                              return const CircularProgressIndicator();
                            }
                            List<String> items = [];
                            for (var doc in snapshot.data!.docs) {
                              items.add(doc['number']);
                            }
                            if (selectedValue4 == '' && items.isNotEmpty) {
                              selectedValue4 = items[0];
                            }
                            return DropdownButtonFormField(
                              decoration: InputDecoration(
                                  label: const Text('Select bedroom'),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  )),
                              items: items.map((item) {
                                return DropdownMenuItem(
                                  value: item,
                                  child: Text(item),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedValue4 = value!;
                                });
                              },
                              value: selectedValue4,
                            );
                          },
                        )),
                  ),
                  SizedBox(
                    width: 200,
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('bathroom')
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData) {
                              return const CircularProgressIndicator();
                            }
                            List<String> items = [];
                            for (var doc in snapshot.data!.docs) {
                              items.add(doc['number']);
                            }
                            if (selectedValue5 == '' && items.isNotEmpty) {
                              selectedValue5 = items[0];
                            }
                            return DropdownButtonFormField(
                              decoration: InputDecoration(
                                  label: const Text('Select bathroom'),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  )),
                              items: items.map((item) {
                                return DropdownMenuItem(
                                  value: item,
                                  child: Text(item),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedValue5 = value!;
                                });
                              },
                              value: selectedValue5,
                            );
                          },
                        )),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: 200,
                    child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('kitchen')
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData) {
                              return const CircularProgressIndicator();
                            }
                            List<String> items = [];
                            for (var doc in snapshot.data!.docs) {
                              items.add(doc['number']);
                            }
                            if (selectedValue6 == '' && items.isNotEmpty) {
                              selectedValue6 = items[0];
                            }
                            return DropdownButtonFormField(
                              decoration: InputDecoration(
                                  label: const Text('Select kitchen'),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  )),
                              items: items.map((item) {
                                return DropdownMenuItem(
                                  value: item,
                                  child: Text(item),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedValue6 = value!;
                                });
                              },
                              value: selectedValue6,
                            );
                          },
                        )),
                  ),
                  SizedBox(
                    width: 200,
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('parking')
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData) {
                              return const CircularProgressIndicator();
                            }
                            List<String> items = [];
                            for (var doc in snapshot.data!.docs) {
                              items.add(doc['number']);
                            }
                            if (selectedValue7 == '' && items.isNotEmpty) {
                              selectedValue7 = items[0];
                            }
                            return DropdownButtonFormField(
                              decoration: InputDecoration(
                                  label: const Text('Parking'),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  )),
                              items: items.map((item) {
                                return DropdownMenuItem(
                                  value: item,
                                  child: Text(item),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedValue7 = value!;
                                });
                              },
                              value: selectedValue7,
                            );
                          },
                        )),
                  ),
                ],
              ),
              Column(
                children: [
                  SizedBox(
                    child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('free month')
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData) {
                              return const CircularProgressIndicator();
                            }
                            List<String> items = [];
                            for (var doc in snapshot.data!.docs) {
                              items.add(doc['name']);
                            }
                            if (selectedValue8 == '' && items.isNotEmpty) {
                              selectedValue8 = items[0];
                            }
                            return DropdownButtonFormField(
                              decoration: InputDecoration(
                                  label: const Text('Free Month'),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  )),
                              items: items.map((item) {
                                return DropdownMenuItem(
                                  value: item,
                                  child: Text(item),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedValue8 = value!;
                                });
                              },
                              value: selectedValue8,
                            );
                          },
                        )),
                  ),

                  SizedBox(
                    width: 200,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          hintText: 'Price',
                          labelText: 'Rent Price',
                        ),
                        onChanged: (value) {
                          textvalue2 = value;
                        },
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   width: 200,
                  //   child: Padding(
                  //       padding: const EdgeInsets.all(12.0),
                  //       child: images
                  //     ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextFormField(
                      minLines: 1,
                      maxLines: 50,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        hintText: 'Write Here',
                        labelText: 'About',
                      ),
                      onChanged: (value) {
                        textvalue3 = value;
                      },
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        await users.add({
                          'name': textvalue1,
                          'price': textvalue2,
                          'about': textvalue3,
                          'location': selectedValue1,
                          'category': selectedValue2,
                          'gender': selectedValue3,
                          'bedroom': selectedValue4,
                          'bathroom': selectedValue5,
                          'kitchen': selectedValue6,
                          'parking': selectedValue7,
                          'free month': selectedValue8,
                        }).then((value) => showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: const Text("....Completed...."),
                                content: const Text(
                                    "Your details are successfully submitted "),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HomePage()),
                                      );
                                    },
                                    child: Container(
                                      color: Colors.blue,
                                      padding: const EdgeInsets.all(12),
                                      child: const Text("okay",style: TextStyle(color: Colors.black),),
                                    ),
                                  ),
                                ],
                              ),
                            ));
                      },
                      child: Text('Submit'))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
