import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:house_an_apartement/firebase/uplode_image.dart';

class Location extends StatefulWidget {
  final String text1;
  final String text2;
  final String text3;
  final String? text4;
  final String? text5;
  final String? text6;
  final String? text7;
  final String? text8;
  final String? text9;
  final String? text10;
  final String text11;
  String? _selectedDivision;
  String? _selectedDistrict;
  String? _selectedArea;

  Location({
    super.key,
    required this.text1,
    required this.text2,
    required this.text3,
    required this.text4,
    required this.text5,
    required this.text6,
    required this.text7,
    required this.text8,
    required this.text9,
    required this.text10,
    required this.text11,
  });

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location Page'),
      ),
      body: Column(
        children: [
          Form(
              key: _formKey,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      'Select Location',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 25, right: 25, top: 10, bottom: 10),
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
                          value: widget._selectedDivision,
                          items: divisionItems,
                          onChanged: (value) {
                            setState(() {
                              widget._selectedDivision = value;
                              widget._selectedDistrict = null;
                              widget._selectedArea = null;
                            });
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                            prefixIcon: Icon(Icons.location_searching),
                            labelText: 'Division',
                          ),
                          validator: (value) {
                            if (value == null) {
                              return 'Please select a division';
                            }
                            return null;
                          },
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 25, right: 25, top: 10, bottom: 10),
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('Districts')
                          .where('division',
                              isEqualTo: widget._selectedDivision)
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
                          value: widget._selectedDistrict,
                          items: districtItems,
                          onChanged: (value) {
                            setState(() {
                              widget._selectedDistrict = value;
                              widget._selectedArea = null;
                            });
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                            prefixIcon: Icon(Icons.location_on),
                            labelText: 'District',
                          ),
                          validator: (value) {
                            if (value == null) {
                              return 'Please select a district';
                            }
                            return null;
                          },
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 25, right: 25, top: 10, bottom: 10),
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('Areas')
                          .where('district',
                              isEqualTo: widget._selectedDistrict)
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
                          value: widget._selectedArea,
                          items: areaItems,
                          onChanged: (value) {
                            setState(() {
                              widget._selectedArea = value;
                            });
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                            prefixIcon: Icon(Icons.location_pin),
                            labelText: 'Area',
                          ),
                          validator: (value) {
                            if (value == null) {
                              return 'Please select a area';
                            }
                            return null;
                          },
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 250, top: 10),
                    child: ElevatedButton(
                      onPressed: () {
                        print('ok');
                        if (_formKey.currentState!.validate()) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Uplode_Image(
                                text1: widget.text1,
                                text2: widget.text2,
                                text3: widget.text3,
                                text4: widget.text4,
                                text5: widget.text5,
                                text6: widget.text6,
                                text7: widget.text7,
                                text8: widget.text8,
                                text9: widget.text9,
                                text10: widget.text10,
                                text11: widget.text11,
                                text12: widget._selectedDivision,
                                text13: widget._selectedDistrict,
                                text14: widget._selectedArea,
                              ),
                            ),
                          );
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.purple),
                        // Change the color to the desired color
                      ),
                      child: const Text(
                        'NEXT>>>',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
