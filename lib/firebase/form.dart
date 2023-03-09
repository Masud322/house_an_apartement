import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:house_an_apartement/firebase/test.dart';
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

  String? _selectedDivision;
  String? _selectedDistrict;
  String? _selectedArea;
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
      body: 
      
      
      Form(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  const Padding(padding: EdgeInsets.all(15),
                  child: Text('Create Post',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.purple,),),),
                  Padding(
                    padding: const EdgeInsets.only(left: 25,right: 25,top: 10,bottom: 10),
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
                    padding: const EdgeInsets.only(left: 25,right: 25,top: 10,bottom: 10),
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('Divisions')
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return const CircularProgressIndicator();
                        }

                        final List<DropdownMenuItem<String>> divisionItems = [];
                        snapshot.data!.docs.forEach((divisionDoc) {
                          final String divisionName = divisionDoc['name'];
                          divisionItems.add(
                            DropdownMenuItem(
                              value: divisionName,
                              child: Text(divisionName),
                            ),
                          );
                        });

                        return DropdownButtonFormField<String>(
                          value: _selectedDivision,
                          items: divisionItems,
                          onChanged: (value) {
                            setState(() {
                              _selectedDivision = value;
                              _selectedDistrict = null;
                              _selectedArea = null;
                            });
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                            labelText: 'Division',
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25,right: 25,top: 10,bottom: 10),
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('Districts')
                          .where('division', isEqualTo: _selectedDivision)
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return const CircularProgressIndicator();
                        }

                        final List<DropdownMenuItem<String>> districtItems = [];
                        snapshot.data!.docs.forEach((districtDoc) {
                          final String districtName = districtDoc['name'];
                          districtItems.add(
                            DropdownMenuItem(
                              value: districtName,
                              child: Text(districtName),
                            ),
                          );
                        });

                        return DropdownButtonFormField<String>(
                          value: _selectedDistrict,
                          items: districtItems,
                          onChanged: (value) {
                            setState(() {
                              _selectedDistrict = value;
                              _selectedArea = null;
                            });
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                            labelText: 'District',
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25,right: 25,top: 10,bottom: 10),
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('Areas')
                          .where('district', isEqualTo: _selectedDistrict)
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return const CircularProgressIndicator();
                        }

                        final List<DropdownMenuItem<String>> areaItems = [];
                        snapshot.data!.docs.forEach((areaDoc) {
                          final String areaName = areaDoc['name'];
                          areaItems.add(
                            DropdownMenuItem(
                              value: areaName,
                              child: Text(areaName),
                            ),
                          );
                        });

                        return DropdownButtonFormField<String>(
                          value: _selectedArea,
                          items: areaItems,
                          onChanged: (value) {
                            setState(() {
                              _selectedArea = value;
                            });
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                            labelText: 'Area',
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: 25,right: 25,top: 10,bottom: 10),
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
                      padding: const EdgeInsets.only(left: 25,right: 25,top: 10,bottom: 10),
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
                        padding: const EdgeInsets.only(left: 25,right: 10,top: 10,bottom: 10),
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
                        padding: const EdgeInsets.only(left: 10,right: 22,top: 10,bottom: 10),
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
                        padding: const EdgeInsets.only(left: 25,right: 10,top: 10,bottom: 10),
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
                        padding: const EdgeInsets.only(left: 10,right: 22,top: 10,bottom: 10),
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
                        padding: const EdgeInsets.only(left: 25,right: 25,top: 10,bottom: 10),
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
                      padding: const EdgeInsets.only(left: 25,right: 25,top: 10,bottom: 10),
                      child: TextFormField(
                        keyboardType: TextInputType.phone,
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
                    padding: const EdgeInsets.only(left: 25,right: 25,top: 10,bottom: 10),
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
                          'division': _selectedDivision,
                          'district': _selectedDistrict,
                          'area': _selectedArea,
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
                                      child: const Text(
                                        "okay",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ));
                      },
                      child: const Text('Submit'))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
