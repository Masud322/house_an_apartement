import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:house_an_apartement/chat/chatroom.dart';

class UserList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('user_profile')
            .where('email', isNotEqualTo: currentUser!.email)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          List<DocumentSnapshot> docs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> data =
                  docs[index].data() as Map<String, dynamic>;

              return ListTile(
                title: Text(data['name']),
                subtitle: Text(data['email']),
                onTap: () {
                  // Navigate to the chat room screen with the selected user
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatRoom(
                        recipientId: docs[index].id, data: data,
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

