import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:house_an_apartement/firebase/location.dart';

class Form_Page extends StatefulWidget {
  Form_Page({super.key});

  @override
  State<Form_Page> createState() => _Form_PageState();
}

class _Form_PageState extends State<Form_Page> {
  final TextEditingController housenameController = TextEditingController();

  final TextEditingController priceController = TextEditingController();

  final TextEditingController aboutController = TextEditingController();

  final TextEditingController numberController = TextEditingController();

  String? _selectedValue1;

  String? _selectedValue2;

  String? _selectedValue3;

  String? _selectedValue4;

  String? _selectedValue5;

  String? _selectedValue6;

  String? _selectedValue7;

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text('Form Page'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(15),
                      child: Text(
                        'Create Post',
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
                      child: TextFormField(
                        controller: housenameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your house name';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'House Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          hintText: 'Write your house Name',
                          prefixIcon: const Icon(Icons.house_rounded),
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 25, right: 25, top: 10, bottom: 10),
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
                            if (_selectedValue1 == '' && items.isNotEmpty) {
                              _selectedValue1 = items[0];
                            }
                            return DropdownButtonFormField(
                              decoration: InputDecoration(
                                  label: const Text('Select catrgory'),
                                  prefixIcon: const Icon(Icons.category),
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
                                  _selectedValue1 = value!;
                                });
                              },
                              value: _selectedValue1,
                            );
                          },
                        )),
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 25, right: 25, top: 10, bottom: 10),
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
                            if (_selectedValue2 == '' && items.isNotEmpty) {
                              _selectedValue2 = items[0];
                            }
                            return DropdownButtonFormField(
                              decoration: InputDecoration(
                                  label: const Text('Requirement'),
                                  helperText: 'Male/Female/Nothing',
                                  prefixIcon: const Icon(Icons.transgender),
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
                                  _selectedValue2 = value!;
                                });
                              },
                              value: _selectedValue2,
                            );
                          },
                        )),
                    Row(
                      children: [
                        SizedBox(
                          width: 200,
                          child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 25, right: 10, top: 10, bottom: 10),
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
                                  if (_selectedValue3 == '' &&
                                      items.isNotEmpty) {
                                    _selectedValue3 = items[0];
                                  }
                                  return DropdownButtonFormField(
                                    decoration: InputDecoration(
                                        label: const Text('Select bedroom'),
                                        prefixIcon: const Icon(Icons.bed),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        )),
                                    items: items.map((item) {
                                      return DropdownMenuItem(
                                        value: item,
                                        child: Text(item),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedValue3 = value!;
                                      });
                                    },
                                    value: _selectedValue3,
                                  );
                                },
                              )),
                        ),
                        SizedBox(
                          width: 200,
                          child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 22, top: 10, bottom: 10),
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
                                  if (_selectedValue4 == '' &&
                                      items.isNotEmpty) {
                                    _selectedValue4 = items[0];
                                  }
                                  return DropdownButtonFormField(
                                    decoration: InputDecoration(
                                        label: const Text('Select bathroom'),
                                        prefixIcon: const Icon(Icons.bathroom),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        )),
                                    items: items.map((item) {
                                      return DropdownMenuItem(
                                        value: item,
                                        child: Text(item),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedValue4 = value!;
                                      });
                                    },
                                    value: _selectedValue4,
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
                              padding: const EdgeInsets.only(
                                  left: 25, right: 10, top: 10, bottom: 10),
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
                                  if (_selectedValue5 == '' &&
                                      items.isNotEmpty) {
                                    _selectedValue5 = items[0];
                                  }
                                  return DropdownButtonFormField(
                                    decoration: InputDecoration(
                                        label: const Text('Select kitchen'),
                                        prefixIcon: const Icon(Icons.kitchen),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        )),
                                    items: items.map((item) {
                                      return DropdownMenuItem(
                                        value: item,
                                        child: Text(item),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedValue5 = value!;
                                      });
                                    },
                                    value: _selectedValue5,
                                  );
                                },
                              )),
                        ),
                        SizedBox(
                          width: 200,
                          child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 22, top: 10, bottom: 10),
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
                                  if (_selectedValue6 == '' &&
                                      items.isNotEmpty) {
                                    _selectedValue6 = items[0];
                                  }
                                  return DropdownButtonFormField(
                                    decoration: InputDecoration(
                                        label: const Text('Parking'),
                                        prefixIcon: const Icon(
                                            Icons.local_parking_sharp),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        )),
                                    items: items.map((item) {
                                      return DropdownMenuItem(
                                        value: item,
                                        child: Text(item),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedValue6 = value!;
                                      });
                                    },
                                    value: _selectedValue6,
                                  );
                                },
                              )),
                        ),
                      ],
                    ),
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 25, right: 25, top: 10, bottom: 10),
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
                            if (_selectedValue7 == '' && items.isNotEmpty) {
                              _selectedValue7 = items[0];
                            }
                            return DropdownButtonFormField(
                              decoration: InputDecoration(
                                label: const Text('Free Month'),
                                prefixIcon: const Icon(Icons.start),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              items: items.map((item) {
                                return DropdownMenuItem(
                                  value: item,
                                  child: Text(item),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _selectedValue7 = value!;
                                });
                              },
                              value: _selectedValue7,
                            );
                          },
                        )),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 25, right: 25, top: 10, bottom: 10),
                      child: TextFormField(
                        controller: priceController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your Price';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: 'Price',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          hintText: 'Rent Price',
                          prefixIcon: const Icon(Icons.price_check),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 25, right: 25, top: 10, bottom: 10),
                      child: TextFormField(
                        controller: numberController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Input contact number';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.phone,
                        maxLength: 11,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.phone),
                          labelText: 'Contact Number',
                          prefix: const Text(
                            '+88 ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          hintText: 'Number',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 25, right: 25, top: 10, bottom: 10),
                      child: TextFormField(
                        controller: aboutController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Write something about your house';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.details),
                          labelText: 'About',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          hintText: 'About',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 250),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Location(
                                  text1: housenameController.text,
                                  text2: priceController.text,
                                  text3: numberController.text,
                                  text11: aboutController.text,
                                  text4: _selectedValue1,
                                  text5: _selectedValue2,
                                  text6: _selectedValue3,
                                  text7: _selectedValue4,
                                  text8: _selectedValue5,
                                  text9: _selectedValue6,
                                  text10: _selectedValue7,
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
      ),
    );
  }
}
