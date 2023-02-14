import 'package:flutter/material.dart';

class DropdownTextField extends StatefulWidget {
  @override
  _DropdownTextFieldState createState() => _DropdownTextFieldState();
}

class _DropdownTextFieldState extends State<DropdownTextField> {
  bool isExpanded = false;
  String dropdownValue = 'Select';

  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
      appBar: AppBar(

      ),
      body: 
      Center(
        child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0.0, 1.0),
            blurRadius: 2.0,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Search',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    // Search logic here
                  },
                ),
              ),
            ),
          ),
          Container(
            height: isExpanded ? 200 : 0,
            child: ListView(
              children: [
                ListTile(
                  title: Text('Option 1'),
                  onTap: () {
                    setState(() {
                      dropdownValue = 'Option 1';
                      isExpanded = false;
                    });
                  },
                ),
                ListTile(
                  title: Text('Option 2'),
                  onTap: () {
                    setState(() {
                      dropdownValue = 'Option 2';
                      isExpanded = false;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    )
      ),
    );
  }
}




// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';


// class Form_2 extends StatefulWidget {
//   const Form_2({super.key});

//   @override
//   State<Form_2> createState() => _Form_2State();
  
// }

// class _Form_2State extends State<Form_2> {

//   late String selectedValue1;


//    @override
//   void initState() {
//     super.initState();
//     selectedValue1 = '';

//   }
  
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.purple,
//         actions: [
//           Center(
//             child: Row(
//               children: const [
//                 CircleAvatar(
//                   radius: 25,
//                   backgroundImage: AssetImage('assets/images/avater.jpg'),
//                 )
//               ],
//             ),
//           )
//         ],
//       ),
//       body: 
//       SingleChildScrollView(
//         child:Center(
//           child: Column(
//           children: [
//             TextFormField(
//           decoration: InputDecoration(
//             border: UnderlineInputBorder(),
//             label: Text('category'),
//             hintText: 'Select one',
//             suffixIcon: StreamBuilder<QuerySnapshot>(
//               stream: FirebaseFirestore.instance.collection('category').snapshots(),
//               builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//                 if (!snapshot.hasData) {
//                   return CircularProgressIndicator();
//                 }
//                 List<String> items = [];
//                 for (var doc in snapshot.data!.docs) {
//                   items.add(doc['name']);
//                 }
//                 if (selectedValue1 == '' && items.isNotEmpty) {
//                   selectedValue1 = items[0];
//                 }
//                 return DropdownButton(
//                   hint: Text('select value'),
                  
//                   items: items.map((item) {
//                     return DropdownMenuItem(
//                       value: item,
//                       child: Text(item),
//                     );
//                   }).toList(),
//                   onChanged: (value) {
//                     setState(() {
//                       selectedValue1 = value!;
//                     });
//                   },
//                   value: selectedValue1,
//                 );
//               },
//             ),
//           ),
//         ),
//         // TextField(
//         //   decoration: InputDecoration(
//         //     suffixIcon: StreamBuilder<QuerySnapshot>(
//         //       stream: FirebaseFirestore.instance.collection('bedroom').snapshots(),
//         //       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         //         if (!snapshot.hasData) {
//         //           return CircularProgressIndicator();
//         //         }
//         //         List<String> items = [];
//         //         for (var doc in snapshot.data!.docs) {
//         //           items.add(doc['number']);
//         //         }
//         //         if (selectedValue2 == '' && items.isNotEmpty) {
//         //           selectedValue2 = items[0];
//         //         }
//         //         return DropdownButton(
//         //           items: items.map((item) {
//         //             return DropdownMenuItem(
//         //               value: item,
//         //               child: Text(item),
//         //             );
//         //           }).toList(),
//         //           onChanged: (value) {
//         //             setState(() {
//         //               selectedValue2 = value!;
//         //             });
//         //           },
//         //           value: selectedValue2,
//         //         );
//         //       },
//         //     ),
//         //   ),
//         // ),
        
//         //    StreamBuilder<QuerySnapshot>(
//         //       stream: FirebaseFirestore.instance.collection('location').snapshots(),
//         //       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         //         if (!snapshot.hasData) {
//         //           return CircularProgressIndicator();
//         //         }
//         //         List<String> items = [];
//         //         for (var doc in snapshot.data!.docs) {
//         //           items.add(doc['name']);
//         //         }
//         //         if (selectedValue3 == '' && items.isNotEmpty) {
//         //           selectedValue3 = items[1];
//         //         }
//         //         return DropdownButtonFormField(
//         //           hint: Text("Select an option"),
//         //           items: items.map((item) {
//         //             return DropdownMenuItem(
//         //               value: item,
//         //               child: Text(item),
//         //             );
//         //           }).toList(),
//         //           onChanged: (value) {
//         //             setState(() {
//         //               selectedValue3 = value!;
//         //             });
//         //           },
//         //           value: selectedValue3,
//         //         );
//         //       },
//         //     ),
          
        
//           ],
//         ),
//         ) 
//       )
//       ,
//     );
//   }
// }